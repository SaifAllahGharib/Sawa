import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/clients/firebase_client.dart';
import '../../../../../core/shared/models/media_item.dart';
import '../../../domain/entities/media_entity.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/entities/post_media_entity.dart';
import '../../../domain/usecases/create_post_usecase.dart';
import '../../../domain/usecases/delete_post_usecase.dart';
import '../../../domain/usecases/upload_post_media_to_table_usecase.dart';
import '../../../domain/usecases/upload_post_media_usecase.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final CreatePostUseCase _createPostUseCase;
  final UploadPostMediaUseCase _uploadPostMediaUseCase;
  final UploadPostMediaToTableUseCase _uploadPostMediaToTableUseCase;
  final DeletePostUseCase _deletePostUseCase;
  final FirebaseClient _firebaseClient;

  HomeCubit(
    this._uploadPostMediaUseCase,
    this._createPostUseCase,
    this._uploadPostMediaToTableUseCase,
    this._deletePostUseCase,
    this._firebaseClient,
  ) : super(const HomeInitState());

  void createPost(PostEntity postEntity, List<MediaItem> pickedAssets) async {
    emit(const HomeLoadingState());
    final result = await _createPostUseCase(postEntity);

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (postId) async {
        if (postId == null) {
          emit(const HomeFailureState('Post creation failed'));
          return;
        }

        if (pickedAssets.isEmpty) {
          emit(const HomeCreatePostSuccessState());
          return;
        }

        await _uploadPostMedia(
          MediaEntity(id: postId, media: pickedAssets),
          postId,
        );
      },
    );
  }

  void deletePost(String uId, String postId) async {
    final result = await _deletePostUseCase([uId, postId]);

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (_) => emit(const HomeDeletePostSuccessState()),
    );
  }

  Future<void> _uploadPostMedia(MediaEntity mediaEntity, String postId) async {
    final result = await _uploadPostMediaUseCase(mediaEntity);

    result.when(
      failure: (failure) {
        deletePost(_firebaseClient.auth.currentUser!.uid, postId);
        emit(const HomeFailureState('Failed to upload media to storage'));
      },
      success: (mediaPaths) async {
        final media = mediaPaths
            .map(
              (e) => PostMediaEntity(
                postId: postId,
                mediaUrl: e,
                mediaType: 'image',
              ),
            )
            .toList();

        _uploadPostMediaToTable(media, postId);
      },
    );
  }

  Future<void> _uploadPostMediaToTable(
    List<PostMediaEntity> postMediaEntities,
    String postId,
  ) async {
    emit(const HomeLoadingState());
    final result = await _uploadPostMediaToTableUseCase(postMediaEntities);

    result.when(
      failure: (failure) {
        deletePost(_firebaseClient.auth.currentUser!.uid, postId);
        emit(const HomeFailureState('Failed to upload media to table'));
      },
      success: (_) => emit(const HomeCreatePostSuccessState()),
    );
  }
}
