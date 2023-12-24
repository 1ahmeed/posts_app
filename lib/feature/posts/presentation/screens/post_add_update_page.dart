import 'package:posts_app/feature/posts/domain/entity/post_entity.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/feature/posts/presentation/screens/posts_screen.dart';

import '../../../../core/utils/show_snack_bar.dart';
import '../../../../core/widget/loading_widget.dart';
import '../bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import '../widget/post_add_update_widgets/form_widget.dart';


class PostAddUpdatePage extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child:
          BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage.showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                        (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                SnackBarMessage.showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const LoadingWidget();
              }
              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          )),
    );
  }
}