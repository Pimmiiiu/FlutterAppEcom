part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetHomePage extends ProductEvent{}

class SavedItems extends ProductEvent{
  final ProductItem? productItem;
  const SavedItems(this.productItem);
}

class AddCart extends ProductEvent{
  final ProductItem? productItem;
  const AddCart(this.productItem);
}

class NumOfItems extends ProductEvent{
  final ProductItem? productItem;
  final int? numOfItems;
  const NumOfItems(this.productItem, this.numOfItems);
}

class DeleteCart extends ProductEvent{
  final ProductItem? productItem;
  const DeleteCart(this.productItem);
}
