import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_colors.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';
import 'package:movies_app/ui/utils/context_extension.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  List<String> categoryName = [
    'Actions',
    'Adventure',
    'Animation',
    'Biography',
  ];
  int selecteButton = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, top: 16),
      height: context.height * 0.06,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryName.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selecteButton = index;
              });
            },
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: selecteButton == index
                    ? AppColors.yellow
                    : Colors.transparent,
                border: Border.all(color: AppColors.yellow, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                categoryName[index],
                style: selecteButton == index
                    ? AppTextStyles.blackBold20
                    : AppTextStyles.yelowBold20,
              ),
            ),
          );
        },
      ),
    );
  }
}
