import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:snacks/screens/home_screen.dart';
import 'package:snacks/stores/user_store.dart';
import 'package:snacks/themes/colors.dart';
import 'package:snacks/widgets/custom_text_field.dart';
import 'package:snacks/validators/login_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with LoginValidator {
  UserStore userStore;
  ReactionDisposer reactionDispoder;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userStore = Provider.of<UserStore>(context);

    reactionDispoder = reaction((_) => userStore.isLoggedIn, (loggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => HomeScreen()));
    });
  }

  void onSuccess() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso"),
      backgroundColor: Theme.of(context).primaryColor,
    ));
  }

  void onFail() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário"),
      backgroundColor: Colors.redAccent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Novo usuário"),
      ),
      backgroundColor: yellowColor,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        height: 160,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: redColor,
                            image: DecorationImage(
                                image: AssetImage("assets/logo.png")))),
                    SizedBox(height: 20),
                    CustomTextField(
                      validator: nameValidator,
                      hint: 'Nome',
                      prefix: Icon(Icons.assignment_ind),
                      textInputType: TextInputType.text,
                      onChanged: userStore.setName,
                      enabled: !userStore.loading,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      validator: emailValidator,
                      hint: 'E-mail',
                      prefix: Icon(Icons.account_circle),
                      textInputType: TextInputType.emailAddress,
                      onChanged: userStore.setEmail,
                      enabled: !userStore.loading,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hint: 'Senha',
                      validator: passwordValidator,
                      prefix: Icon(Icons.lock),
                      textInputType: TextInputType.text,
                      onChanged: userStore.setPassword,
                      obscure: true,
                      enabled: !userStore.loading,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hint: 'Endereço',
                      validator: addressValidator,
                      prefix: Icon(Icons.location_on),
                      textInputType: TextInputType.text,
                      onChanged: userStore.setAddress,
                      enabled: !userStore.loading,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hint: 'Celular',
                      validator: cellphoneValidator,
                      prefix: Icon(Icons.phone_android),
                      textInputType: TextInputType.phone,
                      onChanged: userStore.setCellphone,
                      enabled: !userStore.loading,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: redColor),
                      child: FlatButton(
                        textColor: Colors.white,
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            userStore.signUp(
                                onFail: onFail, onSuccess: onSuccess);
                          }
                        },
                        child: Text(
                          "Criar nova conta",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
