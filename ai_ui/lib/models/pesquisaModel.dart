class PesquisaModel {
  int id;
  String textoPesquisa;
  int idTipoPesquisa;

  PesquisaModel(this.id, this.textoPesquisa, this.idTipoPesquisa);

  factory PesquisaModel.fromJson(Map<dynamic, dynamic> json) {
    return PesquisaModel(
      json['id'] as int,
      json['textoPesquisa'] as String,
      json['idTipoPesquisa'] as int
    );
  }
}