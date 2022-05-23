import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siampiwat/product_card.dart';

import 'bloc/product_bloc.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          return Container(
            color: Colors.white,
            child: const Text('initial'),
          );
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
                        'Saved',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            ),
                      ),
                    ),
                    (state.savedItems.isEmpty)
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: const Center(
                                child: Icon(
                              Icons.favorite_border_outlined,
                              size: 50,
                              color: Colors.grey,
                            )))
                        : Container(
                            padding: const EdgeInsets.all(5),
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
                                itemCount: state.savedItems.length,
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                      productItem: state.savedItems[index],
                                      savedItems: state.savedItems);
                                }),
                          ),
                  ],
                ),
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
                Icons.favorite_border_outlined,
                size: 50,
                color: Colors.grey,
              )));
        }
      },
    );
  }
}
