part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends ProductEvent {
  final String productId;

  const StartEvent({required this.productId});
}

class ButButtonPressed extends ProductEvent {}
