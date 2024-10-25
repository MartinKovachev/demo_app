import 'package:demo_app/core/di/di_registrar.dart';

abstract interface class Dependencies {
  Future<void> register(DIRegistrar di);
}
