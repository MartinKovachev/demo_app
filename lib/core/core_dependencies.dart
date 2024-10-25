import 'package:demo_app/core/di/dependencies.dart';
import 'package:demo_app/core/di/di_registrar.dart';
import 'package:demo_app/core/network/default_http_client.dart';
import 'package:demo_app/core/network/http_client.dart';

class CoreDependencies implements Dependencies {
  @override
  Future<void> register(DIRegistrar di) async {
    di.registerLazySingleton<HttpClient>(() => DefaultHttpClient());
  }
}
