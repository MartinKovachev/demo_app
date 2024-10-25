part of '../products_page.dart';

class _FailureStatePage extends StatelessWidget {
  const _FailureStatePage({
    required this.errorType,
    required this.onTryAgainPressed,
  });

  final ProductsPageErrorTypeViewModel errorType;
  final VoidCallback onTryAgainPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorType.toLocalizedString(context)),
            ElevatedButton(
              onPressed: onTryAgainPressed,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on ProductsPageErrorTypeViewModel {
  // It should return localized string,
  // but for the sake of simplicity we return the same string in english.
  String toLocalizedString(BuildContext context) {
    return switch (this) {
      ProductsPageErrorTypeViewModel.noInternetConnection => 'No internet connection',
      ProductsPageErrorTypeViewModel.serverError => 'Server error',
    };
  }
}