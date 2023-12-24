import 'package:flutter/material.dart';
import 'package:posts_app/feature/posts/domain/entity/post_entity.dart';

import '../../screens/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final PostEntity post;
  const UpdatePostBtnWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostAddUpdatePage(
                isUpdatePost: true,
                post: post,
              ),
            ));
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}
