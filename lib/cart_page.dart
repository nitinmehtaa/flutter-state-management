import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:state_example/main.dart';

void main() {
  runApp(MaterialApp(
    title: 'cart Page',
    home: CartPage(),
  ));
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart Page"),
        ),
        body: Center(child: ScopedModelDescendant<CounterModel>(
            builder: (context, child, model) {
          if (model.counter == 0) {
            return Center(
              child: Text(
                'Cart is Empty',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 45.0),
              ),
            );
          }
          return Center(
              child: Text(
            model.counter.toString() + ' items',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 45.0),
          ));
        })));
  }
}
