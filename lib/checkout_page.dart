import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckOutPage extends StatelessWidget {
  final String? totalPrice;
  const CheckOutPage({Key? key, this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text('Checkout',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500 , color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImage(
                data:
                    "https://payment.spw.challenge/checkout?price=$totalPrice",
                version: QrVersions.auto,
                size: 200.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text('Scan & Pay',
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Text('\$$totalPrice',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }
}
