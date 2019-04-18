import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:state_example/cart_button.dart';
import 'package:state_example/cart_page.dart';

void main() {
  runApp(MyApp(
    model: CounterModel(),
  ));
}

class MyApp extends StatelessWidget {
  final CounterModel model;

  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // At the top level of our app, we'll, create a ScopedModel Widget. This
    // will provide the CounterModel to all children in the app that request it
    // using a ScopedModelDescendant.
    return ScopedModel<CounterModel>(
      model: model,
      child: MaterialApp(
        title: 'Scoped Model Demo',
        home: CounterHome('Scoped Model Demo'),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/cartpage': (context) => CartPage(),
        },
      ),
    );
  }
}

class CounterModel extends Model {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    if (_counter < 0) {
      _counter = 0;
    }
    notifyListeners();
  }
}

class CounterHome extends StatelessWidget {
  final String title;
  CounterHome(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          ScopedModelDescendant<CounterModel>(
            builder: (context, child, model) {
              return CartButton(
                itemCount: model.counter,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                },
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Adding items to Cart', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.red),),
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) {
                return Text(
                  model.counter.toString(),
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0, color: Colors.green),
                );
              },
            ),
            new Row(
              children: <Widget>[
                Expanded(child: ScopedModelDescendant<CounterModel>(
                  builder: (context, child, model) {
                    return FloatingActionButton(
                      heroTag: 'remove button',
                      onPressed: model.decrement,
                      tooltip: 'Removing Product',
                      child: Icon(Icons.remove),
                    );
                  },
                )),
                Expanded(child: ScopedModelDescendant<CounterModel>(
                  builder: (context, child, model) {
                    return FloatingActionButton(
                      heroTag: 'add button',
                      onPressed: model.increment,
                      tooltip: 'Adding Product',
                      child: Icon(Icons.add),
                    );
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
