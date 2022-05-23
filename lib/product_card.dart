import 'package:flutter/material.dart';
import 'package:flutter_siampiwat/bloc/product_bloc.dart';
import 'Model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_page.dart';

class ProductCard extends StatefulWidget {
  final ProductItem? productItem;
  final List<ProductItem>? savedItems;
  const ProductCard({Key? key, this.productItem, this.savedItems})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text(widget.productItem!.name)),
      content: Text((!widget.savedItems!.contains(widget.productItem))
          ? 'Saved'
          : 'Unsaved'),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProductBloc _ProductBloc = ProductBloc();

    return InkWell(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (_) => ProductBloc(),
                      child: DetailPage(
                          productItem: widget.productItem,
                          savedItems: widget.savedItems),
                    )));
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.all(5),
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
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Stack(
                  children: [
                    Image.network(
                      widget.productItem!.imageUrl,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            showAlertDialog(context);
                            context
                                .read<ProductBloc>()
                                .add(SavedItems(widget.productItem));
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: (!widget.savedItems!
                                    .contains(widget.productItem))
                                ? Colors.grey
                                : Colors.pink,
                          ),
                        )),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
              child: Text(widget.productItem!.name,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),maxLines:2),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Text('\$${widget.productItem!.price}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.purple),),
            ),
          ],
        ),
      ),
    );
  }
}
