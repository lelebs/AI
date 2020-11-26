class PesquisaCommand {
  String pesquisa;
  int tipoPesquisa;

  PesquisaCommand(this.pesquisa, this.tipoPesquisa);

  Map<String, dynamic> toJson(){
    return {
      "TipoPesquisa": this.tipoPesquisa,
      "Pesquisa": this.pesquisa
    };
  }
}