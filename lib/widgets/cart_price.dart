import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';
class CartPrice extends StatelessWidget {
 final VoidCallback buy;
  CartPrice(this.buy);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context,child,model){
            double price = model.getProductPrice();
            double discount = model.getDescount();
            double shipPrice = model.getShipPrice();
            return Column(
              crossAxisAlignment:CrossAxisAlignment.stretch,
              children: [
                Text("Resumo do Pedido",
                textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget> [
                    Text("Subtotal ${price.toStringAsFixed(2)}"),
                    Text("K\Z 0.00")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget> [
                    Text("Desconto -${discount.toStringAsFixed(2)}"),
                    Text("K\Z 0.00")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget> [
                    Text("Entrega ${shipPrice.toStringAsFixed(2)}"),
                    Text("K\Z 0.00")
                  ],
                ),
                Divider(),
               SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget> [
                    Text("Total",style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("K\Z ${(price + shipPrice - discount).toStringAsFixed(2)}",style: TextStyle (color:Theme.of(context).primaryColor ,fontSize:16.0))
                  ],
                ),
                SizedBox(height: 12.0,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 44,
                    child: RaisedButton(
                      child: Text(
                        "Finalizar Pedido",
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed:buy

                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
