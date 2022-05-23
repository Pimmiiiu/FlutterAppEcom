import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siampiwat/bloc/product_bloc.dart';
import 'package:flutter_siampiwat/cart_page.dart';
import 'package:flutter_siampiwat/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'saved_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Siam Piwat',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Siam Piwat'),
      debugShowCheckedModeBanner:false
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ProductBloc _ProductBloc = ProductBloc();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

 final List _page = [
   const HomePage(),
   const SavedPage(),
   const CartPage()
 ];

  @override
  void initState() {
    _ProductBloc.add(GetHomePage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _ProductBloc,
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.textError),
                ),
              );
            }
          },
          child: _page[_selectedIndex]
        ),
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: FaIcon(Icons.home),
        label: 'Home',
      ),
        BottomNavigationBarItem(
        icon: FaIcon(Icons.favorite),
        label: 'Saved',
      ),
        BottomNavigationBarItem(
        icon: FaIcon(Icons.shopping_cart),
        label: 'Cart',
      ),
    ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
  ),
    );
  }
}
