import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/core/colors/colors.dart';
import 'package:online_bike_shopping_appuntitled/core/colors/theme.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/widgets/product_details.dart';

class BikeShopUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.ebonyClay,
      body: Stack(
        children: [
          // Layered Background with Blue and Dark Sections
          Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset('assets/images/home_background.png')),
          SafeArea(
            child: Padding(
              padding: AppTheme.padding,
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
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Scrollable "30% Off" Card Section
                  SizedBox(
                    height: 240.h,
                    child: buildDiscountCard(),
                  ),
                  SizedBox(height: 20),
                  // Category Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCategoryIcon(Icons.directions_bike, true),
                      buildCategoryIcon(Icons.electric_bike),
                      buildCategoryIcon(Icons.electric_bike),
                      buildCategoryIcon(Icons.motorcycle),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Grid of Products
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return buildProductCard(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bike),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      ),
    );
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
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    fontSize: 26.sp,
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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : Colors.black54,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget buildProductCard(context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProductDetails(),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.black.withOpacity(0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                    height: 80,
                  ),
                ),
                Spacer(),
                Text(
                  'Road Bike',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'PEUGEOT - LR01',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '\$1,999.99',
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
    );
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
      ..quadraticBezierTo(size.width, 0, size.width, 20) // Top-right rounded corner
      ..lineTo(size.width, size.height - 40.h) // Right side straight down
      ..lineTo(size.width, size.height - 60.h) // Right side straight down
      ..quadraticBezierTo(size.width, size.height-40.h, size.width - 20.w, size.height-35.h) // Bottom-right rounded corner
      ..lineTo(20.w, size.height ) // Diagonal bottom line
      ..quadraticBezierTo(0, size.height, 0, size.height - 20.h) // Bottom-left outward rounded corner
      ..lineTo(0, 20) // Left side straight up
      ..quadraticBezierTo(0, 0, 20, 0); // Top-left rounded corner

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
