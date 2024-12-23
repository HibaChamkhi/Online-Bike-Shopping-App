import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/basket/widgets/shopping_cart.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/widgets/unicorn_outline_button.dart';
import '../../../core/ui/styles/colors.dart';
import '../../../domain/products/models/product.dart';
import '../../basket/pages/add_to_cart.dart';
import '../../basket/pages/basket_page.dart';
import '../bloc/product_bloc.dart';
import 'home_widget.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails(
      {super.key, required this.bike, });

  final BikeModel bike;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
            AddToCartPage(bike: widget.bike,)
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1C1F2E),
      body: Column(
        children: [
          Stack(
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
                              AppConstants.royalBlue2,
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
                      SizedBox(
                        height: 400.h,
                        width: 400.w,
                        child: Flutter3DViewer(
                          src: widget.bike.image3d ?? "",
                          progressBarColor: Colors.white,
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
                      child: const SpecificationDescriptionButtons(),
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
            color: AppConstants.cornflowerBlueColor3,
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
