import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{
  String category;
  String id;
  String title;
  String description;
  int price;
  List imagens;
  List size;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id=snapshot.documentID;
    title=snapshot.data["title"];
    description=snapshot.data["description"];
    price=snapshot.data["price"];
    imagens= snapshot.data["imagens"];
    size=snapshot.data["size"];

  }
  Map<String, dynamic> toResumedMap(){
    return {
      "title" : title,
      "price":price,

    };
  }


}