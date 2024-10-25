import 'package:demo_app/core/di/di_registrar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// We scope what our widgets have access to, so the [DIRegistrar] instance is not directly accessible from
/// a [BuildContext], but this class is instead. It makes sure that only [BlocBase] types can be
/// obtained by our widgets.
class BlocFactory {
  BlocFactory({required DIRegistrar di}) : _di = di;

  final DIRegistrar _di;

  T get<T extends BlocBase>() => _di<T>();
}
