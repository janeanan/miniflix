import 'package:flutter/material.dart';

import 'package:miniflix/view/viewmanage.dart';
import 'package:miniflix/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final Map<String, WidgetBuilder> appRoutes = {
      '/': (context) => ViewManage(),
    };

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (createx) => MovieViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: appRoutes,
      ),
    );
  }
}
