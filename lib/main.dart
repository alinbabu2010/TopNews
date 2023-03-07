import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_news/provider/news_provider.dart';
import 'package:top_news/screens/list_screen.dart';
import 'package:top_news/utils/constants.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MaterialApp(
        title: Constants.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NewsListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
