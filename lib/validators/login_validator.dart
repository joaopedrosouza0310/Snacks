class LoginValidator {
  String addressValidator(String value) {
    if (value.isEmpty) {
      return "É preciso que defina um endereço para as futuras entregas";
    } else {
      return null;
    }
  }

  String cellphoneValidator(String value) {
    if (value.isEmpty) {
      return "É preciso que defina um celular para contato";
    } else {
      return null;
    }
  }

  String nameValidator(value) {
    if (value.isEmpty || value.length < 5) {
      return "Digite um nome válido maior que 5 caracteres";
    } else {
      return null;
    }
  }

  String emailValidator(value) {
    if (RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value)) {
      return null;
    } else {
      return "Digite um email válido";
    }
  }

  String passwordValidator(String value) {
    if (value.length < 7) {
      return "Sua senha precisa ter mais de 6 caracteres";
    } else {
      return null;
    }
  }
}
