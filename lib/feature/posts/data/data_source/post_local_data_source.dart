import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/feature/posts/data/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{
  Future<List<PostModel>> getCachePosts();
  Future<Unit> cachePosts(List<PostModel> postModel);
}
const CACHED_POST="CACHED_POST";
class PostLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModel) {
    List postModelToJson=postModel.map<Map<String,dynamic>>((postModel){
      return postModel.toJson();
    } ).toList();
    sharedPreferences.setString(CACHED_POST,  json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachePosts() {
    final jsonString=sharedPreferences.getString(CACHED_POST);
    if(jsonString !=null){
      List decodeJsonData= json.decode(jsonString);
      List<PostModel> jsonToPostModel=decodeJsonData.map<PostModel>((jsonPostModel){
        return PostModel.fromJson(jsonPostModel);
      } ).toList();
      return Future.value(jsonToPostModel);

    }else{
      throw EmptyCacheException();
    }

  }

}