import 'package:flutter/material.dart';
import 'package:paani/screens/customersideapp/drawer.dart';

class Dispatched extends StatefulWidget {
  @override
  DispatchedState createState() => new DispatchedState();
}

class DispatchedState extends State<Dispatched> {
  // static const routeName = '/order_dispatched';
  int estimate = 3323232;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Appbar
        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          // Title
          title: Text("Order Status"),
          centerTitle: true,
        ),
        drawer: DrawerDetails(),
        // Body
        body: Container(
            child: Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 130.0),
                child: Text(
                  "Order Dispatched.",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 170.0,
                width: 170.0,
                margin: EdgeInsets.only(bottom: 170.0),
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('assets/dispatched.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'Estimated Cost: $estimate ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            ]))));
  }
}
