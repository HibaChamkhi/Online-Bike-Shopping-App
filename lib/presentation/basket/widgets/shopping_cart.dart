import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/core/model/ui_state.dart';
import 'package:online_bike_shopping_appuntitled/presentation/basket/bloc/basket_bloc.dart';
import '../../../core/ui/styles/colors.dart';
import '../../../domain/products/models/product.dart';
import '../../products/widgets/custom_swipe_button.dart';
import '../../products/widgets/home_widget.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({
    super.key,
    required this.inBottomNav,
    required this.state,
  });

  final BasketState? state;
  final bool inBottomNav;

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  double getSubtotal() {
    if (widget.state?.data == null) {
      return 0.0;
    }

    return widget.state!.data!.fold(0.0, (sum, item) {
      final itemPrice = item.price ?? 0.0; // Default to 0 if null
      final itemQuantity = item.quantity ?? 1; // Default to 1 if null
      return sum + (itemPrice * itemQuantity);
    });
  }


  double getDiscount(double subtotal) {
    // Example: 30% discount
    return subtotal * 0.30;
  }

  double getDeliveryFee() {
    // Example: Free delivery for simplicity
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = getSubtotal();
    final discount = getDiscount(subtotal);
    final deliveryFee = getDeliveryFee();
    final total = subtotal - discount + deliveryFee;

    return Scaffold(
      backgroundColor:
      widget.inBottomNav ? Colors.transparent : AppConstants.ebonyClay,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (existing widgets)

              Expanded(
                child: widget.state?.status == UIStatus.loading && widget.state?.data != null
                    ? const Center(child: CircularProgressIndicator(color: Colors.white,)) // Loading indicator
                    : widget.state?.data?.isEmpty ?? true
                    ? const Center(child: Text("No data available",style: TextStyle(color: Colors.white),)) // No data message
                    : ListView.builder(
                  itemCount: widget.state?.data?.length,
                  itemBuilder: (context, index) {
                    final product = widget.state?.data?[index];
                    return Dismissible(
                      key: ValueKey(product?.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30.h,
                        ),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          widget.state?.data?.removeAt(index);
                          BlocProvider.of<BasketBloc>(context)
                              .add(RemoveFromBasketEvent(product?.id.toString() ?? ""));
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product?.name} removed from cart')),
                        );
                      },
                      child: CartItem(
                        quantity: product?.quantity,
                        itemName: product?.name ?? "",
                        price: product?.price ?? 0,
                        imageUrl: product?.image ?? "",
                        bikeId: product?.id.toString() ?? "",
                      ),
                    );
                  },
                ),
              ),


              const Divider(color: Colors.grey),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your cart qualifies for free shipping',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              const CouponField(),
              SizedBox(height: 10.h),
              CartSummary(
                subtotal: subtotal,
                deliveryFee: deliveryFee,
                discount: discount,
                total: total,
              ),
              SizedBox(height: 20.h),
              const CheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}


class CartItem extends StatefulWidget {
  final String itemName;
  final double price;
  final String imageUrl;
  final int quantity;
  final String bikeId;
  CartItem({
    required this.itemName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.bikeId,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantity; // Initial quantity

  @override
  void initState() {
    quantity = widget.quantity ?? 1; // Default to 1 if null
    super.initState();
  }

  // Function to increase quantity
  void increaseQuantity() {
    setState(() {
      quantity++;
      BlocProvider.of<BasketBloc>(context).add(UpdateQuantityEvent(widget.bikeId, true));
    });
  }

  // Function to decrease quantity
  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        BlocProvider.of<BasketBloc>(context).add(UpdateQuantityEvent(widget.bikeId, false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemPrice = widget.price ?? 0.0; // Default to 0 if null

    return Container(
      padding: EdgeInsets.all(8.0.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Image.network(
              widget.imageUrl,
              height: 70.h,
              width: 80.w,
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
                      child: Text('\$${(itemPrice * quantity).toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.blue))),
                  Row(
                    children: [
                      InkWell(
                        onTap: increaseQuantity,
                        child: Container(
                            padding: EdgeInsets.all(4),
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
                            child: Icon(Icons.add, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          quantity.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      InkWell(
                        onTap: decreaseQuantity,
                        child: Container(
                            padding: EdgeInsets.all(4),
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
                            child: Icon(Icons.remove, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class CouponField extends StatelessWidget {
  const CouponField({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.white.withOpacity(0.1)),
              top: BorderSide(color: Colors.white.withOpacity(0.1)),
              bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            color: const Color(0xFF242C3B),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 5,
                offset: const Offset(-5, -3),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(5, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Bike30',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
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
              'Apply',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class CartSummary extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

  const CartSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryRow(label: 'Subtotal:', value: '\$${subtotal.toStringAsFixed(2)}'),
        SummaryRow(label: 'Delivery Fee:', value: '\$${deliveryFee.toStringAsFixed(2)}'),
        SummaryRow(label: 'Discount:', value: '-\$${discount.toStringAsFixed(2)}'),
        SummaryRow(label: 'Total:', value: '\$${total.toStringAsFixed(2)}', isTotal: true),
      ],
    );
  }
}



class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const SummaryRow(
      {super.key,
      required this.label,
      required this.value,
      this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isTotal ? 20.sp : 16.sp, color: Colors.white)),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? Colors.blue : Colors.white,
              fontSize: isTotal ? 24.sp : 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomSwipeButton(
        onSwipe: () {
          print('Swiped');
        },
        child: Center(
          child: Text(
            'Checkout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
