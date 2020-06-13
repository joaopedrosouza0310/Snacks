import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:snacks/data/cart_data.dart';
import 'package:snacks/stores/user_store.dart';
part 'cart_store.g.dart';

class CartStore = _CartStoreBase with _$CartStore;

abstract class _CartStoreBase with Store {
  UserStore userStore;
  
  @observable
  List<CartData> products = [];

  @observable
  bool loading = false;

  _CartStoreBase(this.userStore) {
    if (userStore.isLoggedIn) {
      loadCartItems();
    }
  }

  @action
  addCartItem(CartData c) {
    Firestore.instance
        .collection("users")
        .document(userStore.user.uid)
        .collection("cart")
        .add(c.toMap())
        .then((doc) {
      c.cartId = doc.documentID;
    });
    products.add(c);
  }

  @action
  Future<void> loadCartItems() async {
    loading = true;
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(userStore.user.uid)
        .collection("cart")
        .getDocuments();

    products = List.of(
        query.documents.map((doc) => CartData.fromDocument(doc)).toList());

    loading = false;

    //products.map((e) => print(e.quantity)).toList();
  }
}
