

import 'package:flutter/material.dart';


import 'package:music_app/lyrics_rep/api.dart';

class Screen_Lyrics extends StatefulWidget {
  const Screen_Lyrics(
      {super.key, required this.SongTitile, required this.SongArtist});
  final String SongTitile;
  final String SongArtist;

  @override
  State<Screen_Lyrics> createState() => _Screen_LyricsState();
}

class _Screen_LyricsState extends State<Screen_Lyrics> {
  String newLyrics = 'Tap the button to get the Lyrics';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF3B1F50),
        elevation: 0,
        title: Text(
          widget.SongTitile,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      backgroundColor: Color(0xFF3B1F50),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), backgroundColor: Colors.blueAccent),
                  onPressed: () async {
                   
                    if(widget.SongArtist != '<unknown>') {
                      
                      final lyricsData = await getSongLyrics(
                          title: widget.SongTitile, artist: widget.SongArtist);

                      setState(() {
                        newLyrics = lyricsData.lyrics??'No Lyrics Found';
                      });
                    } else {
                      setState(() {
                        newLyrics =
                            'Unable to find the lyrics due to Unknown artist';
                      });
                    }
                  },
                  child: const Text(
                    'Get lyrics',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    newLyrics,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
