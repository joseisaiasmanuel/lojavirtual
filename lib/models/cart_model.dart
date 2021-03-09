import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/data/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];

  String couponCode;
  int discountPercentage = 0;
  bool isLoading = false;

  CartModel(this.user) {
    if (user.isLoggedIn()) _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  // adicionar produtos no carrinho
  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  // remover produto
  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.pid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  // salvar o desconto
  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }
  // actualizar os preços

  void updatePrice() {
    notifyListeners();
  }

  //  subtotal
  double getProductPrice() {
    double price = 0.0;
    for (CartProduct c in products) {
      if (c.productData != null) {
        price += c.quantity * c.productData.price;
      }
      return price;
    }
  }

  // desconto
  double getDescount() {
    return getProductPrice() * discountPercentage / 100;
  }

  double getShipPrice() {
    return 9.99;
  }

  // salvar o total de ordenação dos pedidos

  Future<String> finishOrder() async {
    if (products.length == 0) return null;
    isLoading = true;
    notifyListeners();

    double productsPrice = getProductPrice();
    double ship = getShipPrice();
    double discout = getDescount();

    DocumentReference refOrder =
        await Firestore.instance.collection("orders").add({
      "clientId": user.firebaseUser.uid,
        "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
      "shipPrice": ship,
      "productsPrice":productsPrice,
      "discout": discout,
      "totalPrice": productsPrice - discout + ship,
      "status": 1
    });

    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("orders")
        .document(refOrder.documentID)
        .setData({"orderId": refOrder.documentID});

    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    for (DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }
    products.clear();
    couponCode = null;
    discountPercentage=0;

    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();
    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }
}
