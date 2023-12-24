import 'package:flutter/material.dart';
import 'package:posts_app/feature/posts/domain/entity/post_entity.dart';
import 'package:posts_app/feature/posts/presentation/widget/post_detail_widget/update_post_btn.dart';

import 'delete_post_btn.dart';



class PostDetailWidget extends StatelessWidget {
  final PostEntity post;
  const PostDetailWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            post.body!,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(
            height: 50,
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.id!)
            ],
          )
        ],
      ),
    );
  }
}