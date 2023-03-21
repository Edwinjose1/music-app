import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/model/song_model.dart';

import '../model/dataBaseFunctions/db_functions.dart';

class Favourites {
  static final Box<List> playlistBox = getPlaylistBox();
  static final Box<Songs> songBox = getSongBox();

  static addSongToFavourites(
      {required BuildContext context, required int id}) async {
    final List<Songs> allSongs = songBox.values.toList().cast();

    final List<Songs> favSongList =
        playlistBox.get('Favourites')!.toList().cast<Songs>();

    final Songs favSong = allSongs
        .firstWhere((song) => song.songid.toString().contains(id.toString()));

    if (favSongList.where((song) => song.songid == favSong.songid).isEmpty) {
      favSongList.add(favSong);
      await playlistBox.put('Favourites', favSongList);
      showFavouritesSnackBar(
          context: context,
          songName: favSong.songTitle,
          message: 'Added to Favourites');
    } else {
      favSongList.removeWhere((songs) => songs.songid == favSong.songid);
      await playlistBox.put('Favourites', favSongList);
      showFavouritesSnackBar(
          context: context,
          songName: favSong.songTitle,
          message: 'Removed from Favourites');
    }
  }

  static IconData isThisFavourite({required int id}) {
    final List<Songs> allSongs = songBox.values.toList().cast();
    List<Songs> favSongList =
        playlistBox.get('Favourites')!.toList().cast<Songs>();

    Songs favSong = allSongs
        .firstWhere((song) => song.songid.toString().contains(id.toString()));
    return favSongList.where((song) => song.songid == favSong.songid).isEmpty
        ? Icons.favorite_outline_rounded
        : Icons.favorite_rounded;
  }

  static showFavouritesSnackBar(
      {required BuildContext context,
      required String songName,
      required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.black26,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              songName,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
