// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_siampiwat/Model/product_model.dart';
import 'package:flutter_siampiwat/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ProductItem? productItemTest = ProductItem(
      id: 1,
      name: "Puma White (New)",
      imageUrl:
          "https://images.unsplash.com/photo-1608231387042-66d1773070a5?fit=crop&w=300&q=80",
      price: 250.00);

  List<ProductItem> listSavedTest = [productItemTest];
  List<ProductItem> listSavedTestEmpty = [productItemTest];

  List<ProductItem> listCartTest = [productItemTest];
  List<ProductItem> listCartTestEmpty = [];

  List<int> listNumOfItemsTest = [1];
  List<int> listNumOfItemsTestEmpty = [];

  double totalPriceTest = 250;
  double totalPriceTestEmpty = 0;

  Product productTest = Product(productItems: [productItemTest]);
  group('Product Bloc', () {
    blocTest<ProductBloc, ProductState>(
      'emit list items that saved',
      build: () => ProductBloc(),
      act: (bloc) => bloc.add(SavedItems(productItemTest)),
      expect: () => [
        ProductLoading(),
        ProductSuccess(
            productTest, listSavedTest, listCartTestEmpty, listNumOfItemsTestEmpty, totalPriceTestEmpty)
      ],
    );
    blocTest<ProductBloc, ProductState>(
      'emit Add Product to list cart , add number of Item and sum total price ',
      build: () => ProductBloc(),
      act: (bloc) => bloc.add(AddCart(productItemTest)),
      expect: () => [
        ProductLoading(),
        ProductSuccess(
            productTest, listSavedTestEmpty, listCartTest, listNumOfItemsTest, totalPriceTest)
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emit number of Item',
      build: () => ProductBloc(),
      act: (bloc) => bloc.add(NumOfItems(productItemTest,1)),
      expect: () => [
        ProductLoading(),
        ProductSuccess(
            productTest, listSavedTestEmpty, listCartTest, listNumOfItemsTest, totalPriceTest)
      ],
    );

      blocTest<ProductBloc, ProductState>(
      'delete product in list cart and emit new list cart',
      build: () => ProductBloc(),
      act: (bloc) => bloc.add(DeleteCart(productItemTest)),
      expect: () => [
        ProductLoading(),
        ProductSuccess(
            productTest, listSavedTestEmpty, listCartTest, listNumOfItemsTest, totalPriceTest)
      ],
    );
  });
}
