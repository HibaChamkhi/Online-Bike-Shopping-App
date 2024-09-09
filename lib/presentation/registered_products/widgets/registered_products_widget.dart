import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/ui/styles/colors.dart';
import '../../products/bloc/product_bloc.dart';

class RegisteredProductWidgets extends StatefulWidget {
  const RegisteredProductWidgets({super.key, required this.state});

  final ProductState state;

  @override
  State<RegisteredProductWidgets> createState() =>
      _RegisteredProductWidgetsState();
}

class _RegisteredProductWidgetsState extends State<RegisteredProductWidgets> {
  @override
  Widget build(BuildContext context) {
    if (widget.state.favoriteProductStatus == FavoriteProductStatus.loading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              5,
              (index) => Container(
                    height: 100.h,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    // Adjusts spacing between boxes
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppConstants.ebonyClay.withOpacity(0.3),
                    ),
                  )),
        ),
      );
    }
    return ListView.builder(
      itemCount: widget.state.favoriteProductsByMe.length,
      itemBuilder: (context, index) {
        final product = widget.state.favoriteProductsByMe[index];
        return CartItem(
          itemName: product.name,
          price: product.price,
          imageUrl: 'assets/images/bicycl.png',
          isFavorited: true,
          id: product.id.toString(),
            onFavoriteToggle: () {
              setState(() {
                widget.state.favoriteProductsByMe.removeAt(index); // Remove from list
              });
            },
        );
      },
    );
  }
}

class CartItem extends StatefulWidget {
  CartItem({
    super.key,
    required this.id,
    required this.itemName,
    required this.price,
    required this.imageUrl,
    required this.isFavorited,
    required this.onFavoriteToggle,
  });

  final String id;
  final String itemName;
  final double price;
  final String imageUrl;
  late bool isFavorited;
  final VoidCallback onFavoriteToggle;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> with SingleTickerProviderStateMixin {
  bool _isRemoving = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.5, 0), // Slide the item out to the right
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: AnimatedOpacity(
        opacity: _isRemoving ? 0.0 : 1.0,
        duration: Duration(milliseconds: 500),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppConstants.oxfordBlue.withOpacity(.8),
              ),
              padding: EdgeInsets.all(8.0.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Image.asset(
                      widget.imageUrl,
                      height: 90.h,
                      width: 100.w,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.itemName,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 100.w,
                              child: Text('\$${widget.price}',
                                  style: TextStyle(color: Colors.blue))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: Icon(
                  widget.isFavorited
                      ? Icons.favorite // Filled red heart
                      : Icons.favorite_border, // Border heart
                  color: widget.isFavorited ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.isFavorited = !widget.isFavorited;
                    if (widget.isFavorited) {
                      _onAddProductToFavoriteEvent(widget.id);
                    } else {
                      _onRemoveProductFromFavoriteEvent(widget.id);
                      _startRemoveAnimation(); // Start the removal animation
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startRemoveAnimation() {
    setState(() {
      _isRemoving = true; // Start fading out
    });
    _controller.forward(); // Start slide-out animation
    Future.delayed(Duration(milliseconds: 500), () {
      widget.onFavoriteToggle(); // Notify parent after animation ends
    });
  }

  void _onAddProductToFavoriteEvent(String id) {
    BlocProvider.of<ProductBloc>(context).add(AddProductToFavoriteEvent(id));
  }

  void _onRemoveProductFromFavoriteEvent(String id) {
    BlocProvider.of<ProductBloc>(context).add(RemoveProductFromFavoriteEvent(id));
  }
}
