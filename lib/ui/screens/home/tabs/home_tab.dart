import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/home/widgets/carousel_slider_section.dart';
import 'package:movies_app/ui/widgets/custom_movie_image.dart';
import 'package:movies_app/ui/utils/app_assets.dart';
import 'package:movies_app/ui/utils/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<String> images = [
    AppAssets.pic1,
    AppAssets.pic2,
    AppAssets.pic1,
    AppAssets.pic2,
    AppAssets.pic1,
    AppAssets.pic2,
    AppAssets.pic1,
    AppAssets.pic2,
    AppAssets.pic1,
    AppAssets.pic1,
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(images[0]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.8),
                    AppColors.black.withValues(alpha: 0.6),
                    AppColors.black,
                  ],
                ),
              ),
              child: Column(
                spacing: height * 0.01,
                children: [
                  Image.asset(AppAssets.availableNow, height: height * 0.1),
                  Expanded(child: CarouselSliderSection()),
                  Image.asset(AppAssets.watchNow,width: width* 0.76,),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.28,
          child: Column(
            children: [
              seeMoreSection(),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: CustomMovieImage(
                        image: images[index],
                        margin: EdgeInsets.only(left: 16),
                        width: width * 0.32,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02,)
      ],
    );
  }

  Padding seeMoreSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Action',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: (){},
            child: Text(
              'See More',
              style: TextStyle(
                color: AppColors.yellow,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 2),
          Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.yellow,
            size: 15,
          ),
        ],
      ),
    );
  }
}
