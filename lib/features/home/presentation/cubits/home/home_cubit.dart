import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/media_item.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_media_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/create_post_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/delete_post_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/upload_post_media_to_table_usecase.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/usecases/upload_post_media_usecase.dart';
import 'package:path/path.dart' as p;

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CreatePostUseCase _createPostUseCase;
  final UploadPostMediaUseCase _uploadPostMediaUseCase;
  final UploadPostMediaToTableUseCase _uploadPostMediaToTableUseCase;
  final DeletePostUseCase _deletePostUseCase;

  HomeCubit(
    this._uploadPostMediaUseCase,
    this._createPostUseCase,
    this._uploadPostMediaToTableUseCase,
    this._deletePostUseCase,
  ) : super(const HomeInitState());

  void createPost(PostEntity postEntity, List<MediaItem> pickedAssets) async {
    emit(const HomeLoadingState());
    final result = await _createPostUseCase(postEntity);

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (postId) async {
        if (postId != null) {
          final files = <Uint8List>[];
          final fileNames = <String>[];

          for (final media in pickedAssets) {
            final file = File(media.path);
            if (await file.exists()) {
              final bytes = await file.readAsBytes();
              final name = p.basename(media.path);
              files.add(bytes);
              fileNames.add(name);
            }
          }

          await _uploadPostMedia(
            MediaEntity(postId: postId, files: files, fileNames: fileNames),
            postId,
          );
        } else {
          emit(const HomeFailureState('Post creation failed'));
        }
      },
    );
  }

  void deletePost(String postId) async {
    final result = await _deletePostUseCase(postId);

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (success) => emit(HomeDeletePostSuccessState(success)),
    );
  }

  Future<void> _uploadPostMedia(MediaEntity mediaEntity, String postId) async {
    final result = await _uploadPostMediaUseCase(mediaEntity);

    result.when(
      failure: (failure) {
        deletePost(postId);
        emit(const HomeFailureState('Failed to upload media to storage'));
      },
      success: (mediaPaths) async {
        _uploadPostMediaToTable(
          mediaPaths
              .map(
                (e) => PostMediaEntity(
                  postId: postId,
                  mediaUrl: e,
                  mediaType: 'image',
                ),
              )
              .toList(),
          postId,
        );
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
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (done) {
        if (done) {
          emit(const HomeCreatePostSuccessState());
        } else {
          deletePost(postId);
          emit(const HomeFailureState('Failed to upload media to table'));
        }
      },
    );
  }
}
