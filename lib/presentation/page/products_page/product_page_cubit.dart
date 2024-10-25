import 'dart:async';

import 'package:demo_app/core/exception/app_exception.dart';
import 'package:demo_app/core/exception/no_internet_connection_app_exception.dart';
import 'package:demo_app/core/exception/server_error_app_exception.dart';
import 'package:demo_app/core/logger.dart';
import 'package:demo_app/domain/entity/product_entity.dart';
import 'package:demo_app/domain/use_case/get_products_use_case.dart';
import 'package:demo_app/presentation/page/products_page/products_page_state.dart';
import 'package:demo_app/presentation/page/products_page/view_model/product_view_model.dart';
import 'package:demo_app/presentation/page/products_page/view_model/products_page_error_type_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_page_cubit.mapper.dart';

class ProductsPageCubit extends Cubit<ProductsPageState> {
  ProductsPageCubit({required GetProductsUseCase getProductsUseCase})
      : _getProductsUseCase = getProductsUseCase,
        super(const ProductsPageStateInitial());

  final GetProductsUseCase _getProductsUseCase;

  int _cachedPageKey = _firstPageKey;
  static const _firstPageKey = 0;
  static const _pageSize = 5;

  Future<void> refresh() async => _fetchProducts(
        pageKey: _cachedPageKey,
        shouldEmitLoadingState: true,
      );

  Future<void> fetchInitialProducts() => _fetchProducts(
        pageKey: _firstPageKey,
        shouldEmitLoadingState: true,
      );

  Future<void> fetchProducts({required int pageKey}) => _fetchProducts(
        pageKey: pageKey,
        shouldEmitLoadingState: false,
      );

  Future<void> _fetchProducts({
    required int pageKey,
    required shouldEmitLoadingState,
  }) async {
    if (shouldEmitLoadingState) {
      emit(const ProductsPageStateLoading());
    }

    _updateCachedPageKey(pageKey);

    // Simulate network delay.
    await Future<void>.delayed(const Duration(seconds: 1));

    final productsResult = await _getProductsUseCase(
      limit: _pageSize,
      skip: pageKey,
    );

    if (productsResult.isFailure) {
      _emitStateFailureAndLogException(productsResult.exception);

      return;
    }

    final productViewModels = productsResult.data.toProductViewModels();
    final isLastPage = productViewModels.length < _pageSize;

    emit(ProductsPageStateSuccess(
      pageKey: pageKey,
      isLastPage: isLastPage,
      products: productViewModels,
    ));
  }

  void _emitStateFailureAndLogException(AppException exception) {
    emit(ProductsPageStateFailure(errorType: exception.toProductsPageErrorTypeViewModel()));

    Logger.error(
      error: exception,
      stackTrace: exception.stackTrace,
    );
  }

  void _updateCachedPageKey(int newPageKey) {
    _cachedPageKey = newPageKey;
  }
}

extension on AppException {
  ProductsPageErrorTypeViewModel toProductsPageErrorTypeViewModel() {
    return switch (this) {
      NoInternetConnectionAppException() => ProductsPageErrorTypeViewModel.noInternetConnection,
      ServerErrorAppException() => ProductsPageErrorTypeViewModel.serverError,
      _ => ProductsPageErrorTypeViewModel.serverError,
    };
  }
}
