import 'package:finaluri/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/home_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoCubit()),
      ], child: MaterialApp(
      title: 'TODO App',
      //home: HomeScreen(),
      routes: {
        '/' : (context) => HomeScreen(),
        '/todo': (context) => MainScreen()
      },
    )
    );
  }
}
