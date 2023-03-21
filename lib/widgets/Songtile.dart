import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/Function/functions.dart';
import 'package:music_app/Function/favourites.dart';
import 'package:music_app/Function/recent.dart';
import 'package:music_app/model/song_model.dart';

import 'package:music_app/widgets/Nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/dataBaseFunctions/db_functions.dart';

class SongListTile extends StatefulWidget {
  const SongListTile({
    Key? key,
    this.icon = Icons.playlist_add,
    required this.onPressed,
    required this.songList,
    required this.index,
    required this.audioPlayer,
  }) : super(key: key);

  final IconData icon;
  final void Function()? onPressed;
  final int index;
  final AssetsAudioPlayer audioPlayer;
  final List<Songs> songList;

  @override
  State<SongListTile> createState() => _SongListTileState();
}

class _SongListTileState extends State<SongListTile> {
  Box<Songs> songBox = getSongBox();
  Box<List> playlistBox = getPlaylistBox();
  final audioPlayer = new AssetsAudioPlayer.withId('0');

  @override
  void initState() {
    super.initState();
    setState(() {
      Favourites.isThisFavourite(id: widget.songList[widget.index].songid!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Recents.addSongsToRecents(
            songId: widget.songList[widget.index].songid.toString());

        showMiniPlayer(
            index: widget.index,
            context: context,
            audioPlayer: audioPlayer,
            songList: widget.songList);
      },
      contentPadding: const EdgeInsets.only(left: 10),
      leading: QueryArtworkWidget(
        artworkBorder: BorderRadius.circular(10),
        id: widget.songList[widget.index].songid!,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/songimg1.jpg',
            fit: BoxFit.cover,
            height: 50,
            width: 50,
          ),
        ),
      ),
      title: Text(
        widget.songList[widget.index].songTitle,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        widget.songList[widget.index].songArtist == '<unknown>'
            ? 'Unknown'
            : widget.songList[widget.index].songArtist,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //palylist button
          IconButton(
            padding: const EdgeInsets.only(left: 0),
            onPressed: widget.onPressed,
            icon: Icon(
              widget.icon,
              color: Colors.white,
              size: 27,
            ),
          ),

          IconButton(
            onPressed: () {
              Favourites.addSongToFavourites(
                context: context,
                id: widget.songList[widget.index].songid!,
              );
              setState(() {
                Favourites.isThisFavourite(
                  id: widget.songList[widget.index].songid!,
                );
              });
            },
            icon: Icon(
              Favourites.isThisFavourite(
                id: widget.songList[widget.index].songid!,
              ),
              color: Colors.white,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
