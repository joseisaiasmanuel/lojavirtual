import 'package:flutter/material.dart';
import 'package:loja_virtual/screen/tabs/home_tab.dart';
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
    ),
       Scaffold(
         appBar: AppBar(
           title: Text("Produtos"),
           centerTitle: true,
         ),
         drawer:CustoDrawer(_pageControlle),
           body:ProductsTab()
       )
     ],
    );
  }
}
