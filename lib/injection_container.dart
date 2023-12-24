import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';

import 'package:posts_app/feature/posts/data/repo_impl/post_repo_impl.dart';
import 'package:posts_app/feature/posts/domain/repo/post_repo.dart';
import 'package:posts_app/feature/posts/domain/use_case/add_post_use_case.dart';
import 'package:posts_app/feature/posts/domain/use_case/delete_post_use_case.dart';
import 'package:posts_app/feature/posts/domain/use_case/get_all_posts_use_case.dart';
import 'package:posts_app/feature/posts/domain/use_case/update_post_use_case.dart';
import 'package:posts_app/feature/posts/presentation/bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'package:posts_app/feature/posts/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/posts/data/data_source/post_local_data_source.dart';
import 'feature/posts/data/data_source/post_remote_data_source.dart';

final sl = GetIt.instance;


Future<void> init() async {
  ///boc
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
          addPostUseCase: sl(),
          deletePostUseCase:sl(),
          updatePostUseCase:sl(),
      ));

  ///use case
  sl.registerLazySingleton<GetAllPostsUseCase>(() => GetAllPostsUseCase(postsRepo: sl()));
  sl.registerLazySingleton<AddPostUseCase>(() => AddPostUseCase(postsRepo: sl()));
  sl.registerLazySingleton<DeletePostUseCase>(() => DeletePostUseCase(postsRepo: sl()));
  sl.registerLazySingleton<UpdatePostUseCase>(() => UpdatePostUseCase(postsRepo: sl()));


  ///repos
  sl.registerLazySingleton<PostsRepo>(() => PostRepoImpl(
      postRemoteDataSource: sl(),
      postLocalDataSource: sl(),
      networkInfo: sl()));


  ///data source
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(
      sharedPreferences: sl()));
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(
      client: sl()));


  ///core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));


  ///external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());


}
