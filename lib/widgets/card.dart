import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

import 'package:music_app/model/song_model.dart';
import 'package:music_app/widgets/white.dart';

class Cards extends StatefulWidget {
  Cards({super.key, required this.Keyname});

  @override
  State<Cards> createState() => _CardsState();
  final String Keyname;
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: size.width * 0.4,
            height: size.width * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/songimg2.jpg"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        Text(
          widget.Keyname,
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontStyle: FontStyle.italic),
        )
      ],
    );
  }
}
