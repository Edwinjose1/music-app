import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/model/dataBaseFunctions/db_functions.dart';
import 'package:music_app/model/song_model.dart';
import 'package:music_app/screens/Home.dart';
import 'package:music_app/widgets/Songtile.dart';

import '../Function/functions.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key, required this.Playlistname});
  final String Playlistname;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final audioPlayer = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    Box<List> PlaylistBox = getPlaylistBox();
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
                  IconButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      popupsonginplaylist(
                          contex: context, Playlistname: widget.Playlistname);
                    },
                    icon: Icon(CupertinoIcons.music_note_list),
                    color: Colors.white,
                  ),
                  Text(
                    widget.Playlistname,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w500),
                  ),
                  ValueListenableBuilder(
                    valueListenable: PlaylistBox.listenable(),
                    builder: (context, value, child) {
                      return Text(
                        '${PlaylistBox.get(widget.Playlistname)?.toList().length} Songs',
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
                        List<Songs> PlaylistSongs =
                            PlaylistBox.get(widget.Playlistname)!
                                .toList()
                                .cast<Songs>();

                        return (PlaylistSongs.isEmpty)
                            ? Container(
                                margin: EdgeInsets.only(top: 300),
                                child: Center(
                                    child: Text(
                                  'Add Your Favotite Songs',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )),
                              )
                            : ListView.builder(
                                itemCount: PlaylistSongs.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SongListTile(
                                    onPressed: () {
                                      removesongfromplaylist(
                                          playlistname: widget.Playlistname,
                                          id: PlaylistSongs[index].songid!,
                                          context: context);
                                    },
                                    songList: PlaylistSongs,
                                    index: index,
                                    audioPlayer: audioPlayer,
                                    icon: Icons.remove_circle_outline_outlined,
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
