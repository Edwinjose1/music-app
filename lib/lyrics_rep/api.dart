import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_app/lyrics_rep/lyrics_rep.dart';


Future<LyricsRep> getSongLyrics(
    {required String title, required String artist}) async {
  var uri = Uri.https(
    'powerlyrics.p.rapidapi.com',
    'getlyricsfromtitleandartist',
    {'title': title, 'artist': artist},
  );

  final response = await http.get(
    uri,
    headers: {
      'X-RapidAPI-Key': 'd45ee0adb1mshb1ae3331eb76ed8p1933fbjsn79e87871f0ea',
      'X-RapidAPI-Host': 'powerlyrics.p.rapidapi.com'
    },
  );

  final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;
  final data = LyricsRep.fromJson(decodedBody);

  return data;
}
