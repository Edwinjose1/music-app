import 'package:json_annotation/json_annotation.dart';

part 'lyrics_rep.g.dart';

@JsonSerializable()
class LyricsRep {
  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'requestedtitle')
  String? requestedtitle;

   @JsonKey(name: 'requestedartist')
  String? requestedartist;

   @JsonKey(name: 'resolvedtitle')
  String? resolvedtitle;

   @JsonKey(name: 'resolvedartist')
  String? resolvedartist;

   @JsonKey(name: 'lyrics')
  String? lyrics;

  LyricsRep({
    this.success,
    this.requestedtitle,
    this.requestedartist,
    this.resolvedtitle,
    this.resolvedartist,
    this.lyrics,
  });

  factory LyricsRep.fromJson(Map<String, dynamic> json) {
    return _$LyricsRepFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsRepToJson(this);
}
