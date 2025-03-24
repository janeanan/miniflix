import 'package:flutter/material.dart';
import 'package:miniflix/domain/tmdb_view_model.dart';
import 'package:miniflix/pages/preflix_page.dart';


import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => TmdbViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        home: const MiniFlix()
      ),
    );
  }
}
