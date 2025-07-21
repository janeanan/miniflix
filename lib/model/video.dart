import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Videos {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "results")
  List<Result>? results;

  Videos({this.id, this.results});

  factory Videos.fromJson(Map<String, dynamic> json) => _$VideosFromJson(json);

  Map<String, dynamic> toJson() => _$VideosToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "iso_639_1")
  String? iso6391;
  @JsonKey(name: "iso_3166_1")
  String? iso31661;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "key")
  String? key;
  @JsonKey(name: "site")
  String? site;
  @JsonKey(name: "size")
  int? size;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "official")
  bool? official;
  @JsonKey(name: "published_at")
  String? publishedAt;
  @JsonKey(name: "id")
  String? id;

  Result({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
