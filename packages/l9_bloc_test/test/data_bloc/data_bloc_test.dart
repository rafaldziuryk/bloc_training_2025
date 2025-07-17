import 'package:bloc_test/bloc_test.dart';
import 'package:data_service/domain/product_service.dart';
import 'package:data_service/domain/product.dart';
import 'package:data_service/domain/query_input.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:l9_bloc_test/data_bloc/data_bloc.dart';
import 'package:mocktail/mocktail.dart';

class ProductServiceMock extends Mock implements ProductService {}

void main() {
  late ProductServiceMock productService;
  late DataBloc dataBloc;

  setUp(() {
    productService = ProductServiceMock();
    dataBloc = DataBloc(dataService: productService);
  });

  setUpAll(() {
    registerFallbackValue(NoQueryInput());
    registerFallbackValue(NameDescriptionQueryInput(data: 'test'));
  });

  tearDown(() {
    dataBloc.close();
  });

  group('DataBloc', () {
    group('LoadDataEvent', () {
      blocTest<DataBloc, DataState>(
        'emits [DataLoading, DataSuccess] when LoadDataEvent is added and products are loaded successfully',
        setUp: () {
          when(() => productService.getProducts(any())).thenAnswer(
            (_) async => [
              Product(id: '1', name: 'Product 1', description: 'Description 1'),
              Product(id: '2', name: 'Product 2', description: 'Description 2'),
            ],
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(LoadDataEvent()),
        expect: () => [
          DataLoading(),
          DataSuccess([
            Product(id: '1', name: 'Product 1', description: 'Description 1'),
            Product(id: '2', name: 'Product 2', description: 'Description 2'),
          ]),
        ],
        verify: (_) {
          verify(() => productService.getProducts(any())).called(1);
          verifyNoMoreInteractions(productService);
        },
      );

      blocTest<DataBloc, DataState>(
        'emits [DataLoading, DataFailure] when LoadDataEvent is added and service throws exception',
        setUp: () {
          when(() => productService.getProducts(any())).thenThrow(
            Exception('Network error'),
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(LoadDataEvent()),
        expect: () => [
          DataLoading(),
          DataFailure('Exception: Network error'),
        ],
        verify: (_) {
          verify(() => productService.getProducts(any())).called(1);
        },
      );

      blocTest<DataBloc, DataState>(
        'emits [DataLoading, DataSuccess] with empty list when no products are available',
        setUp: () {
          when(() => productService.getProducts(any())).thenAnswer(
            (_) async => [],
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(LoadDataEvent()),
        expect: () => [
          DataLoading(),
          EmptyDataSuccess(),
        ],
        verify: (_) {
          verify(() => productService.getProducts(any())).called(1);
        },
      );
    });

    group('SearchEvent', () {
      blocTest<DataBloc, DataState>(
        'emits [DataLoading, DataSuccess] when SearchEvent is added with valid query',
        setUp: () {
          when(() => productService.getProducts(any())).thenAnswer(
            (_) async => [
              Product(id: '1', name: 'Apple', description: 'Red apple'),
            ],
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(SearchEvent('apple')),
        expect: () => [
          DataLoading(),
          DataSuccess([
            Product(id: '1', name: 'Apple', description: 'Red apple'),
          ]),
        ],
        verify: (_) {
          verify(() => productService.getProducts(any())).called(1);
        },
        wait: const Duration(milliseconds: 400),
      );

      blocTest<DataBloc, DataState>(
        'emits [DataLoading, DataFailure] when SearchEvent is added and service throws exception',
        setUp: () {
          when(() => productService.getProducts(any())).thenThrow(
            Exception('Search failed'),
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(SearchEvent('test')),
        expect: () => [
          DataLoading(),
          DataFailure('Exception: Search failed'),
        ],
        verify: (_) {
          verify(() => productService.getProducts(any())).called(1);
        },
        wait: const Duration(milliseconds: 400),
      );

      blocTest<DataBloc, DataState>(
        'emits [DataLoading, DataSuccess] with empty list when search returns no results',
        setUp: () {
          when(() => productService.getProducts(any())).thenAnswer(
            (_) async => [],
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(SearchEvent('nonexistent')),
        expect: () => [
          DataLoading(),
          DataSuccess([]),
        ],
        verify: (_) {
          verify(() => productService.getProducts(any())).called(1);
        },
        wait: const Duration(milliseconds: 400),
      );
    });

    group('Event Transformation (Debounce)', () {
      blocTest<DataBloc, DataState>(
        'debounces multiple SearchEvents and only processes the last one',
        setUp: () {
          when(() => productService.getProducts(any())).thenAnswer(
            (_) async => [Product(id: '1', name: 'Final Result', description: 'Final')],
          );
        },
        build: () => dataBloc,
        act: (bloc) {
          bloc.add(SearchEvent('first'));
          bloc.add(SearchEvent('second'));
          bloc.add(SearchEvent('final'));
        },
        expect: () => [
          DataLoading(),
          DataSuccess([Product(id: '1', name: 'Final Result', description: 'Final')]),
        ],
        verify: (_) {
          // Only the last search should be called due to debounce
          verify(() => productService.getProducts(any())).called(1);
        },
        wait: const Duration(milliseconds: 400), // Wait for debounce
      );
    });

    group('State Transitions', () {
      blocTest<DataBloc, DataState>(
        'transitions from DataSuccess to DataLoading when new event is added',
        setUp: () {
          when(() => productService.getProducts(any())).thenAnswer(
            (_) async => [Product(id: '1', name: 'Product', description: 'Desc')],
          );
        },
        build: () => dataBloc,
        act: (bloc) async {
          bloc.add(LoadDataEvent());
          await Future.delayed(const Duration(milliseconds: 100));
          bloc.add(SearchEvent('new search'));
        },
        expect: () => [
          DataLoading(),
          DataSuccess([Product(id: '1', name: 'Product', description: 'Desc')]),
          DataLoading(),
          DataSuccess([Product(id: '1', name: 'Product', description: 'Desc')]),
        ],
        wait: const Duration(milliseconds: 600),
      );
    });

    group('Error Handling', () {
      blocTest<DataBloc, DataState>(
        'handles different types of exceptions',
        setUp: () {
          when(() => productService.getProducts(any())).thenThrow(
            ArgumentError('Invalid argument'),
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(LoadDataEvent()),
        expect: () => [
          DataLoading(),
          DataFailure('Invalid argument(s): Invalid argument'),
        ],
      );

      blocTest<DataBloc, DataState>(
        'handles timeout exceptions',
        setUp: () {
          when(() => productService.getProducts(any())).thenAnswer(
            (_) async {
              await Future.delayed(const Duration(seconds: 1));
              return [];
            },
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(LoadDataEvent()),
        expect: () => [
          DataLoading(),
          EmptyDataSuccess(),
        ],
        wait: const Duration(seconds: 2),
      );
    });

    group('Edge Cases', () {
      blocTest<DataBloc, DataState>(
        'handles empty search query',
        setUp: () {
          when(() => productService.getProducts(any())).thenAnswer(
            (_) async => [],
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(SearchEvent('')),
        expect: () => [
          DataLoading(),
          DataSuccess([]),
        ],
        verify: (_) {
          verify(() => productService.getProducts(any())).called(1);
        },
        wait: const Duration(milliseconds: 400),
      );

      blocTest<DataBloc, DataState>(
        'handles very long search query',
        setUp: () {
          when(() => productService.getProducts(any())).thenAnswer(
            (_) async => [],
          );
        },
        build: () => dataBloc,
        act: (bloc) => bloc.add(SearchEvent('a' * 1000)),
        expect: () => [
          DataLoading(),
          DataSuccess([]),
        ],
        verify: (_) {
          verify(() => productService.getProducts(any())).called(1);
        },
        wait: const Duration(milliseconds: 400),
      );
    });
  });
}
