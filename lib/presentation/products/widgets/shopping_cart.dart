import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import '../../../core/colors/colors.dart';
import 'custom_swipe_button.dart';
import 'home_widget.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.ebonyClay,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const Text(
                    'My Shopping Cart',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Container()
                ],
              ),

              // SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    CartItem(
                      itemName: 'PEUGEOT- LR01',
                      price: 1999.99,
                      imageUrl: 'assets/images/bicycl.png',
                    ),
                    CartItem(
                      itemName: 'PILOT - CHROMOLY 520',
                      price: 3999.99,
                      imageUrl: 'assets/images/bicycl.png',
                    ),
                    CartItem(
                        itemName: 'SMITH - Trade',
                        price: 120,
                        imageUrl: 'assets/images/bicycl.png'),
                  ],
                ),
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your cart qualifies for free shipping',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              CouponField(),
              SizedBox(height: 10),
              CartSummary(),
              SizedBox(height: 20),
              CheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String itemName;
  final double price;
  final String imageUrl;

  CartItem(
      {required this.itemName, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                imageUrl,
                height: 90,
                width: 100,
              )),
          // Replace with your asset
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemName,
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 100,
                      child: Text('\$$price',
                          style: TextStyle(color: Colors.blue))),
                  Row(
                    children: [
                      IconButton(
                        icon: Container(
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
                        onPressed: () {},
                      ),
                      Text('1', style: TextStyle(color: Colors.white)),
                      IconButton(
                        icon: Container(
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
                        onPressed: () {},
                      ),
                    ],
                  )
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
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            // border: Border(
            //   left: BorderSide(color: Colors.white.withOpacity(0.1)),
            //   top: BorderSide(color: Colors.white.withOpacity(0.1)),
            //   bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
            // ),
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
            borderRadius: BorderRadius.circular(12),
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryRow(label: 'Subtotal:', value: '\$6119.99'),
        SummaryRow(label: 'Delivery Fee:', value: '\$0'),
        SummaryRow(label: 'Discount:', value: '30%'),
        SummaryRow(label: 'Total:', value: '\$4,283.99', isTotal: true),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  SummaryRow({required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  TextStyle(fontSize: isTotal ? 20 : 16, color: Colors.white)),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? Colors.blue : Colors.white,
              fontSize: isTotal ? 24 : 16,
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}




