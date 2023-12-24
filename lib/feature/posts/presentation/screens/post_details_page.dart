import 'package:flutter/material.dart';
import 'package:posts_app/feature/posts/domain/entity/post_entity.dart';

import '../widget/post_detail_widget/post_details_widget.dart';



class PostDetailPage extends StatelessWidget {
  final PostEntity post;
  const PostDetailPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text("Post Detail"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}