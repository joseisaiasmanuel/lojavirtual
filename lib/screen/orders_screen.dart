import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final String orderId;
  OrdersScreen(this.orderId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pedido Realizado"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
                size: 80.0,
              ),
              Text(
                "Pedido realizado com sucesso!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              Text("Código do pedido: $orderId", style: TextStyle(fontSize: 16.0),)
            ],
          ),
        ));
  }
}
