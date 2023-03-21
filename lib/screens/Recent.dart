import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/screens/Home.dart';
import 'package:music_app/widgets/Songtile.dart';

import '../model/dataBaseFunctions/db_functions.dart';
import '../model/song_model.dart';

class RecentSongs extends StatefulWidget {
  const RecentSongs({super.key});

  @override
  State<RecentSongs> createState() => _RecentSongsState();
}

class _RecentSongsState extends State<RecentSongs> {
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
                    'Recent Songs',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w500),
                  ),
                  ValueListenableBuilder(
                    valueListenable: PlaylistBox.listenable(),
                    builder: (context, value, child) {
                      return Text(
                        '${PlaylistBox.get('Recent')?.toList().length} Songs',
                        style:
                            TextStyle(color: Color(0xFFC87DFF), fontSize: 15),
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
                      valueListenable: PlaylistBox.listenable(),
                      builder: (BuildContext context, Box<List> value,
                          Widget? child) {
                        List<Songs> Recentlist =
                            PlaylistBox.get('Recent')!.toList().cast<Songs>();

                        return (Recentlist.isEmpty)
                            ? Center(
                                child: Text(
                                'Add Your Favotite Songs',
                                style: TextStyle(color: Colors.white),
                              ))
                            : ListView.builder(
                                itemCount: Recentlist.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SongListTile(
                                    onPressed: () {},
                                    songList: Recentlist,
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
