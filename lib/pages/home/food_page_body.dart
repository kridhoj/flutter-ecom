import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecom/utils/colors.dart';
import 'package:ecom/utils/dimensions.dart';
import 'package:ecom/widgets/app_column.dart';
import 'package:ecom/widgets/big_text.dart';
import 'package:ecom/widgets/icon_and_text.dart';
import 'package:ecom/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _heightComponent = Dimenions.pageViewContainerHeight;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider section
        Container(
          height: Dimenions.pageViewHeight,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        // dot section
        new DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),

        // Popular Text
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(text: 'Popular'),
            SizedBox(
              width: 5,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2),
              child: BigText(
                text: '.',
                color: AppColors.textColor,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2),
              child: SmallText(text: 'Popular Food'),
            )
          ]),
        ),
        SizedBox(
          height: 30,
        ),
        // List of food and images
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white30,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/image/food1.jpg')),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: 'Nutritious fruit meal from Chinese',
                              size: 16,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SmallText(text: 'With Chinese Characteristic'),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    text: '12cm',
                                    color: AppColors.textColor,
                                    iconColor: AppColors.iconColor1),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        SizedBox(
          height: 40,
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currentScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _heightComponent * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _heightComponent * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currentScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _heightComponent * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentTrans = _heightComponent * (1 - _scaleFactor) / 2;
      matrix = Matrix4.diagonal3Values(1, _scaleFactor, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: _heightComponent,
            margin: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/image/food1.jpg"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 110,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 10.0,
                        offset: Offset(2, 5)),
                    BoxShadow(color: Colors.white)
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimenions.height10, left: 15, right: 15),
                child: AppColumn(
                  foodName: 'Chinese Side',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
