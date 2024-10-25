import 'package:demo_app/presentation/page/products_page/view_model/product_view_model.dart';
import 'package:demo_app/presentation/page/products_page/view_model/products_page_error_type_view_model.dart';
import 'package:equatable/equatable.dart';

sealed class ProductsPageState {
  const ProductsPageState();
}

class ProductsPageStateInitial extends ProductsPageState {
  const ProductsPageStateInitial();
}

class ProductsPageStateLoading extends ProductsPageState {
  const ProductsPageStateLoading();
}

class ProductsPageStateSuccess extends ProductsPageState with EquatableMixin {
  const ProductsPageStateSuccess({
    required this.pageKey,
    required this.isLastPage,
    required this.products,
  });

  final int pageKey;
  final bool isLastPage;
  final List<ProductViewModel> products;

  @override
  List<Object> get props => [
        pageKey,
        isLastPage,
        products,
      ];
}

class ProductsPageStateFailure extends ProductsPageState with EquatableMixin {
  const ProductsPageStateFailure({required this.errorType});

  final ProductsPageErrorTypeViewModel errorType;

  @override
  List<Object> get props => [errorType];
}
