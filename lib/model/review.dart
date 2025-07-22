import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Reviews {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "page")
  int? page;
  @JsonKey(name: "results")
  List<Result>? results;
  @JsonKey(name: "total_pages")
  int? totalPages;
  @JsonKey(name: "total_results")
  int? totalResults;

  Reviews({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "author")
  String? author;
  @JsonKey(name: "author_details")
  AuthorDetails? authorDetails;
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "url")
  String? url;

  Result({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class AuthorDetails {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "avatar_path")
  String? avatarPath;
  @JsonKey(name: "rating")
  int? rating;

  AuthorDetails({this.name, this.username, this.avatarPath, this.rating});

  factory AuthorDetails.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDetailsToJson(this);
}
