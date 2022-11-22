import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Function/favourites.dart';
import 'package:music_app/Function/functions.dart';
import 'package:music_app/model/dataBaseFunctions/db_functions.dart';
import 'package:music_app/model/song_model.dart';

import 'package:music_app/screens/Setting.dart';
import 'package:music_app/screens/Favourite.dart';
import 'package:music_app/widgets/AllsongHeading.dart';
import 'package:music_app/widgets/Appbar.dart';
import 'package:music_app/widgets/HorizontallistHome.dart';
import 'package:music_app/widgets/Nowplaying.dart';
import 'package:music_app/widgets/Screengradiant.dart';
import 'package:music_app/widgets/Songtile.dart';
import 'package:music_app/widgets/search.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AssetsAudioPlayer assetauidioplayer = AssetsAudioPlayer.withId('0');
  bool favour = false;
  Box<Songs> songBox = getSongBox();
  Box<List> playlistBox = getPlaylistBox();

  List<Songs> audioList = [];
  @override
  Widget build(BuildContext context) {
    // List<Song> songs = Song.songs;   >>this code may be used later
    List<Songs> songList = songBox.values.toList().cast<Songs>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: const Appbar(),
      // bottomNavigationBar: Navbar(),
      drawer: _Drawer(),
      body: 
           ListView(
        children: [
          DiscoverMusic(),
          SizedBox(height: 20),
          HorzotallistHome(),
          AllsongHeading(),
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
                itemCount: songList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return SongListTile(
                    onPressed: () {
                      showPlaylistModalSheet(
                          context: context,
                          screenHeight: 30,
                          song: songList[index]);
                    },
                    index: index,
                    songList: songList,
                    audioPlayer: assetauidioplayer,
                  );
                },
              );
            },
          ),
        ],
      ));
    
  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(200, 200, 200, 200),
      items: [
        PopupMenuItem(
            child: Container(
          width: 500,
          child: Column(
            children: [
              Text(
                'Add a new playlist',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Playlist name', style: TextStyle(color: Colors.black)),
              TextFormField(
                style: TextStyle(color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Create', style: TextStyle(color: Colors.blue)),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Save', style: TextStyle(color: Colors.blue))
                ],
              )
            ],
          ),
        ))
      ],
      elevation: 8.0,
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Center(
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/piyano.webp'),
                  fit: BoxFit.fill),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.playlist_add,
              color: Colors.white,
            ),
            title: Text(
              'Most played',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.white,
            ),
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => Mostplayed()));
            },
          ),
          ListTile(
            leading: Icon(Icons.recent_actors_rounded, color: Colors.white),
            title: Text(
              'Recently played',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_right, color: Colors.white),
            onTap: () {
              //  Navigator.of(context)
              //  .push(MaterialPageRoute(builder: (context) => Recently()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.white),
            title: Text(
              'Liked song',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_right, color: Colors.white),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text(
              'Setting',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_right, color: Colors.white),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          ),
        ]),
      ),
    );
  }
}
