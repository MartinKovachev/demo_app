part of '../products_page.dart';

class _InitialStatePage extends StatelessWidget {
  const _InitialStatePage({required this.onFetchProductsPressed});

  final VoidCallback onFetchProductsPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onFetchProductsPressed,
              child: const Text('Get Items'),
            ),
          ],
        ),
      ),
    );
  }
}
