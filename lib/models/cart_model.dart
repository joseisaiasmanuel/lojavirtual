
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/data/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{
  UserModel user;

  List<CartProduct> products=[];

  CartModel(this.user);

  static CartModel of(BuildContext context)=>
      ScopedModel.of<CartModel>(context);

  // adicionar produtos no carrinho
  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").add(cartProduct.toMap()).then((doc){
      cartProduct.cid= doc.documentID;
    });
    notifyListeners();

  }

  // remover produto
void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cid).delete();

    products.remove(cartProduct);
    notifyListeners();


}




}