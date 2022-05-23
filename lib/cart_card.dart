import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Model/product_model.dart';
import 'bloc/product_bloc.dart';

class CartCard extends StatefulWidget {
  final ProductItem? listCart;
  final int? listNumOfItems;
  final int? index;
  const CartCard({Key? key, this.listCart, this.listNumOfItems, this.index})
      : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final ProductBloc _ProductBloc = ProductBloc();

  @override
  Widget build(BuildContext context) {
    int numOfItems = widget.listNumOfItems!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<ProductBloc>().add(DeleteCart(widget.listCart));
                // setState(() {});
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                widget.listCart!.imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.listCart!.name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        '\$${widget.listCart!.price}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                      Row(
                        children: [
                          FloatingActionButton(
                              heroTag: null,
                              mini: true,
                              onPressed: () {
                                if (numOfItems > 1) {
                                  numOfItems--;
                                  // setState(() {});
                                  context.read<ProductBloc>().add((NumOfItems(
                                      widget.listCart, numOfItems)));
                                }
                              },
                              child: const Icon(Icons.remove, color: Colors.black87),
                              backgroundColor: Colors.white),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('$numOfItems',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          FloatingActionButton(
                            heroTag: null,
                            mini: true,
                            child: const Icon(Icons.add, color: Colors.black87),
                            backgroundColor: Colors.white,
                            onPressed: () {
                              numOfItems++;
                              // setState(() {});
                              context.read<ProductBloc>().add(
                                  (NumOfItems(widget.listCart, numOfItems)));
                              
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
