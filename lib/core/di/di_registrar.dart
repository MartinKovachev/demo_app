import 'dart:async';

typedef FactoryFunc<T> = T Function();
typedef DisposingFunc<T> = FutureOr<void> Function(T param);

abstract interface class DIRegistrar {
  T call<T extends Object>({String? instanceName});

  void registerFactory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  });

  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });
}
