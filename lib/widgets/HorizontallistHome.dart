import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Function/mostplayed.dart';
import 'package:music_app/screens/MostPlay.dart';


import 'package:music_app/screens/Favourite.dart';
import 'package:music_app/screens/Recent.dart';
import 'package:music_app/screens/splash.dart';
import 'package:music_app/widgets/Playlist.dart';
import 'package:music_app/widgets/white.dart';

class HorzotallistHome extends StatelessWidget {
  const HorzotallistHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return SizedBox(
      // height: size.width * 0.4,
      // //  width: MediaQuery.of(context).size.width / 10,
      // width: 100,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 200,
       
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
             InkWell(
               onTap: () {
                Navigator.of(context).push( MaterialPageRoute(builder: (context) => Playlist()));
             },
             child: Column(
               children: [
                 Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: size.width * 0.4,
                      height: size.width * 0.4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/songimg4.jpg"),
                            fit: BoxFit.cover),
                        borderRadius:
                            BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  Text('Playlist')
               ],
             ),
             
           ),
            InkWell(
                             onTap: () {
                Navigator.of(context).push( MaterialPageRoute(builder: (context) => RecentSongs()));
             },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: size.width * 0.4,
                      height: size.width * 0.4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/songimg1.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  Text('Recently played')
                ],
              ),
              
            ),
            InkWell(
               onTap: () {
                Navigator.of(context).push( MaterialPageRoute(builder: (context) => MostPlayedSongs()));
             },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: size.width * 0.4,
                      height: size.width * 0.4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/songimg2.jpg"),
                            fit: BoxFit.cover),
                        borderRadius:
                            BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  Text("Most played")
                  
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push( MaterialPageRoute(builder: (context) => FavoriteScreen()));
             },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: size.width * 0.4,
                        height: size.width * 0.4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/songimg3.jpg"),
                            fit: BoxFit.cover),
                        borderRadius:
                            BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                 Text('favourite list')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}