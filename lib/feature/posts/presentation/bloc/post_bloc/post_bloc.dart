import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/feature/posts/domain/entity/post_entity.dart';
import 'package:posts_app/feature/posts/domain/use_case/get_all_posts_use_case.dart';
import 'package:posts_app/feature/posts/presentation/bloc/post_bloc/post_event.dart';
import 'package:posts_app/feature/posts/presentation/bloc/post_bloc/post_state.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failuers_string.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({
    required this.getAllPostsUseCase,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPostsUseCase();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPostsUseCase();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(
      Either<Failure, List<PostEntity>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(
        posts: posts,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure _:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
