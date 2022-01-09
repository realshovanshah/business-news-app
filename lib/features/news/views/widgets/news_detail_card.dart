import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:business_news/app/theme/app_colors.dart';
import 'package:business_news/app/theme/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailCard extends StatelessWidget {
  const NewsDetailCard({
    Key? key,
    required this.newsImage,
    required this.source,
    required this.title,
    required this.content,
    required this.url,
  }) : super(key: key);

  final String newsImage;
  final String source;
  final String title;
  final String content;
  final String url;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              source,
              style:
                  AppStyle.boldText16.copyWith(color: AppColors.darkBlueShade1),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 150,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      newsImage == ''
                          ? 'https://www.gizmohnews.com/assets/images/news.png'
                          : newsImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 2,
                    color: AppColors.darkBlueShade2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title,
                style: AppStyle.regularText14
                    .copyWith(color: AppColors.darkBlueShade3),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            Text(
              content,
              style: AppStyle.regularText18
                  .copyWith(color: AppColors.darkBlueShade1),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                if (url != '') {
                  launch(url);
                }
              },
              child: Text(
                url != '' ? 'View full content' : '',
                style: AppStyle.boldText14
                    .copyWith(color: AppColors.darkBlueShade1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
