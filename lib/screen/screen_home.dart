import 'package:flutter/material.dart';
import 'package:loja_virtual/screen/tabs/orders_tab.dart';
import 'package:loja_virtual/screen/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/cart_button.dart';
import 'package:loja_virtual/widgets/custo_drawer.dart';
import 'package:loja_virtual/screen/tabs/products_tab.dart';

class HomeScreen extends StatelessWidget {
  final _pageControlle=PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageControlle,
      physics: NeverScrollableScrollPhysics(),
     children: [
    Scaffold(
     body: HomeTab(),
      drawer: CustoDrawer(_pageControlle),
      floatingActionButton: CartButton(),

    ),
       Scaffold(
         appBar: AppBar(
           title: Text("Produtos"),
           centerTitle: true,
         ),
         drawer:CustoDrawer(_pageControlle),
           body:ProductsTab(),
          floatingActionButton: CartButton(),
       ),
       Container(color:Colors.yellow),
       Scaffold(
         appBar: AppBar(
           title: Text("Meus Pedidos"),
           centerTitle: true,
         ),
         body:OrdersTab(),
         drawer: CustoDrawer(_pageControlle),
       )
     ],
    );
  }
}
