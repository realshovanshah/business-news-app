import 'package:flutter/material.dart';
import 'package:business_news/app/theme/app_colors.dart';
import 'package:business_news/app/theme/app_styles.dart';

AppBar buildCustomAppBar({required String pageTitle}) => AppBar(
      backgroundColor: AppColors.appWhite,
      centerTitle: true,
      title: Text(
        pageTitle,
        style: AppStyle.semiBoldText16.copyWith(
          color: AppColors.darkBlueShade2,
        ),
      ),
    );

AppBar buildCustomAppBarWithBack({
  required String pageTitle,
  required BuildContext context,
}) =>
    AppBar(
      backgroundColor: AppColors.appWhite,
      centerTitle: true,
      title: Text(
        pageTitle,
        style: AppStyle.semiBoldText16.copyWith(
          color: AppColors.darkBlueShade2,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.chevron_left_outlined,
          color: AppColors.appBlack,
          size: 24,
        ),
      ),
    );
