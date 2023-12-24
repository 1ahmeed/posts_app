import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/feature/posts/domain/entity/post_entity.dart';
import 'package:posts_app/feature/posts/domain/use_case/add_post_use_case.dart';
import 'package:posts_app/feature/posts/domain/use_case/delete_post_use_case.dart';
import 'package:posts_app/feature/posts/domain/use_case/update_post_use_case.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failuers_string.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/strings/messages.dart';



part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  AddDeleteUpdatePostBloc(
      {required this.addPostUseCase,
        required this.deletePostUseCase,
        required this.updatePostUseCase})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await addPostUseCase(postEntity: event.post);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await updatePostUseCase(postEntity: event.post);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await deletePostUseCase(postId: event.postId);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
          (failure) => ErrorAddDeleteUpdatePostState(
        message: _mapFailureToMessage(failure),
      ),
          (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UN_EXPECTED_FAILURE_MESSAGE;
    }
  }
}