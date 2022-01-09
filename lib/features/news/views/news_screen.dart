import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:business_news/app/theme/app_colors.dart';
import 'package:business_news/app/theme/app_styles.dart';
import 'package:business_news/components/custom_app_bar.dart';

import 'package:business_news/features/news/bloc/news_bloc.dart';
import 'package:business_news/features/news/views/news_detail_screen.dart';
import 'package:business_news/features/news/views/widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    Key? key,
  }) : super(key: key);
  static const String route = '/newsScreenRoute';

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      appBar: buildCustomAppBar(pageTitle: 'Business News'),
      body: BlocConsumer<NewsBloc, NewsState>(
        listener: (context, state) {
          if (state is NewsLoadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(hours: 1),
                backgroundColor: AppColors.greyShade3,
                content: Row(
                  children: [
                    Text(
                      state.errorMessage,
                      style: AppStyle.mediumText14
                          .copyWith(color: AppColors.darkBlueShade1),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
                      },
                      child: Text(
                        'Retry',
                        style: AppStyle.boldText16
                            .copyWith(color: AppColors.darkBlueShade1),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        buildWhen: (previous, current) => current is! NewsLoadFailure,
        builder: (context, state) {
          if (state is NewsLoadSuccess) {
            return ListView.separated(
              controller: _scrollController
                ..addListener(() {
                  if (_scrollController.offset ==
                      _scrollController.position.maxScrollExtent) {
                    BlocProvider.of<NewsBloc>(context).add(LoadMoreNewsEvent());
                  }
                }),
              padding: EdgeInsets.only(top: 16.h),
              separatorBuilder: (BuildContext context, int index) {
                return const ColoredBox(
                  color: AppColors.appWhite,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Divider(thickness: 1.5, height: 2),
                  ),
                );
              },
              itemCount: state.newsList.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.newsList.length) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final news = state.newsList[index];
                  return NewsCard(
                    imageUrl: news.urlToImage ?? '',
                    title: news.title ?? '',
                    source: news.source ?? '',
                    onTapArrow: () {
                      Navigator.of(context).pushNamed(
                        NewsDetailScreen.route,
                        arguments: <String, dynamic>{
                          'index': index,
                          'newsList': state.newsList
                        },
                      );
                    },
                  );
                }
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
