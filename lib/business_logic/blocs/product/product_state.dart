part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final Product product;
  const ProductLoadedState({required this.product});
  @override
  List<Object> get props => [product];
}

class ProductErrorLoadingState extends ProductState {
  final String message;

  const ProductErrorLoadingState({required this.message});
}
