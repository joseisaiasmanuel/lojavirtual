import 'package:flutter/material.dart';
import 'package:loja_virtual/screen/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';

class CustoDrawer extends StatelessWidget {
  final PageController pageController;
  CustoDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget  _buidCustomBack() =>Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              // começo
              begin: Alignment.topCenter,
              // terminio
              end: Alignment.bottomCenter
          )
      ),

    );
    //
    return Drawer(
      child: Stack(
        children:<Widget> [
          _buidCustomBack(),
          ListView(
           padding: EdgeInsets.only(left: 32.0,top: 16.0),
           children: [
             Container(
               margin: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
               height: 170.0,
               child: Stack(
                 children: [
                   Positioned(
                       top: 8.0,
                       left: 0.0,
                       child:
                       Text(
                         "Loja's\nDeliver",
                         style: TextStyle(fontSize: 34.0,
                             fontWeight: FontWeight.bold
                         ),
                       ),

                   ),
                   Positioned(
                       left: 0.0,
                        bottom: 0.0,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("olá", style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                           GestureDetector(
                             child:Text("cadastre-se >", style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),

                             ),
                             onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LoginScreen()));

                             },
                           )
                         ],
                       )
                   )
                 ],
               ),
             ),
             Divider(),
             DrawerTile(Icons.home,"Início",pageController,0),
             DrawerTile(Icons.list,"Produtos",pageController,1),
             DrawerTile(Icons.location_on,"Lojas",pageController,2),
             DrawerTile(Icons.playlist_add_check,"Pedidos",pageController,3)

           ],
          )
        ],

      ),
    );
  }
}
