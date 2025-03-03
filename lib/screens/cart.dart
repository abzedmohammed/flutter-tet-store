import 'package:flutter/material.dart';
import 'package:tet_store/widgets/app_bar_widgets.dart';
import 'package:tet_store/widgets/yellow_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.back});

  final Widget? back;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: widget.back,
            title: AppBarTitle(title: 'Cart'),
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_forever, color: Colors.black),
              ),
            ],
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(25),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * .6,
                    onPressed: () {
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                      Navigator.of(
                        context,
                      ).pushReplacementNamed('/customer_home');
                    },
                    child: Text(
                      'Contiue Shopping',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Total: \$ ', style: TextStyle(fontSize: 18)),
                      Text(
                        '00.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  YellowButton(width: .45, label: 'Checkout', onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
