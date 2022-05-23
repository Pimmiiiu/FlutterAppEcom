import 'package:flutter/material.dart';

import 'checkout_page.dart';

class TotalCard extends StatefulWidget {
  final double? totalPrice; 
  const TotalCard({Key? key, this.totalPrice}) : super(key: key);

  @override
  _TotalCardState createState() => _TotalCardState();
}

class _TotalCardState extends State<TotalCard> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
           Expanded(
            child: Text(
              'Total : \$${widget.totalPrice}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
            flex: 2,
          ),
          Expanded(
              child: ElevatedButton(
                  onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => CheckOutPage(totalPrice: widget.totalPrice.toString())),),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.black))),
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )))
        ],
      ),
    );
  }
}
