// import 'dart:developer';

// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';

// import 'package:music_app/widgets/Nowplaying.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:music_app/main.dart';

// class AllSongs extends StatefulWidget {
//   const AllSongs({super.key});

//   @override
//   State<AllSongs> createState() => _AllSongsState();
// }

// class _AllSongsState extends State<AllSongs> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     requestpermission();
//   }

//   void requestpermission() {
//     Permission.storage.request();
//   }

//   final OnAudioQuery _audioQuery = OnAudioQuery();
//   final AssetsAudioPlayer assetauidioplayer = AssetsAudioPlayer();

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         FutureBuilder<List<SongModel>>(
//           future: _audioQuery.querySongs(
//             sortType: null,
//             orderType: OrderType.ASC_OR_SMALLER,
//             uriType: UriType.EXTERNAL,
//             ignoreCase: true,
//           ),
//           builder: (context, item) {
//             if (item.data == null) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (item.data!.isEmpty) {
//               return Text("No song found");
//             }
//             return ListView.builder(
//               physics:ScrollPhysics(), 
//               shrinkWrap: true,
//                 itemCount: item.data!.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => PlaySong(
//                                     songs:[index],audioplayer: assetauidioplayer ,
//                                   ),));
//                     },
//                     leading: Icon(Icons.music_note),
//                     title: Text(item.data![index].displayNameWOExt),
//                     subtitle: Text("${item.data![index].artist}"),
//                     trailing: Icon(Icons.more_horiz),
//                   );
//                 });
//           },
//         ),
//       ],
//     );
//   }
//   // playAudio({required String URI,required int Index}){
//   //   assetauidioplayer.
//   // }
// }
