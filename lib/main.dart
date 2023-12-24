import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/app_theme.dart';
import 'package:posts_app/feature/posts/presentation/bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'package:posts_app/feature/posts/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:posts_app/feature/posts/presentation/bloc/post_bloc/post_event.dart';
import 'package:posts_app/feature/posts/presentation/screens/posts_screen.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),),
        BlocProvider(create: (context) => di.sl<AddDeleteUpdatePostBloc>(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home:  const PostsPage(),
      ),
    );
  }
}

