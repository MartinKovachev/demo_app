import 'package:demo_app/core/di/di_registrar.dart';
import 'package:get_it/get_it.dart' hide FactoryFunc, FactoryFuncParam, DisposingFunc;

class DefaultDIRegistrar implements DIRegistrar {
  DefaultDIRegistrar() : _getIt = GetIt.asNewInstance();

  final GetIt _getIt;

  @override
  T call<T extends Object>({String? instanceName}) => _getIt.get(instanceName: instanceName);

  @override
  void registerFactory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    _getIt.registerFactory(
      () => factoryFunc(),
      instanceName: instanceName,
    );
  }

  @override
  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    _getIt.registerLazySingleton(
      () => factoryFunc(),
      instanceName: instanceName,
      dispose: dispose,
    );
  }
}
