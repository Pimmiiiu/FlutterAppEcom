part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {
  
}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final Product productItems;
  final List<ProductItem> savedItems;
  final List<ProductItem> listCart;
  final List<int> listNumOfItems;
  final double totalPrice;
  const ProductSuccess(this.productItems, this.savedItems, this.listCart, this.listNumOfItems, this.totalPrice);
}

class ProductError extends ProductState {
  final String textError ;
  const ProductError(this.textError);
}
