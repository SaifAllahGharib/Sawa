import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/usecases/no_params.dart';
import 'package:sawa/features/home/data/models/create_post_model.dart';

import '../../../domain/usecases/create_post_usecase.dart';
import '../../../domain/usecases/delete_post_usecase.dart';
import '../../../domain/usecases/get_default_posts_usecase.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final CreatePostUseCase _createPostUseCase;
  final DeletePostUseCase _deletePostUseCase;
  final GetDefaultPostsUseCase _getDefaultPostsUseCase;

  HomeCubit(
    this._createPostUseCase,
    this._deletePostUseCase,
    this._getDefaultPostsUseCase,
  ) : super(const HomeInitState());

  Future<void> createPost({required CreatePostModel createPostModel}) async {
    emit(const HomeLoadingState());

    final result = await _createPostUseCase(createPostModel);

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (_) => emit(const HomeCreatePostSuccessState()),
    );
  }

  Future<void> getDefaultPosts() async {
    emit(const HomeLoadingState());
    final result = await _getDefaultPostsUseCase(const NoParams());

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (posts) => emit(HomeGetDefaultPostsState(posts)),
    );
  }

  Future<void> deletePost(String postId) async {
    final result = await _deletePostUseCase(postId);

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (_) => emit(const HomeDeletePostSuccessState()),
    );
  }
}
