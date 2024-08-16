import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/colors/colors.dart';
import 'home_widget.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final PageController _pageController = PageController();
  final List<String> images = [
    'assets/images/bicycl.png',
    'assets/images/bicycl.png',
    'assets/images/bicycl.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1F2E),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 400,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.black,
                              Colors.blue,
                            ],
                          ),
                        ),
                        child: Transform.rotate(
                          angle: -0.785398, // -45 degrees in radians
                          origin: Offset(100, -250),
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            images[index],
                            fit: BoxFit
                                .contain, // Fit the image within the container
                          );
                        },
                      ),
                      Positioned(
                        bottom: 20,
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: images.length,
                          effect: ExpandingDotsEffect(
                            dotColor: Colors.white24,
                            activeDotColor: Colors.white,
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 16,
                child: Row(
                  children: [
                    UnicornOutlineButton(
                      onPressed: () {},
                      strokeWidth: 2.w,
                      radius: 10.w,
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.pictonBlue,
                          AppConstants.royalBlue.withOpacity(.7)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: LinearGradient(
                            colors: [
                              AppConstants.pictonBlue,
                              AppConstants.royalBlue.withOpacity(.7)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                          size: 28.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 45,
                    ),
                    Text(
                      'PEUGEOT - LR01',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF2B2F3A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Description',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 16),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Specification',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'PEUGEOT-LR01',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'The LR01 uses the same design as the most iconic bikes from PEUGEOT Cycles\' 130-year history and combines it with agile, dynamic performance that\'s perfectly suited to navigating today\'s cities. As well as a lugged steel frame and iconic PEUGEOT black-and-white chequer design, this city bike also features a 16-speed Shimano Claris drivetrain.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: AppConstants.ebonyClay2,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                          color: Color(0xFF444E65)
                        )),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '\$1,999.99',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  AppConstants.pictonBlue,
                                  AppConstants.royalBlue.withOpacity(.7)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}