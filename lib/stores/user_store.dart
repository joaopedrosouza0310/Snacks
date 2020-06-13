import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:snacks/data/user_data.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  _UserStoreBase() {
    _loadCurrentUser();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @observable
  UserData userData;

  @observable
  String email = "";

  @observable
  String pass = "";

  @observable
  String name = "";

  @observable
  String address = "";

  @observable
  String cellphone = "";

  @observable
  bool isLoggedIn = false;

  @observable
  bool loading = false;

  @observable
  bool isVisiblePassword = false;

  @action
  void setEmail(value) => email = value;

  @action
  void setPassword(value) => pass = value;

  @action
  void setName(value) => name = value;

  @action
  void setCellphone(value) => cellphone = value;

  @action
  void setAddress(value) => address = value;

  Future<Null> _loadCurrentUser() async {
    if (user == null) {
      user = await _auth.currentUser();
    }

    if (user != null) {
      if (userData == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(user.uid)
            .get();
        userData = UserData.fromDocument(docUser);
      }
    }

    if (userData != null) isLoggedIn = true;
    email = "";
    pass = "";
  }

  @action
  Future<void> login({Function onFail, Function onSuccess}) async {
    loading = true;
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((authResult) async {
      user = authResult.user;
      await _loadCurrentUser();
      //onSuccess();
    }).catchError((e) {
      // onFail();
    });

    loading = false;
  }

  @action
  Future<void> signOut() async {
    loading = true;

    await _auth.signOut();
    userData = null;
    user = null;

    isLoggedIn = false;
    loading = false;
  }

  @action
  signUp({Function onFail, Function onSuccess}) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((authResult) async {
      user = authResult.user;

      isLoggedIn = true;
      email = "";
      pass = "";

      //onSuccess();
      await saveUserData();
    }).catchError((e) {
      //onFail();
      print(e);
    });
  }

  saveUserData() async {
    userData = UserData(
        name: name, address: address, cellphone: cellphone, email: email);
    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .setData(userData.toMap());
  }

  @action
  void toggleVisiblePassword() => isVisiblePassword = !isVisiblePassword;
}
