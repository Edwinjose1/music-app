// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_rep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricsRep _$LyricsRepFromJson(Map<String, dynamic> json) => LyricsRep(
      success: json['success'] as bool?,
      requestedtitle: json['requestedtitle'] as String?,
      requestedartist: json['requestedartist'] as String?,
      resolvedtitle: json['resolvedtitle'] as String?,
      resolvedartist: json['resolvedartist'] as String?,
      lyrics: json['lyrics'] as String?,
    );

Map<String, dynamic> _$LyricsRepToJson(LyricsRep instance) => <String, dynamic>{
      'success': instance.success,
      'requestedtitle': instance.requestedtitle,
      'requestedartist': instance.requestedartist,
      'resolvedtitle': instance.resolvedtitle,
      'resolvedartist': instance.resolvedartist,
      'lyrics': instance.lyrics,
    };
