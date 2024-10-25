import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/presentation/common/bloc_factory.dart';
import 'package:demo_app/presentation/common/sizing.dart';
import 'package:demo_app/presentation/page/products_page/product_page_cubit.dart';
import 'package:demo_app/presentation/page/products_page/products_page_state.dart';
import 'package:demo_app/presentation/page/products_page/view_model/product_view_model.dart';
import 'package:demo_app/presentation/page/products_page/view_model/products_page_error_type_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'state_page/initial_state_page.dart';

part 'state_page/loading_state_page.dart';

part 'state_page/success_state_page.dart';

part 'state_page/failure_state_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsPageCubit>(
      create: (context) => context.read<BlocFactory>().get(),
      child: Builder(
        builder: (context) => BlocBuilder<ProductsPageCubit, ProductsPageState>(
          builder: (context, state) {
            final cubit = context.read<ProductsPageCubit>();

            return switch (state) {
              ProductsPageStateInitial() => _InitialStatePage(
                  onFetchProductsPressed: () => cubit.fetchInitialProducts(),
                ),
              ProductsPageStateLoading() => const _LoadingStatePage(),
              final ProductsPageStateSuccess state => _SuccessStatePage(
                  pageKey: state.pageKey,
                  isLastPage: state.isLastPage,
                  products: state.products,
                  onFetchProducts: (pageKey) => cubit.fetchProducts(pageKey: pageKey),
                ),
              final ProductsPageStateFailure state => _FailureStatePage(
                  errorType: state.errorType,
                  onTryAgainPressed: cubit.refresh,
                ),
            };
          },
        ),
      ),
    );
  }
}
