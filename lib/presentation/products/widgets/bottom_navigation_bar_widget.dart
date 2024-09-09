import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_bike_shopping_appuntitled/presentation/profile/widgets/settings.dart';
import '../../../core/ui/styles/colors.dart';
import '../../../core/ui/styles/theme.dart';
import '../../../domain/products/models/product.dart';
import '../bloc/product_bloc.dart';
import 'home_widget.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget(
      {super.key,
      required this.products,
      required this.loading,
      required this.favoriteProductsByMe});

  final List<BikeModel> products;
  final List<String> favoriteProductsByMe;
  final ProductStatus loading;

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        products: widget.products,
        loading: widget.loading, favoriteProductsByMe: widget.favoriteProductsByMe,
      ),
      // 0: Home Screen
      RegisterScreen(),
      // 1: Register Screen
      ShoppingScreen(),
      // 2: Shopping Screen
      const SettingsScreen(),
      // 3: Settings Screen
    ];
    return Scaffold(
      backgroundColor: AppConstants.ebonyClay,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset('assets/images/home_background.png'),
          ),
          SafeArea(
            child: Padding(
              padding: AppTheme.noBottomPadding,
              child: screens[_selectedIndex],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppConstants.cornflowerBlueColor,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(
          size: 30,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 24,
        ),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.directions_bike, 0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.bookmark_border, 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.shopping_cart_outlined, 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person_outline, 3),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index) {
    bool isSelected = _selectedIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(isSelected ? 8 : 0),
      decoration: isSelected
          ? BoxDecoration(
              color: AppConstants.cornflowerBlueColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            )
          : null,
      child: Icon(
        iconData,
        color: isSelected ? Colors.white : Colors.grey,
      ),
    );
  }
}
