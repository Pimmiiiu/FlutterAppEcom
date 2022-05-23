import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siampiwat/saved_page.dart';
import 'Model/product_model.dart';
import 'bloc/product_bloc.dart';

class DetailPage extends StatefulWidget {
  final ProductItem? productItem;
  final List<ProductItem>? savedItems;
  const DetailPage({Key? key, this.productItem, this.savedItems})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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

  showAlertDialogAddcart(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text('Add to cart')),
      content: Text(widget.productItem!.name),
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const SavedPage()),
            // );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Image.network(
                  widget.productItem!.imageUrl,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                          width: 300,
                          child: Text(
                            widget.productItem!.name,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600),
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        showAlertDialog(context);
                        context
                            .read<ProductBloc>()
                            .add((SavedItems(widget.productItem)));
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.favorite,
                        color:
                            (!widget.savedItems!.contains(widget.productItem))
                                ? Colors.grey
                                : Colors.pink,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Text(
                  '\$${widget.productItem!.price}',
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.purple),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        showAlertDialogAddcart(context);
                        context
                            .read<ProductBloc>()
                            .add((AddCart(widget.productItem)));
                        setState(() {});
                      },
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(15)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
