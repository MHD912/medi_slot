import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../widgets/onboarding_carousel_item.dart';

final onboardingSlides = <OnBoardingCarouselItem>[
  OnBoardingCarouselItem(
    svgImage: AppAssets.scalable.onboarding1,
    title: AppStrings.onlineHealthCheck,
    description: AppStrings.bookTheBestDoctor,
  ),
  OnBoardingCarouselItem(
    svgImage: AppAssets.scalable.onboarding2,
    title: AppStrings.nearToYou,
    description: AppStrings.scheduleYourVisit,
  ),
];
