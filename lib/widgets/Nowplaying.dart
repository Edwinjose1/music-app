import 'dart:developer';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/Function/recent.dart';
import 'package:music_app/lyrics_rep/api.dart';
import 'package:music_app/model/song_model.dart';
import 'package:music_app/screens/Screenlyrics.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';



class PlaySong extends StatefulWidget {
  const PlaySong({
    super.key,
    required this.songList,
    required this.audioplayer,
    required this.index,
    required this.id,
  });

  final List<Audio> songList;
  final int index;
  final String id;
  final AssetsAudioPlayer audioplayer;
  @override
  State<PlaySong> createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  bool _isplaying = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // PlaySong();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) {
      return element.path == fromPath;
    });
  }

  @override
  Widget build(BuildContext context) {
     String newLyrics = 'Tap the button to get the Lyrics';
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: widget.audioplayer.builderCurrent(
          builder: (context, playing) {
            final musicAuido =
                find(widget.songList, playing.audio.assetAudioPath);
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.audioplayer.stop();
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 297,
                        width: 297,
                        child: QueryArtworkWidget(
                          artworkBorder: BorderRadius.circular(10),
                          id: int.parse(musicAuido.metas.id!),
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/songimg1.jpg'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: Marquee(
                        blankSpace: 70,
                        startAfter: Duration(seconds: 5),
                        text: widget.audioplayer.getCurrentAudioTitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.audioplayer.getCurrentAudioArtist,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  widget.audioplayer.builderRealtimePlayingInfos(
                      builder: (context, info) {
                    final duration = info.current!.audio.duration;
                    final progress = info.currentPosition;
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ProgressBar(
                        //progress: Duration(milliseconds: 1000),
                        progress: progress,
                        //total: Duration(milliseconds: 2000),
                        total: duration,
                        progressBarColor: Colors.white,
                        thumbColor: Colors.amberAccent,
                        thumbGlowColor: Color.fromARGB(103, 243, 239, 243),
                        baseBarColor: Colors.grey,
                        barHeight: 8,
                        timeLabelTextStyle:
                            TextStyle(color: Colors.white, fontSize: 13),
                        onSeek: ((value) {
                          widget.audioplayer.seek(value);
                        }),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            widget.audioplayer.previous();
                          },
                          icon: Icon(
                            Icons.fast_rewind,
                            size: 30,
                            color: Colors.white,
                          )),
                      GestureDetector(
                        onTap: () {
                          widget.audioplayer.playOrPause();
                          setState(() {
                            // playorpauseIcon ? pauseIcons() : PlayIcon();
                          });
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.amber),
                          child: PlayerBuilder.isPlaying(
                            player: widget.audioplayer,
                            builder: (context, isPlaying) {
                              return isPlaying
                                  ? Icon(
                                      Icons.pause_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    )
                                  : Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    );
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            //_audioPlayer.next();
                            await widget.audioplayer.next();
                          },
                          icon: Icon(
                            Icons.fast_forward,
                            size: 30,
                            color: Colors.white,
                          )),
                         
                    ],
                  ),
                  SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                        IconButton(onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Screen_Lyrics(SongTitile:widget.audioplayer.getCurrentAudioTitle, SongArtist: widget.audioplayer.getCurrentAudioArtist),));
                        }, icon:Icon(Icons.lyrics,color: Colors.white,))
                          ],)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
