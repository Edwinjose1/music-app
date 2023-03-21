import 'package:hive/hive.dart';
import 'package:music_app/model/song_model.dart';

Box<Songs> getSongBox() {
  return Hive.box<Songs>('Allsongs');
}

Box<List> getPlaylistBox() {
  return Hive.box<List>('Playlist');
}
