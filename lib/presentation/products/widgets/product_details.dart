import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:online_bike_shopping_appuntitled/data/products/models/product_model.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/widgets/shopping_cart.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/colors/colors.dart';
import 'home_widget.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.bike});

  final BikeModel bike;

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppConstants.ebonyClay2,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: const Color(0xFF444E65)),
        ),
        padding: EdgeInsets.all(16.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '\$ ${widget.bike.price}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShoppingCart(
                      bike: widget.bike,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 16.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.pictonBlue,
                      AppConstants.royalBlue.withOpacity(.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1C1F2E),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 400.h,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(16.r)),
                  ),
                  child: ClipRRect(
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
                            child: Container(color: Colors.black),
                          ),
                        ),
                        PageView.builder(
                          controller: _pageController,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 200.h,
                              width: 200.w,
                              child: ModelViewer(
                                src: 'assets/3d_model/scene.gltf',
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 20.h,
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
                  top: 50.h,
                  left: 16.w,
                  child: Row(
                    children: [
                      UnicornOutlineButton(
                        onPressed: () => Navigator.pop(context),
                        strokeWidth: 2.w,
                        radius: 10.w,
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.pictonBlue,
                            AppConstants.royalBlue.withOpacity(.7),
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
                                AppConstants.royalBlue.withOpacity(.7),
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
                      SizedBox(width: 45.w),
                      Text(
                        widget.bike.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFF2B2F3A),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0.h),
                      child: SpecificationDescriptionButtons(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          widget.bike.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text(
                        widget.bike.description ?? "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpecificationDescriptionButtons extends StatefulWidget {
  const SpecificationDescriptionButtons({super.key});

  @override
  _SpecificationDescriptionButtonsState createState() =>
      _SpecificationDescriptionButtonsState();
}

class _SpecificationDescriptionButtonsState
    extends State<SpecificationDescriptionButtons> {
  String _selectedButton = 'Specification';

  void _toggleButton(String button) {
    setState(() {
      _selectedButton = button;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomToggleButton(
          isSelected: _selectedButton == 'Specification',
          onPressed: () => _toggleButton('Specification'),
          initialDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: const Color(0xFF28303F),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 50,
                offset: const Offset(-55, -55),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(35, 40),
              ),
            ],
          ),
          clickedDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: const Color(0xFF323B4F),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(-5, -3),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          initialTextStyle: const TextStyle(color: Colors.grey),
          clickedTextStyle: const TextStyle(
            color: Color(0xFF3D9CEA),
            fontWeight: FontWeight.bold,
          ),
          text: 'Specification',
        ),
        SizedBox(width: 10.w),
        CustomToggleButton(
          isSelected: _selectedButton == 'Description',
          onPressed: () => _toggleButton('Description'),
          initialDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: const Color(0xFF28303F),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 50,
                offset: const Offset(-55, -55),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(35, 40),
              ),
            ],
          ),
          clickedDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFF323B4F),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(-5, -3),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          initialTextStyle: const TextStyle(color: Colors.grey),
          clickedTextStyle: const TextStyle(
            color: Color(0xFF3D9CEA),
            fontWeight: FontWeight.bold,
          ),
          text: 'Description',
        ),
      ],
    );
  }
}

class CustomToggleButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;
  final BoxDecoration initialDecoration;
  final BoxDecoration clickedDecoration;
  final TextStyle initialTextStyle;
  final TextStyle clickedTextStyle;
  final String text;

  const CustomToggleButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.initialDecoration,
    required this.clickedDecoration,
    required this.initialTextStyle,
    required this.clickedTextStyle,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: isSelected ? clickedDecoration : initialDecoration,
        child: Text(
          text,
          style: isSelected ? clickedTextStyle : initialTextStyle,
        ),
      ),
    );
  }
}
