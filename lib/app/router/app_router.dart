import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:business_news/features/news/bloc/news_bloc.dart';
import 'package:business_news/features/news/models/news_model.dart';
import 'package:business_news/features/news/repository/news_repository.dart';
import 'package:business_news/features/news/views/news_detail_screen.dart';
import 'package:business_news/features/news/views/news_screen.dart';

/// Named route set up for the routing of this application.
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NewsDetailScreen.route:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute<void>(
        builder: (context) => NewsDetailScreen(
          index: args?['index'] as int,
          newsList: args?['newsList'] as List<NewsModel>,
        ),
      );
    default:
      return MaterialPageRoute<void>(
        builder: (context) => BlocProvider<NewsBloc>.value(
          value: NewsBloc(newsRepository: context.read<NewsRepository>()),
          child: const NewsScreen(),
        ),
      );
  }
}
