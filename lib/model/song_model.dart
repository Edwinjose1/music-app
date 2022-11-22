import 'package:hive/hive.dart';
part 'song_model.g.dart';
@HiveType(typeId: 0)
class Songs extends HiveObject {
 
  Songs(
      {required this.songPath,
      required this.songTitle,
      required this.songArtist,
      required this.songid,
      this.flag=0});
 
  @HiveField(0)
  String songPath;

  @HiveField(1)
  String songTitle;

  @HiveField(2)
  String songArtist;

  @HiveField(3)
  int? songid;

  @HiveField(4)
   int? flag;
}
