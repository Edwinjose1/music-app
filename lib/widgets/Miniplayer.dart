import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/Function/recent.dart';
import 'package:music_app/model/song_model.dart';
import 'package:music_app/widgets/Nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer(
      {super.key,
      required this.songList,
      required this.index,
      required this.audioPlayer});
  final List<Songs> songList;
  final int index;
  final AssetsAudioPlayer audioPlayer;
  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  List<Audio> songaudio = [];

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  convertMusic() {
    for (var song in widget.songList) {
      songaudio.add(
        Audio.file(song.songPath,
            metas: Metas(
              title: song.songTitle,
              id: song.songid.toString(),
              artist: song.songArtist,
            )),
      );
    }
  }

  Future<void> openAudioPLayer() async {
    convertMusic();

    await widget.audioPlayer.open(
      Playlist(
        audios: songaudio,
        startIndex: widget.index,
      ),
      autoStart: true,
      showNotification: true,
      playInBackground: PlayInBackground.enabled,
    );
  }

  @override
  void initState() {
    openAudioPLayer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return widget.audioPlayer.builderCurrent(
      builder: (context, playing) {
        final myAudio = find(songaudio, playing.audio.assetAudioPath);
        Recents.addSongsToRecents(songId: myAudio.metas.id!);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // height: 75,
          height: screenHeight * 0.075,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            // borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return PlaySong(
                        audioplayer: widget.audioPlayer,
                        id: myAudio.metas.id!,
                        index: widget.index,
                        songList: songaudio,
                      );
                    },
                  ),
                );
              },
              contentPadding: EdgeInsets.zero,
              leading: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(10),
                  id: int.parse(myAudio.metas.id!),
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/songimg3.jpg',
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  )),
              
              title: TextScroll(
                widget.audioPlayer.getCurrentAudioTitle,
                velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await widget.audioPlayer.previous();
                    },
                    child: const Icon(
                      Icons.skip_previous,
                      color: Colors.blue,
                      size: 33,
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () async {
                      await widget.audioPlayer.playOrPause();
                    },
                    child: PlayerBuilder.isPlaying(
                        player: widget.audioPlayer,
                        builder: (context, isPlaying) {
                          return Icon(
                            isPlaying == true ? Icons.pause : Icons.play_arrow,
                            color: Colors.blue,
                            size: 33,
                          );
                        }),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () async {
                      await widget.audioPlayer.next();
                    },
                    child: const Icon(
                      Icons.skip_next,
                      color: Colors.blue,
                      size: 33,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
