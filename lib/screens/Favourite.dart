
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/Function/favourites.dart';
import 'package:music_app/model/song_model.dart';
import 'package:music_app/screens/Home.dart';
import 'package:music_app/widgets/Nowplaying.dart';
import 'package:music_app/widgets/Songtile.dart';

import '../model/dataBaseFunctions/db_functions.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final audioPlayer = AssetsAudioPlayer.withId('0');

  Box<List> PlaylistBox = getPlaylistBox();

  Box<Songs> musicBox = getSongBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          //  Navigator.of(context).pop();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                              (route) => false);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Text(
                    'Favorite',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w500),
                  ),
                  ValueListenableBuilder(
                    valueListenable: PlaylistBox.listenable(),
                    builder: (context, value, child) {
                      
                     return Text(
                      '${PlaylistBox.get('Favourites')!.toList().length} Songs',
                      style: TextStyle(color: Color(0xFFC87DFF), fontSize: 15),
                    );
                    },
                    
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: [
                    ValueListenableBuilder(
                      child: Text(
                    '${PlaylistBox.get('Favourites')!.toList().length} Songs',
                    style: TextStyle(color: Color(0xFFC87DFF), fontSize: 15),
                  ),
                      valueListenable: PlaylistBox.listenable(),
                      builder: (BuildContext context, Box<List> value,
                          Widget? child) {
                        List<Songs> musicList = PlaylistBox.get('Favourites')!
                            .reversed
                            .toList()
                            .cast<Songs>();

                        return (musicList.isEmpty)
                            ? Center(
                                child: Text(
                                'Add Your Favotite Songs',
                                style: TextStyle(color: Colors.white),
                              ))
                            : ListView.builder(
                                itemCount: musicList.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SongListTile(
                                    onPressed: () {},
                                    songList: musicList,
                                    index: index,
                                    audioPlayer: audioPlayer,
                                  );
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
