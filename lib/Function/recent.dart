import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Function/mostplayed.dart';

import '../model/dataBaseFunctions/db_functions.dart';
import '../model/song_model.dart';

class Recents {
  static final Box<Songs> songBox = getSongBox();
  static final Box<List> playlistBox = getPlaylistBox();

  static addSongsToRecents({required String songId}) async {
    final List<Songs> dbSongs = songBox.values.toList().cast<Songs>();
    final List<Songs> recentSongList =
        playlistBox.get('Recent')!.toList().cast<Songs>();

    final Songs recentSong =
        dbSongs.firstWhere((song) => song.songid.toString().contains(songId));
    ///////////////---------For Most Played----------///////////////////////////

    int count = recentSong.flag!;
    recentSong.flag = count + 1;
    Mostplayed.addSongToPlaylist(songId);
    log("${recentSong.flag} Recent song Count");

    ////////////////////////////////////////////////////////////////////////////
    if (recentSongList.length >= 10) {
      recentSongList.removeLast();
    }
    if (recentSongList.where((song) => song.songid == recentSong.songid).isEmpty) {
      recentSongList.insert(0, recentSong);
      await playlistBox.put('Recent', recentSongList);
    } else {
      recentSongList.removeWhere((song) => song.songid == recentSong.songid);
      recentSongList.insert(0, recentSong);
      await playlistBox.put('Recent', recentSongList);
    }
  }
}