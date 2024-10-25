part of '../products_page.dart';

class _LoadingStatePage extends StatelessWidget {
  const _LoadingStatePage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
