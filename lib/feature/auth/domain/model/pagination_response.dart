import 'package:json_annotation/json_annotation.dart';

part 'pagination_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationResponse<T> {
  PaginationResponse({this.data, required this.currentPage, this.lastPage});

  @JsonKey(name: 'data')
  T? data;
  @JsonKey(name: 'current_page')
  int currentPage;
  @JsonKey(name: 'last_page')
  int? lastPage;

  /// Generated factory constructor
  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationResponseFromJson(json, fromJsonT);

  /// Generated toJson
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginationResponseToJson(this, toJsonT);
}
