import 'dart:async';

import 'package:demo_app/core/di/default_di_registrar.dart';
import 'package:demo_app/core/di/dependencies.dart';
import 'package:demo_app/core/di/di_registrar.dart';
import 'package:demo_app/core/logger.dart';
import 'package:demo_app/data/data_dependencies.dart';
import 'package:demo_app/domain/domain_dependencies.dart';
import 'package:demo_app/presentation/demo_app.dart';
import 'package:demo_app/presentation/presentation_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  _runAppZonedGuarded();
}

Future<void> _runAppZonedGuarded() async {
  await runZonedGuarded(
    () async {
      final di = DefaultDIRegistrar();
      await _registerDependencies(di);
      runApp(DemoApp(di: di));
    },
    (error, StackTrace stackTrace) {
      Logger.error(
        error: error,
        stackTrace: stackTrace,
      );
    },
  );
}

Future<void> _registerDependencies(DIRegistrar di) async {
  final dependencies = <Dependencies>[
    DomainDependencies(),
    DataDependencies(),
    PresentationDependencies(),
  ];

  for (final dependency in dependencies) {
    await dependency.register(di);
  }
}
