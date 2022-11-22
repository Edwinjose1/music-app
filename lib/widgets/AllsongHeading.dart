import 'package:flutter/material.dart';

class AllsongHeading extends StatelessWidget {
  const AllsongHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        
        ' All Songs',
        style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic),

      ),
    );
  }
}