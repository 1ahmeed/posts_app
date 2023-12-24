import 'package:dartz/dartz.dart';
import 'package:posts_app/feature/posts/domain/entity/post_entity.dart';

import '../../../../core/error/failure.dart';

abstract class PostsRepo {
  Future<Either<Failure,List<PostEntity>>>getAllPosts();
  Future<Either<Failure,Unit>>deletePosts({required int postId});
  Future<Either<Failure,Unit>>addPosts({required PostEntity postEntity});
  Future<Either<Failure,Unit>>updatePosts({required PostEntity postEntity});
}
