import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatefulWidget {
  String btnText;

  CustomButton({required this.btnText});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 15,
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(fontSize: Get.width / 20, color: Colors.white),
        ),
      ),
    );
  }
}
