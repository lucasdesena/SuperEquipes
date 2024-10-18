///Classe que representa os possíveis resultados.
sealed class Resultado<T> {}

///Subclasse representando o sucesso.
class Sucesso<T> extends Resultado<T> {
  final T dados;
  Sucesso(this.dados);
}

///Subclasse representando erro.
class Erro<T> extends Resultado<T> {
  final String mensagem;
  Erro(this.mensagem);
}