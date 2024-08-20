import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/widgets/shopping_cart.dart';
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
                              Color(0xFF4B4CED),
                              Colors.blue,
                            ],
                          ),
                        ),
                        child: Transform.rotate(
                          angle: -0.985398, // -45 degrees in radians
                          origin: const Offset(-150, 200),
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
                          effect: const ExpandingDotsEffect(
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                    const SizedBox(
                      width: 45,
                    ),
                    const Text(
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
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:Color(0xFF323B4F),
                            borderRadius: BorderRadius.circular(15), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1), // Red shadow
                                blurRadius: 5,
                                offset: Offset(-5, -3), // Shadow on top-left
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2), // Green shadow
                                blurRadius: 10,
                                offset: Offset(5, 5), // Shadow on bottom-right
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child:  Text(
                              'Description',
                              style: TextStyle(color: Color(0xFF3D9CEA),fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), // Rounded corners
                            color: Color(0xFF28303F), // Button background color
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15), // Match the outer container
                            child: Stack(
                              children: [
                                // Inset shadow effect
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.2),
                                          blurRadius: 50,
                                          offset: Offset(-55, -55),
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 20,
                                          offset: Offset(35, 40),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Specification',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )





                  ,
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
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>  ShoppingCart(),
                              ),
                            );
                          },
                          child: Container(
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
                        ),
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

