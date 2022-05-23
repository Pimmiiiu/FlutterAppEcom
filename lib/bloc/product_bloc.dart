import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_siampiwat/Model/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

List<ProductItem> listSaved = [];
List<ProductItem> listCart = [];
List<int> listNumOfItems = [];
double totalPrice = 0;
Product productItems = Product(productItems: []);

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetHomePage>((event, emit) async {
      try {
        emit(ProductLoading());
        var jsonText = await rootBundle.loadString('assets/ProductData.json');
        productItems = productFromJson(jsonText);
        emit(ProductSuccess(
            productItems, listSaved, listCart, listNumOfItems, totalPrice));
      } on Error {
        emit(const ProductError('Error 2'));
      }
    });

    on<SavedItems>((event, emit) {
      emit(ProductLoading());
      if (listSaved.contains(event.productItem)) {
        listSaved.remove(event.productItem!);
      } else if (!listSaved.contains(event.productItem)) {
        listSaved.add(event.productItem!);
      }
      emit(ProductSuccess(
          productItems, listSaved, listCart, listNumOfItems, totalPrice));
    });

    on<AddCart>((event, emit) async {
      emit(ProductLoading());
      if (!listCart.contains(event.productItem)) {
        listCart.add(event.productItem!);
      }
      listNumOfItems.add(1);
      totalPrice = 0;
      for (int i = 0; i < listCart.length; i++) {
        totalPrice += listCart[i].price * listNumOfItems[i];
      }
      emit(ProductSuccess(
          productItems, listSaved, listCart, listNumOfItems, totalPrice));
    });

    on<NumOfItems>((event, emit) async {
      emit(ProductLoading());
      int index;
      index = listCart.indexOf(event.productItem!);
      listNumOfItems[index] = event.numOfItems!;
      totalPrice = 0;
      for (int i = 0; i < listCart.length; i++) {
        totalPrice += listCart[i].price * listNumOfItems[i];
      }
      emit(ProductSuccess(
          productItems, listSaved, listCart, listNumOfItems, totalPrice));
    });

    on<DeleteCart>((event, emit) async {
      emit(ProductLoading());
      int index;
      index = listCart.indexOf(event.productItem!);
      totalPrice = totalPrice - (listCart[index].price * listNumOfItems[index]);
      listNumOfItems.removeAt(index);
      listCart.removeAt(index);
      emit(ProductSuccess(
          productItems, listSaved, listCart, listNumOfItems, totalPrice));
    });
  }
}
