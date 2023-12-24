import 'package:dartz/dartz.dart';
import 'package:posts_app/feature/posts/domain/entity/post_entity.dart';
import 'package:posts_app/feature/posts/domain/repo/post_repo.dart';

import '../../../../core/error/failure.dart';

class UpdatePostUseCase {
  final PostsRepo postsRepo;

  UpdatePostUseCase({required this.postsRepo});

  Future<Either<Failure, Unit>> call({required PostEntity postEntity}) async {
    return await postsRepo.updatePosts(postEntity: postEntity);
  }
}
