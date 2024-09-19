import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/products/widgets/product_details.dart';

import '../../../core/ui/styles/colors.dart';
import '../../../domain/products/models/product.dart';
import '../bloc/product_bloc.dart';
import 'home_widget.dart';

class ProductCard extends StatefulWidget {
  final BikeModel bike;
  final List<BikeModel>favoriteBikes;


  const ProductCard({
    super.key,
    required this.bike,
    required this.favoriteBikes,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    // Initialize based on whether the bike is in the favorites list (comparing entire objects instead of just IDs)
    _isFavorited = widget.favoriteBikes.any((bike) => bike.id == widget.bike.id);
    print("favoriteBikes ${widget.favoriteBikes}");

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              bike: widget.bike,
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
                  AppConstants.ebonyClay,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(9.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        _isFavorited
                            ? Icons.favorite // Filled red heart
                            : Icons.favorite_border, // Border heart
                        color: _isFavorited ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorited = !_isFavorited;
                          if (_isFavorited) {
                            _onAddProductToFavoriteEvent();
                            // prefs.saveBikeModel(widget.bike);
                          } else {
                            _onRemoveProductFromFavoriteEvent();
                          }
                        });
                      },
                    ),
                  ),
                  Center(
                    child: Image.network(
                      widget.bike.image, // Placeholder image path
                      height: 70.h,
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.bike.categoryId,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.bike.name,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '\$${widget.bike.price}',
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

  void _onAddProductToFavoriteEvent() {
    BlocProvider.of<ProductBloc>(context)
        .add(AddProductToFavoriteEvent(widget.bike.id.toString()));
  }

  void _onRemoveProductFromFavoriteEvent() {
    BlocProvider.of<ProductBloc>(context)
        .add(RemoveProductFromFavoriteEvent(widget.bike.id.toString()));
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