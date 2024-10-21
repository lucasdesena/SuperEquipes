///Classe de validadores.
class Validators {
  static String? requerido(String nomeCampo ,String? value){
    if (value!.trim().isEmpty) {
      return 'Informe o campo $nomeCampo corretamente!';
    }

    return null;
  }

  static String? validarNome(String? value) {
    String? mensagem;

    mensagem = requerido('nome', value);

    if (mensagem == null && value!.trim().length < 3 || value!.trim().length > 30) {
      mensagem = 'Informe um nome válido!';
    }

    return mensagem;
  }
}