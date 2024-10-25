import 'package:demo_app/core/di/di_registrar.dart';
import 'package:demo_app/presentation/common/bloc_factory.dart';
import 'package:demo_app/presentation/page/products_page/products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({
    super.key,
    required DIRegistrar di,
  }) : _di = di;

  final DIRegistrar _di;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Provider(
        create: (context) => BlocFactory(di: _di),
        child: const ProductsPage(),
      ),
    );
  }
}
