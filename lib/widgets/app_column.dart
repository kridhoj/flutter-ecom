import 'package:ecom/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String foodName;
  final double size;

  const AppColumn({super.key, required this.foodName, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: foodName,
          size: size,
        ),
        SizedBox(height: Dimenions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                        size: 15,
                      )),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: '4.5'),
            SizedBox(
              width: 10,
            ),
            SmallText(text: '11'),
            SizedBox(
              width: 5,
            ),
            SmallText(text: 'commnents'),
          ],
        ),
        SizedBox(height: Dimenions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.circle_sharp,
                text: 'Normal',
                color: AppColors.textColor,
                iconColor: AppColors.iconColor1),
            IconAndText(
                icon: Icons.location_pin,
                text: '1.7km',
                color: AppColors.textColor,
                iconColor: AppColors.mainColor),
            IconAndText(
                icon: Icons.access_time_rounded,
                text: '12min',
                color: AppColors.textColor,
                iconColor: AppColors.iconColor1),
          ],
        ),
      ],
    );
  }
}
