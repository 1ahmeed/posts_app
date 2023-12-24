import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/feature/posts/data/model/post_model.dart';
import 'package:http/http.dart'as http;

abstract class PostRemoteDataSource{
  Future<List<PostModel>>getAllPosts();
  Future<Unit>deletePosts({required int postId});
  Future<Unit>addPosts({required PostModel postModel});
  Future<Unit>updatePosts({required PostModel postModel});
}
const BASE_URL="https://jsonplaceholder.typicode.com/";
class PostRemoteDataSourceImpl implements PostRemoteDataSource{
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts()async {

    final response=await client.get(Uri.parse("${BASE_URL}posts"),
    headers: {
      "Content-Type":"application/json",
    },
    ) ;
    if(response.statusCode==200){
      ///way to get response which be list
      // var responseData=jsonDecode(response.body);
      // List<PostModel> postList=[];
      // for(var item in responseData){
      //  postList.add(PostModel.fromJson(item)) ;
      // }
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postList = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPosts({required PostModel postModel})async {
   final response=await client.post(Uri.parse("${BASE_URL}posts"),
       headers: {
          "Content-Type":"application/json",
       },
     body:jsonEncode({
       "title":postModel.title,
       "body":postModel.body,
     })
   );
   if(response.statusCode==201){
   return Future.value(unit);
   }else{
     throw ServerException();
   }
  }

  @override
  Future<Unit> deletePosts({required int postId})async {
    final response=await client.delete(Uri.parse("${BASE_URL}posts/$postId"),
        headers: {
          "Content-Type":"application/json",
        },
    );
    if(response.statusCode==200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePosts({required PostModel postModel})async {
    final postId=postModel.id;
      final response=await client.put(Uri.parse("${BASE_URL}posts/$postId"),
        headers: {
        "Content-Type": "application/json"
        },
          body:jsonEncode( {
            "title":postModel.title,
            "body":postModel.body,
          })
      );
      if(response.statusCode==200){
        return Future.value(unit);
      }else{
        throw ServerException();
      }


  }

}