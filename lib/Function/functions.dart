import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Function/playlist.dart';
import 'package:music_app/model/dataBaseFunctions/db_functions.dart';

import 'package:music_app/model/song_model.dart';
import 'package:music_app/screens/MostPlay.dart';
import 'package:music_app/widgets/Miniplayer.dart';
import 'package:music_app/widgets/Songtile.dart';
import 'package:music_app/widgets/search_field.dart';

showMiniPlayer(
    {required int index,
    required BuildContext context,
    required AssetsAudioPlayer audioPlayer,
    required List<Songs> songList}) {
  return showBottomSheet(
    context: context,
    builder: (context) {
      return MiniPlayer(
        songList: songList,
        audioPlayer: audioPlayer,
        index: index,
      );
    },
  );
}

showPlaylistModalSheet({
  required BuildContext context,
  required double screenHeight,
  required Songs song,
}) {
  Box<List> playlistBox = getPlaylistBox();
  return showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 4, 4, 44),
      context: context,
      builder: (ctx) {
        return Column(
          children: [
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                showCreatingPlaylistDialoge(context: ctx);
              },
              icon: const Icon(
                Icons.playlist_add,
                color: Color.fromARGB(255, 17, 15, 15),
              ),
              label: const Text(
                'Create Playlist',
                style: TextStyle(color: Color.fromARGB(255, 10, 9, 9)),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
                valueListenable: playlistBox.listenable(),
                builder: (context, boxSongList, _) {
                  final List<dynamic> keys = playlistBox.keys.toList();

                  keys.removeWhere((key) => key == 'Favourites');
                  keys.removeWhere((key) => key == 'Recent');
                  keys.removeWhere((key) => key == 'Most Played');

                  return Expanded(
                    child: (keys.isEmpty)
                        ? const Center(
                            child: Text("No Playlist Found"),
                          )
                        : ListView.builder(
                            itemCount: keys.length,
                            itemBuilder: (ctx, index) {
                              final String playlistKey = keys[index];

                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 73, 43, 124),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  onTap: () async {
                                    UserPlaylist.addSongToPlaylist(
                                        context: context,
                                        songId: song.songid.toString(),
                                        playlistName: playlistKey);

                                    Navigator.pop(context);
                                  },
                                  leading: const Text(
                                    '🎧',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  title: Text(playlistKey),
                                ),
                              );
                            },
                          ),
                  );
                })
          ],
        );
      });
}

showCreatingPlaylistDialoge({required BuildContext context}) {
  TextEditingController textEditingController = TextEditingController();
  Box<List> playlistBox = getPlaylistBox();

  Future<void> createNewplaylist() async {
    List<Songs> songList = [];
    final String playlistName = textEditingController.text.trim();
    if (playlistName.isEmpty) {
      return;
    }
    await playlistBox.put(playlistName, songList);
  }

  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        final formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Create playlist',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic),
            ),
            content: SearchField(
              textController: textEditingController,
              hintText: 'Playlist Name',
              icon: Icons.playlist_add,
              validator: (value) {
                final keys = getPlaylistBox().keys.toList();
                if (value == null || value.isEmpty) {
                  return 'Field is empty';
                }
                if (keys.contains(value)) {
                  return '$value Already exist in playlist';
                }
                return null;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await createNewplaylist();
                    Navigator.pop(ctx);
                  }
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ],
          ),
        );
      });
}

playlistdelete({required BuildContext context, required String playlistname}) {
  Box<List> playlistBox = getPlaylistBox();
  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Form(
          child: AlertDialog(
            backgroundColor: Color.fromARGB(255, 228, 222, 222),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Are you sure, you want to delete this playlist',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              TextButton(
                onPressed: () {
                  editPlaylistname(
                      context: context, playlistname: playlistname);
                },
                child: const Text(
                  'Edit Playlist Name',
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
              ),
              TextButton(
                onPressed: () async {
                  playlistBox.delete(playlistname);
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ],
          ),
        );
      });
}

removesongfromplaylist(
    {required BuildContext context,
    required String playlistname,
    required int id}) {
  final Box<List> PlaylistBox = getPlaylistBox();
  final List<Songs> songList =
      PlaylistBox.get(playlistname)!.toList().cast<Songs>();
  final Songs DeleteMusicRef =
      songList.firstWhere((song) => song.songPath.contains(id.toString()));

  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Form(
          child: AlertDialog(
            backgroundColor: Color.fromARGB(255, 228, 222, 222),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Are you sure, you want to remove this song',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              TextButton(
                onPressed: () async {
                  songList.remove(DeleteMusicRef);
                  await PlaylistBox.put(playlistname, songList);

                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ],
          ),
        );
      });
}

popupsonginplaylist(
    {required BuildContext contex, required String Playlistname}) {
  showModalBottomSheet(
    context: contex,
    builder: (context) {
      final Box<List> PlaylistBox = getPlaylistBox();
      final Box<Songs> songBox = getSongBox();
      List<Songs> songList = songBox.values.toList().cast<Songs>();
      AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');
      return Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: songList.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return SongListTile(
              icon: Icons.add_circle_outline_rounded,
              onPressed: () {
                UserPlaylist.addSongToPlaylist(
                    context: context,
                    songId: songList[index].songid.toString(),
                    playlistName: Playlistname);

                Navigator.of(context).pop();
              },
              index: index,
              songList: songList,
              audioPlayer: assetsAudioPlayer,
            );
          },
        ),
      );
    },
  );
}

editPlaylistname(
    {required BuildContext context, required String playlistname}) {
  TextEditingController textEditingController =
      TextEditingController(text: playlistname);
  Box<List> playlistBox = getPlaylistBox();

  Future<void> createNewplaylistname() async {
    List<Songs> songList = [];
    final String playlistName = textEditingController.text.trim();
    if (playlistName.isEmpty) {
      return;
    }
    List<Songs> PlaylistSongs =
        playlistBox.get(playlistname)!.toList().cast<Songs>();
    songList = PlaylistSongs;
    await playlistBox.put(playlistName, songList);
    await playlistBox.delete(playlistname);
    Navigator.of(context).pop();
  }

  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        final formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Create playlist',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic),
            ),
            content: SearchField(
              textController: textEditingController,
              hintText: 'Playlist Name',
              icon: Icons.playlist_add,
              validator: (value) {
                final keys = getPlaylistBox().keys.toList();
                if (value == null || value.isEmpty) {
                  return 'Field is empty';
                }
                if (keys.contains(value)) {
                  return '$value Already exist in playlist';
                }
                return null;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await createNewplaylistname();
                    Navigator.pop(ctx);
                  }
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ],
          ),
        );
      });
}
