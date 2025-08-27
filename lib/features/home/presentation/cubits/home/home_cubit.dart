import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/features/home/data/models/create_post_model.dart';
import 'package:sawa/features/home/domain/repositories/home_repository.dart';

import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final IHomeRepository _iHomeRepository;

  HomeCubit(this._iHomeRepository) : super(const HomeInitState());

  Future<void> createPost({required CreatePostModel createPostModel}) async {
    emit(const HomeLoadingState());

    final result = await _iHomeRepository.createPost(
      createPostModel: createPostModel,
    );

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (_) => emit(const HomeCreatePostSuccessState()),
    );
  }

  Future<void> getDefaultPosts() async {
    emit(const HomeLoadingState());
    final result = await _iHomeRepository.getDefaultPosts();

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (posts) => emit(HomeGetDefaultPostsState(posts)),
    );
  }

  Future<void> deletePost(String postId) async {
    final result = await _iHomeRepository.deletePost(postId: postId);

    result.when(
      failure: (failure) => emit(HomeFailureState(failure.code)),
      success: (_) => emit(const HomeDeletePostSuccessState()),
    );
  }
}
