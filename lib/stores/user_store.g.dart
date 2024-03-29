// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStoreBase, Store {
  final _$userAtom = Atom(name: '_UserStoreBase.user');

  @override
  FirebaseUser get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(FirebaseUser value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$userDataAtom = Atom(name: '_UserStoreBase.userData');

  @override
  UserData get userData {
    _$userDataAtom.context.enforceReadPolicy(_$userDataAtom);
    _$userDataAtom.reportObserved();
    return super.userData;
  }

  @override
  set userData(UserData value) {
    _$userDataAtom.context.conditionallyRunInAction(() {
      super.userData = value;
      _$userDataAtom.reportChanged();
    }, _$userDataAtom, name: '${_$userDataAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_UserStoreBase.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passAtom = Atom(name: '_UserStoreBase.pass');

  @override
  String get pass {
    _$passAtom.context.enforceReadPolicy(_$passAtom);
    _$passAtom.reportObserved();
    return super.pass;
  }

  @override
  set pass(String value) {
    _$passAtom.context.conditionallyRunInAction(() {
      super.pass = value;
      _$passAtom.reportChanged();
    }, _$passAtom, name: '${_$passAtom.name}_set');
  }

  final _$nameAtom = Atom(name: '_UserStoreBase.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$addressAtom = Atom(name: '_UserStoreBase.address');

  @override
  String get address {
    _$addressAtom.context.enforceReadPolicy(_$addressAtom);
    _$addressAtom.reportObserved();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.context.conditionallyRunInAction(() {
      super.address = value;
      _$addressAtom.reportChanged();
    }, _$addressAtom, name: '${_$addressAtom.name}_set');
  }

  final _$cellphoneAtom = Atom(name: '_UserStoreBase.cellphone');

  @override
  String get cellphone {
    _$cellphoneAtom.context.enforceReadPolicy(_$cellphoneAtom);
    _$cellphoneAtom.reportObserved();
    return super.cellphone;
  }

  @override
  set cellphone(String value) {
    _$cellphoneAtom.context.conditionallyRunInAction(() {
      super.cellphone = value;
      _$cellphoneAtom.reportChanged();
    }, _$cellphoneAtom, name: '${_$cellphoneAtom.name}_set');
  }

  final _$isLoggedInAtom = Atom(name: '_UserStoreBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.context.enforceReadPolicy(_$isLoggedInAtom);
    _$isLoggedInAtom.reportObserved();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.context.conditionallyRunInAction(() {
      super.isLoggedIn = value;
      _$isLoggedInAtom.reportChanged();
    }, _$isLoggedInAtom, name: '${_$isLoggedInAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_UserStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$isVisiblePasswordAtom =
      Atom(name: '_UserStoreBase.isVisiblePassword');

  @override
  bool get isVisiblePassword {
    _$isVisiblePasswordAtom.context.enforceReadPolicy(_$isVisiblePasswordAtom);
    _$isVisiblePasswordAtom.reportObserved();
    return super.isVisiblePassword;
  }

  @override
  set isVisiblePassword(bool value) {
    _$isVisiblePasswordAtom.context.conditionallyRunInAction(() {
      super.isVisiblePassword = value;
      _$isVisiblePasswordAtom.reportChanged();
    }, _$isVisiblePasswordAtom, name: '${_$isVisiblePasswordAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<void> login({Function onFail, Function onSuccess}) {
    return _$loginAsyncAction
        .run(() => super.login(onFail: onFail, onSuccess: onSuccess));
  }

  final _$signOutAsyncAction = AsyncAction('signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$_UserStoreBaseActionController =
      ActionController(name: '_UserStoreBase');

  @override
  void setEmail(dynamic value) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction();
    try {
      return super.setEmail(value);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(dynamic value) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction();
    try {
      return super.setPassword(value);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(dynamic value) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction();
    try {
      return super.setName(value);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCellphone(dynamic value) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction();
    try {
      return super.setCellphone(value);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(dynamic value) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction();
    try {
      return super.setAddress(value);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic signUp({Function onFail, Function onSuccess}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction();
    try {
      return super.signUp(onFail: onFail, onSuccess: onSuccess);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleVisiblePassword() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction();
    try {
      return super.toggleVisiblePassword();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'user: ${user.toString()},userData: ${userData.toString()},email: ${email.toString()},pass: ${pass.toString()},name: ${name.toString()},address: ${address.toString()},cellphone: ${cellphone.toString()},isLoggedIn: ${isLoggedIn.toString()},loading: ${loading.toString()},isVisiblePassword: ${isVisiblePassword.toString()}';
    return '{$string}';
  }
}
