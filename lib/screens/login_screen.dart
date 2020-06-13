import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:snacks/screens/home_screen.dart';
import 'package:snacks/screens/sign_up_screen.dart';
import 'package:snacks/stores/user_store.dart';
import 'package:snacks/themes/colors.dart';
import 'package:snacks/widgets/custom_icon_button.dart';
import 'package:snacks/widgets/custom_text_field.dart';
import 'package:snacks/validators/login_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginValidator {
  UserStore userStore;
  ReactionDisposer reactionDispoder;
  final  formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userStore = Provider.of<UserStore>(context);

    reactionDispoder = reaction((_) => userStore.isLoggedIn, (loggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: yellowColor.withOpacity(0.3)),
                      child: Text(
                        "Logo aqui",
                        style: TextStyle(
                            fontSize: 35,
                            color: redColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hint: 'E-mail',
                      validator: emailValidator,
                      prefix: Icon(Icons.account_circle),
                      textInputType: TextInputType.emailAddress,
                      onChanged: userStore.setEmail,
                      enabled: !userStore.loading,
                    ),
                    SizedBox(height: 20),
                    Observer(
                      builder: (_) {
                        return CustomTextField(
                          hint: 'Senha',
                          validator: passwordValidator,
                          prefix: Icon(Icons.lock),
                          obscure: !userStore.isVisiblePassword,
                          onChanged: userStore.setPassword,
                          enabled: !userStore.loading,
                          suffix: CustomIconButton(
                            radius: 32,
                            iconData: userStore.isVisiblePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onTap: userStore.toggleVisiblePassword,
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                          child: FlatButton(
                              onPressed: () {},
                              child: Text("Esqueci minha senha")),
                        )
                      ],
                    ),
                    Observer(
                      builder: (_) {
                        return SizedBox(
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            color: redColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if(formKey.currentState.validate()){
                                userStore.login();
                              }
                            },
                            child: !userStore.loading
                                ? Text("Entrar", style: TextStyle(fontSize: 20))
                                : CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SignUpScreen()));
                      },
                      child: Text("Criar uma conta"),
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
