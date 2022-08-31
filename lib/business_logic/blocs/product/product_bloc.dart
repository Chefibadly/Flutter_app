import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/business_logic/repository/product_repo.dart';

import '../../models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository repoProduct;
  ProductBloc(this.repoProduct) : super(ProductInitialState()) {
    on<StartEvent>(_onStart);
  }

  void _onStart(StartEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    try {
      Product product =
          await repoProduct.getProduct(id: event.productId.toString());
      emit(ProductLoadedState(product: product));
    } catch (error) {
      emit(ProductErrorLoadingState(message: error.toString()));
    }
  }
}
