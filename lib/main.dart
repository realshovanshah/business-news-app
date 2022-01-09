import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:business_news/app/view/view.dart';
import 'package:business_news/features/news/repository/news_repository.dart';

Future main() async {
  await dotenv.load();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => NewsRepositoryImpl()),
      ],
      child: const MyApp(),
    ),
  );
}
