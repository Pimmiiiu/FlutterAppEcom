import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_bloc.dart';
import 'cart_card.dart';
import 'total_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ProductBloc _ProductBloc = ProductBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const Center(
                  child: Icon(
                Icons.shopping_cart_outlined,
                size: 50,
                color: Colors.grey,
              )));
        } else if (state is ProductLoading) {
          return Container(
              color: Colors.white, child: const CircularProgressIndicator());
        } else if (state is ProductSuccess) {
          return Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: Text(
                          'Cart',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      (state.listCart.isEmpty)
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: const Center(
                                  child: Icon(
                                Icons.shopping_cart_outlined,
                                size: 50,
                                color: Colors.grey,
                              )))
                          : Container(
                              padding: const EdgeInsets.all(5),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.listCart.length,
                                  itemBuilder: (context, index) {
                                    return CartCard(
                                        listCart: state.listCart[index],
                                        listNumOfItems:
                                            state.listNumOfItems[index]);
                                  }),
                            ),
                    ],
                  ),
                ),
              ),
              persistentFooterButtons: [TotalCard(totalPrice: totalPrice)]);
        } else if (state is ProductError) {
          return Container(
              color: Colors.white,
              child: Center(
                child: Text(state.textError),
              ));
        } else {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const Center(
                  child: Icon(
                Icons.shopping_cart_outlined,
                size: 50,
                color: Colors.grey,
              )));
        }
      },
    );
  }
}
