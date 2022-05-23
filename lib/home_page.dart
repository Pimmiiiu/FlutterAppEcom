import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/product_bloc.dart';
import 'product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const Center(
                  child: Icon(
                Icons.home_outlined,
                size: 50,
                color: Colors.grey,
              )));
        } else if (state is ProductLoading) {
          return Container(
              color: Colors.white, child: const CircularProgressIndicator());
        } else if (state is ProductSuccess) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Text(
                      'For You',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: (2 / 3),
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: state.productItems.productItems!.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                              productItem:
                                  state.productItems.productItems![index],
                              savedItems: state.savedItems);
                        }),
                  )
                ],
              ),
            ),
          );
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
                Icons.home_outlined,
                size: 50,
                color: Colors.grey,
              )));
        }
      },
    );
  }
}
