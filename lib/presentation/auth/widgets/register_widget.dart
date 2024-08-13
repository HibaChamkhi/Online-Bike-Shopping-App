import 'package:flutter/material.dart';
import 'package:online_bike_shopping_appuntitled/core/widgets/input_field.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InputField(
              controller: _controller,
              hintText: 'dlskfjls',
            )
          ],
        ),
      ),
    );
  }
}
