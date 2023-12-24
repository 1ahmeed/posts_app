import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/feature/posts/data/data_source/post_local_data_source.dart';
import 'package:posts_app/feature/posts/data/data_source/post_remote_data_source.dart';
import 'package:posts_app/feature/posts/data/model/post_model.dart';
import 'package:posts_app/feature/posts/domain/entity/post_entity.dart';
import 'package:posts_app/feature/posts/domain/repo/post_repo.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();
class PostRepoImpl implements PostsRepo {
  final PostRemoteDataSource postRemoteDataSource;
  final NetworkInfo networkInfo;
  final PostLocalDataSource postLocalDataSource;

  PostRepoImpl({
    required this.postRemoteDataSource,
    required this.postLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getCachePosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPosts({required PostEntity postEntity}) async {
    final PostModel postModel = PostModel(
         title: postEntity.title, body: postEntity.body);
    return await _getMessage(() => postRemoteDataSource.addPosts(postModel: postModel));

  }

  @override
  Future<Either<Failure, Unit>> deletePosts({required int postId}) async {
    return await _getMessage(() => postRemoteDataSource.deletePosts(postId: postId));

  }

  @override
  Future<Either<Failure, Unit>> updatePosts({required PostEntity postEntity}) async {
    final PostModel postModel = PostModel(
        id: postEntity.id, title: postEntity.title, body: postEntity.body);
    return await _getMessage(
        () => postRemoteDataSource.updatePosts(postModel: postModel));
  }



  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        // await postRemoteDataSource.updatePosts(postModel: postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
