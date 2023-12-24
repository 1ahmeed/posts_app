

import 'package:dartz/dartz.dart';
import 'package:posts_app/feature/posts/domain/repo/post_repo.dart';

import '../../../../core/error/failure.dart';

class DeletePostUseCase{
 final PostsRepo postsRepo;

  DeletePostUseCase({required this.postsRepo});
 Future<Either<Failure,Unit>> call({required int postId})async{
   return await postsRepo.deletePosts(postId: postId);
 }
}