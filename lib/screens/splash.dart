import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_app/model/dataBaseFunctions/db_functions.dart';
import 'package:music_app/model/song_model.dart';
import 'package:music_app/screens/Allsong.dart';
import 'package:music_app/screens/Home.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class MyCustomSplashScreen extends StatefulWidget {
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;
  List<SongModel> fetchedSongsList = [];
  List<SongModel> sortedSongs = [];
  late AnimationController _controller;
  late Animation<double> animation1;

  Box<Songs> songBox = getSongBox();
  Box<List> playlistBox=getPlaylistBox();
  


  
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    // requestpermission();
    fetchingSongs();
    SplashScreenAnimation();
  }

  Future<void> requestpermission() async {
    await Permission.storage.request();
  }

  Future<void> fetchingSongs() async {
    await requestpermission();
    final fetchedSongsList = await audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    if (fetchedSongsList == null) {
      print('storage is empty');
    } else {
      print('storage has something');
    }

    //for adding the songs to the sorted list
    for (var song in fetchedSongsList) {
      if (song.fileExtension == 'mp3' || song.fileExtension == 'm4a') {
        sortedSongs.add(song);
      }
      print('Accessed Songs = ${fetchedSongsList.length}');
    }
    for (var audio in sortedSongs) {
      final song = Songs(
        songPath: audio.uri!,
        songTitle: audio.title,
        songArtist: audio.artist!,
        songid: audio.id,
      );
      await songBox.put(audio.id, song);
    }
    if (songBox.isEmpty) {
      print('Song Box is empty');
    } else {
      print('Song box is not empty ${songBox.length}');
    }
     getFavSongs();
      getRecentSongs();
      getMostplayedSongs();



  }
Future getFavSongs() async {
    if (!playlistBox.keys.contains('Favourites')) {
      await playlistBox.put('Favourites', []);
    }
  }

  Future getRecentSongs() async {
    if (!playlistBox.keys.contains('Recent')) {
      await playlistBox.put('Recent', []);
    }
  }

  Future getMostplayedSongs() async {
    if (!playlistBox.keys.contains('Most Played')) {
      await playlistBox.put('Most Played', []);
    }
  }
  void SplashScreenAnimation() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation1 = Tween<double>(begin: 150, end: 35).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 4), () {
      setState(() {
        Navigator.pushReplacement(context, PageTransition(HomeScreen()));
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize),
              AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: _textOpacity,
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1.value,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _width / _containerSize,
                width: _width / _containerSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset('assets/images/splashscreenlogo.jpg'),
                // child: Text(
                //   'YOUR APP\'S LOGO',
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 0000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
