import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverWidget extends StatefulWidget {
  const DiscoverWidget({super.key});

  @override
  State<DiscoverWidget> createState() => _DiscoverWidgetState();
}

class _DiscoverWidgetState extends State<DiscoverWidget> {
  List<bool> isSelected = [true, false];
  bool isDeliverSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Container(
            margin: EdgeInsets.only(top: 150),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: Image.asset('assets/images/bicycl.png',)),
                Container(
                  width: 180,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Discover your first bike",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20,bottom: 40),
                  width: 300,
                  child: Text(
                      textAlign: TextAlign.center,
                      "Explore the bike you want to ride and all its accessories based on your interests"),
                ),
              ],
            ),
          ),
            _buildSelectionButtons()
          ],
        ),
      ),
    );
  }
  Widget _buildSelectionButtons() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        // color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildSelectionButton(
            label: 'Deliver',
            isSelected: isDeliverSelected,
            onTap: () {
              setState(() {
                isDeliverSelected = true;
              });
            },
          ),
          _buildSelectionButton(
            label: 'Pick Up',
            isSelected: !isDeliverSelected,
            onTap: () {
              setState(() {
                isDeliverSelected = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ?  Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.blue,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

}
