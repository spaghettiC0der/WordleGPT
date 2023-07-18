import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'locks.env')
abstract class Env {
  @EnviedField(varName: 'KEYY', obfuscate: true)
  static String KEYY = _Env.KEYY;
}
