import 'package:demo_app/core/exception/app_exception.dart';
import 'package:demo_app/core/result.dart';
import 'package:demo_app/data/datasource/remote_products_datasource.dart';
import 'package:demo_app/data/repository/products_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mock.dart';
import '../fake_data_model.dart';

void main() {
  late ProductsRepositoryImpl sut;
  late RemoteProductsDataSource remoteProductsDataSource;

  setUp(() {
    remoteProductsDataSource = MockRemoteProductsDataSource();

    sut = ProductsRepositoryImpl(remoteProductsDataSource: remoteProductsDataSource);
  });

  tearDown(() async {
    reset(remoteProductsDataSource);
  });

  group('ProductsRepositoryImpl', () {
    group('getProducts', () {
      test('should return Result.success with List<ProductEntity>', () async {
        // Arrange
        const limit = 10;
        const skip = 0;
        final fakeProductDataModels = [
          FakeDataModel.productDataModel(id: 1),
          FakeDataModel.productDataModel(id: 2),
        ];

        when(() => remoteProductsDataSource.getProducts(limit: limit, skip: skip))
            .thenAnswer((_) async => Result.success(fakeProductDataModels));

        // Act
        final result = await sut.getProducts(limit: limit, skip: skip);

        // Assert
        verify(() => remoteProductsDataSource.getProducts()).called(1);
        expect(result.isSuccess, true);
        expect(result.data, fakeProductDataModels.toProductEntities());
      });

      test('should return Result.failure with AppException', () async {
        // Arrange
        const limit = 10;
        const skip = 0;
        const exception = AppException(message: 'error', stackTrace: StackTrace.empty);

        when(() => remoteProductsDataSource.getProducts(limit: limit, skip: skip))
            .thenAnswer((_) async => const Result.failure(exception));

        // Act
        final result = await sut.getProducts(limit: limit, skip: skip);

        // Assert
        verify(() => remoteProductsDataSource.getProducts()).called(1);
        expect(result.isFailure, true);
        expect(result.exception, exception);
      });
    });
  });
}
