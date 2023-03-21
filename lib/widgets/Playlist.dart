import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Function/functions.dart';
import 'package:music_app/Function/playlist.dart';
import 'package:music_app/model/dataBaseFunctions/db_functions.dart';
import 'package:music_app/model/song_model.dart';
import 'package:music_app/screens/PlaylistScreen.dart';
import 'package:music_app/screens/SearchScreen.dart';
import 'package:music_app/widgets/Screengradiant.dart';
import 'package:music_app/widgets/card.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  static final Box<List> playlistBox = getPlaylistBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ValueListenableBuilder(
                  valueListenable: playlistBox.listenable(),
                  builder: (context, boxSongList, _) {
                    final List<dynamic> keys = playlistBox.keys.toList();

                    keys.removeWhere((key) => key == 'Favourites');
                    keys.removeWhere((key) => key == 'Recent');
                    keys.removeWhere((key) => key == 'Most Played');
                    // return Cards(Keyname: keys[0].toString(),);
                    return (keys.isEmpty)
                        ? Container(
                            margin: EdgeInsets.only(top: 300),
                            child: Center(
                                child: Text(
                              'Playlist is empty',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                          )
                        : GridView.builder(
                            itemCount: keys.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 1.25,
                            ),
                            itemBuilder: (context, index) {
                              final String playlistName = keys[index];

                              final List<Songs> songList = playlistBox
                                  .get(playlistName)!
                                  .toList()
                                  .cast<Songs>();

                              final int songListlength = songList.length;

                              return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => PlaylistScreen(
                                          Playlistname: keys[index]),
                                    ));
                                  },
                                  onLongPress: () {
                                    playlistdelete(
                                        context: context,
                                        playlistname: keys[index]);
                                  },
                                  child: Cards(
                                    Keyname: keys[index].toString(),
                                  ));
                            },
                          );
                  }),
            ),
          ]),
        ),
      ),
      floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: IconButton(
              onPressed: (() => showCreatingPlaylistDialoge(context: context)),
              icon: Icon(Icons.add))),
    );
  }
}
