part of '../products_page.dart';

typedef FetchProductsCallback = Future<void> Function(int pageKey);

class _SuccessStatePage extends StatefulWidget {
  const _SuccessStatePage({
    required this.pageKey,
    required this.isLastPage,
    required this.products,
    required this.onFetchProducts,
  });

  final int pageKey;
  final bool isLastPage;
  final List<ProductViewModel> products;
  final FetchProductsCallback onFetchProducts;

  @override
  State<_SuccessStatePage> createState() => _SuccessStatePageState();
}

class _SuccessStatePageState extends State<_SuccessStatePage> {
  late final PagingController<int, ProductViewModel> _pagingController;

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: widget.pageKey);
    _addPagingControllerPageRequestListener(
      firstPageKey: widget.pageKey,
      initialProducts: widget.products,
      isLastPage: widget.isLastPage,
    );
  }

  @override
  void didUpdateWidget(covariant _SuccessStatePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.products != oldWidget.products) {
      _appendPage(
        pageKey: widget.pageKey,
        newProducts: widget.products,
        isLastPage: widget.isLastPage,
      );
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: PagedListView.separated(
        pagingController: _pagingController,
        padding: EdgeInsets.only(
          left: Sizing.s3,
          right: Sizing.s3,
          top: Sizing.s2,
          bottom: MediaQuery.paddingOf(context).bottom + Sizing.s2,
        ),
        separatorBuilder: (_, __) => const SizedBox(height: Sizing.s2),
        builderDelegate: PagedChildBuilderDelegate<ProductViewModel>(
          itemBuilder: (context, product, _) => _ProductCard(product: product),
        ),
      ),
    );
  }

  void _addPagingControllerPageRequestListener({
    required int firstPageKey,
    required List<ProductViewModel> initialProducts,
    required bool isLastPage,
  }) {
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey == firstPageKey) {
        _appendPage(
          pageKey: firstPageKey,
          newProducts: initialProducts,
          isLastPage: isLastPage,
        );

        return;
      }

      widget.onFetchProducts(pageKey);
    });
  }

  void _appendPage({
    required int pageKey,
    required bool isLastPage,
    required List<ProductViewModel> newProducts,
  }) async {
    if (isLastPage) {
      _pagingController.appendLastPage(newProducts);
    } else {
      final nextPageKey = pageKey + newProducts.length;
      _pagingController.appendPage(newProducts, nextPageKey);
    }
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ProductViewModel product;

  @override
  Widget build(BuildContext context) {
    return _ProductCardTappableContainer(
      onTap: (context) => _showSnackBar(context, product.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ProductCardImage(imageUrl: product.thumbnail),
          const SizedBox(width: Sizing.s2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: Sizing.s1),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Sizing.s2),
                Text(
                  '${product.price} €',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, int id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product with id: $id tapped'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

typedef TapCallback = void Function(BuildContext context);

class _ProductCardTappableContainer extends StatelessWidget {
  const _ProductCardTappableContainer({
    required this.onTap,
    required this.child,
  });

  final TapCallback onTap;
  final Widget child;

  static const _borderRadius = BorderRadius.all(Radius.circular(Sizing.s2));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: _borderRadius,
      onTap: () => onTap(context),
      child: Container(
        padding: const EdgeInsets.all(Sizing.s2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: _borderRadius,
        ),
        child: child,
      ),
    );
  }
}

class _ProductCardImage extends StatelessWidget {
  const _ProductCardImage({required this.imageUrl});

  final String imageUrl;

  static const _imageSize = 100.0;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (_, __, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: _imageSize,
      height: _imageSize,
    );
  }
}
