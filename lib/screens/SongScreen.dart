import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  bool playing = false;
  IconData playbtn = Icons.play_arrow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 48.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Music Beats',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38.0,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 280.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        'assets/images/songbgimg1.jpg',
                      ),
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Strangazer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                iconSize: 45.0,
                                color: Colors.black,
                                icon: Icon(
                                  Icons.skip_previous,
                                )),
                            IconButton(
                                onPressed: () {
                                  if (!playing) {
                                    setState(() {
                                      playbtn = Icons.pause;
                                      playing = true;
                                    });
                                  } else {
                                    setState(() {
                                      playbtn = Icons.play_arrow;
                                      playing = false;
                                    });
                                  }
                                },
                                iconSize: 45.0,
                                color: Colors.black,
                                icon: Icon(
                                  Icons.play_arrow,
                                )),
                            IconButton(
                                onPressed: () {},
                                iconSize: 45.0,
                                color: Colors.black,
                                icon: Icon(
                                  Icons.skip_next,
                                )),
                          ],
                        )
                      ]),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
