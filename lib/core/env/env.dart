import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'environments/.env.dev', useConstantCase: true)
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;
}