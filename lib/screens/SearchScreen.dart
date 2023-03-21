import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Function/functions.dart';
import 'package:music_app/model/song_model.dart';
import 'package:music_app/widgets/Songtile.dart';

import '../model/dataBaseFunctions/db_functions.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AssetsAudioPlayer assetauidioplayer = AssetsAudioPlayer.withId('0');
  Box<Songs> songBox = getSongBox();
  TextEditingController SearchedWord = TextEditingController();
  List<Songs> audiolist = [];
  List<Songs> fountSongs = [];

  @override
  void initState() {
    // TODO: implement initState
    final List<int> keys = songBox.keys.toList().cast<int>();
    for (var key in keys) {
      audiolist.add(songBox.get(key)!);
    }

    super.initState();
    fountSongs = audiolist;
  }

  void SearchSong(String enterdKeyword) {
    List<Songs> results = [];
    if (enterdKeyword.isEmpty) {
      results = audiolist;
    } else {
      results = audiolist
          .where((element) => element.songTitle
              .toString()
              .toLowerCase()
              .contains(enterdKeyword.trim().toLowerCase()))
          .toList();
    }
    setState(() {
      fountSongs = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Songs> songList = songBox.values.toList().cast<Songs>();
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsetsDirectional.all(15),
          child: ListView(physics: ScrollPhysics(), children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) => SearchSong(value),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5),
                filled: true,
                fillColor: Color.fromARGB(255, 9, 31, 49),
                hintText: 'search song',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey.shade400),
                prefixIcon: const Icon(Icons.search,
                    color: Color.fromARGB(255, 200, 196, 196)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
              valueListenable: songBox.listenable(),
              builder: (context, Box<Songs> Songs, Widget? child) {
                // final keys = Songs.keys.toList();
                final screenHeight = MediaQuery.of(context).size.height;
                if (Songs.values == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (Songs.values.isEmpty) {
                  return Center(
                      child: Text(
                    'No Songs Identified',
                    style: TextStyle(color: Colors.white),
                  ));
                }
                return ListView.builder(
                  itemCount: fountSongs.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SongListTile(
                      onPressed: () {
                        showPlaylistModalSheet(
                            context: context,
                            screenHeight: screenHeight,
                            song: fountSongs[index]);
                      },
                      index: index,
                      songList: fountSongs,
                      audioPlayer: assetauidioplayer,
                    );
                  },
                );
              },
            ),
          ]),
        ));
  }
}
