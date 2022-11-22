import 'package:hive_flutter/hive_flutter.dart';

import '../model/dataBaseFunctions/db_functions.dart';
import '../model/song_model.dart';

class Mostplayed{
  static final Box<Songs> songBox=getSongBox();
  static final Box<List> playlistBox=getPlaylistBox();
  

  static addSongToPlaylist(String songId)async{
    final mostplayedsongsList=playlistBox.get('Most Played')!.toList().cast<Songs>();
    final dbsonog=songBox.values.toList().cast<Songs>();


    final mostplayedsong=dbsonog.firstWhere((song) => song.songid.toString().contains(songId));
    if(mostplayedsongsList.length > 10)
    {
    mostplayedsongsList.removeLast();
    }
    if(mostplayedsong.flag!>=5)
    {
      if(mostplayedsongsList.where((song) => song.songid==mostplayedsong.songid).isEmpty)
      {
        mostplayedsongsList.insert(0, mostplayedsong);
        await playlistBox.put('Most Played', mostplayedsongsList);
      }
      else
      {
        mostplayedsongsList.removeWhere((song) =>song.songid==mostplayedsong.songid );
        mostplayedsongsList.insert(0, mostplayedsong);
        await playlistBox.put('Most Played', mostplayedsongsList);

      }
    }
  }


}