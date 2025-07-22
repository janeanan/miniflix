import 'package:json_annotation/json_annotation.dart';

part 'credits.g.dart';

@JsonSerializable()
class Credits {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "cast")
  List<Cast>? cast;
  @JsonKey(name: "crew")
  List<Crew>? crew;

  Credits({this.id, this.cast, this.crew});

  factory Credits.fromJson(Map<String, dynamic> json) =>
      _$CreditsFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsToJson(this);
}

@JsonSerializable()
class Cast {
  @JsonKey(name: "adult")
  bool? adult;
  @JsonKey(name: "gender")
  int? gender;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "known_for_department")
  String? knownForDepartment;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "original_name")
  String? originalName;
  @JsonKey(name: "popularity")
  double? popularity;
  @JsonKey(name: "profile_path")
  String? profilePath;
  @JsonKey(name: "cast_id")
  int? castId;
  @JsonKey(name: "character")
  String? character;
  @JsonKey(name: "credit_id")
  String? creditId;
  @JsonKey(name: "order")
  int? order;

  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable()
class Crew {
  @JsonKey(name: "adult")
  bool? adult;
  @JsonKey(name: "gender")
  int? gender;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "known_for_department")
  String? knownForDepartment;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "original_name")
  String? originalName;
  @JsonKey(name: "popularity")
  double? popularity;
  @JsonKey(name: "profile_path")
  String? profilePath;
  @JsonKey(name: "credit_id")
  String? creditId;
  @JsonKey(name: "department")
  String? department;
  @JsonKey(name: "job")
  String? job;

  Crew({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.creditId,
    this.department,
    this.job,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);
}
