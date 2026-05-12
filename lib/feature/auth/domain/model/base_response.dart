import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  BaseResponse({
    this.data,
    required this.status,
    this.message = '',
    this.errors,
  });

  @JsonKey(name: 'data')
  T? data;
  String message;
  bool status;

  Map<String, List<String>>? errors;

  String get error => errors != null
      ? errors!.isNotEmpty
          ? errors!.values.map((e) => e.join(',')).join('\n')
          : message
      : message;

  /// Generated factory constructor
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      BaseResponse<T>(
        data: _$nullableGenericFromJson(json['data'], fromJsonT),
        status: (json['status'] ?? json['success']) as bool,
        message: json['message'] as String? ?? '',
        errors: (json['errors'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              k, (e as List<dynamic>).map((e) => e as String).toList()),
        ),
      );

  factory BaseResponse.fromError(Map<String, dynamic> json) {
    Map<String, List<String>>? errorsMap;
    if (json['errors'] is Map<String, dynamic>) {
      errorsMap = (json['errors'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).map((item) => item.toString()).toList(),
        ),
      );
    }

    return BaseResponse(
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? 'An unknown error occurred.',
      errors: errorsMap,
      data: null,
    );
  }

  /// Generated toJson
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
