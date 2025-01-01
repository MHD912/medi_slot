import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../widgets/category_widget.dart';

final List<Widget> categoryListItems = [
  CategoryWidget(
    assetName: AppAssets.gif.heart,
    categoryName: AppStrings.cardiologist,
    onPressed: () {},
  ),
  CategoryWidget(
    assetName: AppAssets.gif.brain,
    categoryName: AppStrings.psychologist,
    onPressed: () {},
  ),
  CategoryWidget(
    assetName: AppAssets.gif.tooth,
    categoryName: AppStrings.dentist,
    onPressed: () {},
  ),
  CategoryWidget(
    assetName: AppAssets.gif.heart,
    categoryName: AppStrings.cardiologist,
    onPressed: () {},
  ),
  CategoryWidget(
    assetName: AppAssets.gif.brain,
    categoryName: AppStrings.psychologist,
    onPressed: () {},
  ),
];
