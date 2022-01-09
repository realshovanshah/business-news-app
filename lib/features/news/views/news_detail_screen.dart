import 'dart:math';

import 'package:flutter/material.dart';
import 'package:business_news/app/theme/app_colors.dart';
import 'package:business_news/components/custom_app_bar.dart';
import 'package:business_news/features/news/models/news_model.dart';
import 'package:business_news/features/news/views/widgets/news_detail_card.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({
    Key? key,
    required this.newsList,
    required this.index,
  }) : super(key: key);

  final List<NewsModel> newsList;
  final int index;
  static const String route = '/newsDetailRoute';

  @override
  Widget build(BuildContext context) {
    final _controller = PageController(initialPage: index);
    return Scaffold(
      appBar: buildCustomAppBarWithBack(
        pageTitle: 'News Detail',
        context: context,
      ),
      body: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final _news = newsList[index];
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Transform.rotate(
              angle: pi / -2,
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.darkBlueShade3,
              ),
            ),
            body: NewsDetailCard(
              newsImage: _news.urlToImage ??
                  'https://www.gizmohnews.com/assets/images/news.png',
              source: _news.source == ''
                  ? 'No source'
                  : _news.source ?? 'No source',
              title: _news.title == '' ? 'No title' : _news.title ?? '',
              content: _news.content == ''
                  ? 'No Content Available'
                  : _news.content ?? 'No Content Available',
              url: _news.url ?? '',
            ),
          );
        },
      ),
    );
  }
}
