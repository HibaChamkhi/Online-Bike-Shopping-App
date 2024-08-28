import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/core/colors/colors.dart';
import 'package:online_bike_shopping_appuntitled/data/products/models/product_model.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/widgets/product_details.dart';

import '../bloc/product_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.products,
    required this.loading,
  });

  final List<BikeModel> products;
  final ProductStatus loading;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar: Title and Search Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose Your Bike',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
              ),
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
                    Icons.search,
                    color: Colors.white,
                    size: 28.h,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scrollable "30% Off" Card Section
                  SizedBox(
                    height: 200.h,
                    child: buildDiscountCard(),
                  ),
                  SizedBox(height: 20.h),
                  // Category Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCategoryIcon(Icons.directions_bike, true),
                      Transform.translate(
                        offset: Offset(0, -10.h),
                        child: buildCategoryIcon(Icons.electric_bike),
                      ),
                      Transform.translate(
                        offset: Offset(0, -20.h),
                        child: buildCategoryIcon(Icons.electric_bike),
                      ),
                      Transform.translate(
                        offset: Offset(0, -30.h),
                        child: buildCategoryIcon(Icons.motorcycle),
                      ),
                      Transform.translate(
                        offset: Offset(0, -40.h),
                        child: buildCategoryIcon(Icons.motorcycle),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Grid of Products or Loading Placeholders
                  widget.loading == ProductStatus.loading ? buildLoadingGrid() : buildProductGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoadingGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: 6, // Number of loading placeholders
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppConstants.ebonyClay.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
        );
      },
    );
  }

  Widget buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        if (index % 2 != 0) {
          return Transform.translate(
              offset: const Offset(0, -25),
              child: buildProductCard(context, widget.products[index]));
        }
        return buildProductCard(context, widget.products[index]);
      },
    );
  }
}



Widget buildDiscountCard() {
  return ClipPath(
    clipper: DiagonalBottomClipper(),
    child: Container(
      decoration: const BoxDecoration(
        color: AppConstants.ebonyClay,
      ),
      child: Container(
        // width: 280,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstants.ebonyClay,
              AppConstants.oxfordBlue.withOpacity(.4),
              // AppConstants.ebonyClay.withOpacity(.6),
              AppConstants.cornflowerBlueColor.withOpacity(.2)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/bicycl.png', // Placeholder image path
                ),
              ),
              Text(
                '30% Off',
                style: TextStyle(
                  color: Colors.white.withOpacity(.5),
                  fontSize: 22.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildCategoryIcon(IconData icon, [bool isSelected = false]) {
  return Container(
    decoration: BoxDecoration(
      color: AppConstants.oxfordBlue,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : Colors.black54,
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            isSelected
                ? AppConstants.pictonBlue
                : AppConstants.cornflowerBlueColor.withOpacity(.2),
            isSelected ? AppConstants.royalBlue : AppConstants.ebonyClay
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 4,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.grey,
        size: 28,
      ),
    ),
  );
}

Widget buildProductCard(context, BikeModel bike) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductDetails(
            bike: bike,
          ),
        ),
      );
    },
    child: ClipPath(
      clipper: DiagonalClipper(),
      child: Container(
        decoration: const BoxDecoration(
          color: AppConstants.mirage,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppConstants.oxfordBlue.withOpacity(.8),
            boxShadow: const [
              BoxShadow(
                color: AppConstants.ebonyClay,
                blurRadius: 1,
                spreadRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                AppConstants.cornflowerBlueColor.withOpacity(.2),
                AppConstants.ebonyClay
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/bicycl.png', // Placeholder image path
                    height: 80.h,
                  ),
                ),
                Spacer(),
                Text(
                  bike.categoryId ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  bike.name,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '\$${bike.price}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}



class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Register Screen',
            style: TextStyle(color: Colors.white, fontSize: 24)));
  }
}

class ShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Shopping Screen',
            style: TextStyle(color: Colors.white, fontSize: 24)));
  }
}



class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;

  UnicornOutlineButton({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
  })  : this._painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        this._child = child,
        this._callback = onPressed,
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            padding: EdgeInsets.all(1.w),
            // constraints: BoxConstraints(minWidth: 88, minHeight: 48),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required double strokeWidth,
      required double radius,
      required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class DiagonalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(20, 0) // Start from the top-left with rounded corner
      ..lineTo(size.width - 20, 0) // Top-right straight line
      ..quadraticBezierTo(
          size.width, 0, size.width, 20) // Top-right rounded corner
      ..lineTo(size.width, size.height - 40.h) // Right side straight down
      ..lineTo(size.width, size.height - 60.h) // Right side straight down
      ..quadraticBezierTo(size.width, size.height - 40.h, size.width - 20.w,
          size.height - 35.h) // Bottom-right rounded corner
      ..lineTo(20.w, size.height) // Diagonal bottom line
      ..quadraticBezierTo(0, size.height, 0,
          size.height - 20.h) // Bottom-left outward rounded corner
      ..lineTo(0, 20) // Left side straight up
      ..quadraticBezierTo(0, 0, 20, 0); // Top-left rounded corner

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(20, 20) // Start from the top-left with rounded corner
      ..lineTo(size.width - 20, 0) // Top-right straight line
      ..quadraticBezierTo(
          size.width, 0, size.width, 20) // Top-right rounded corner
      ..lineTo(size.width, size.height - 40.h) // Right side straight down
      ..lineTo(size.width, size.height - 30.h) // Right side straight down
      ..quadraticBezierTo(size.width, size.height - 20.h, size.width - 20.w,
          size.height - 10.h) // Bottom-right rounded corner
      ..lineTo(20.w, size.height + 10.h) // Diagonal bottom line
      ..quadraticBezierTo(0, size.height + 10.h, 0,
          size.height) // Bottom-left outward rounded corner
      ..lineTo(0, 50) // Left side straight up
      ..quadraticBezierTo(0, 30, 20, 20); // Top-left rounded corner

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
