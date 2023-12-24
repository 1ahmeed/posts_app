
import 'package:dartz/dartz.dart';
import 'package:posts_app/feature/posts/domain/repo/post_repo.dart';

import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';

class GetAllPostsUseCase {

  final PostsRepo postsRepo;

  GetAllPostsUseCase({required this.postsRepo});

  Future<Either<Failure,List<PostEntity>>> call() async{
    return  await postsRepo.getAllPosts();
  }
}