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
      width: Get.width/2,
      decoration: BoxDecoration(
          color: Colors.blue[500], borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(fontSize: Get.width / 20, color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
