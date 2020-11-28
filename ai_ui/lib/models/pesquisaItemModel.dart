class PesquisaItem {
  PesquisaItem({
    this.autores,
    this.isPdfAvailable,
    this.sinopse,
    this.titulo,
    this.urlThumbnail
  });

  String autores;
  bool isPdfAvailable;
  String sinopse;
  String titulo;
  String urlThumbnail;

  factory PesquisaItem.fromJson(Map<dynamic, dynamic> json){
    return PesquisaItem(
        autores: json["autores"] as String,
        isPdfAvailable: json["isPdfAvailable"] as bool,
        sinopse: json["sinopse"] as String,
        titulo: json["titulo"] as String,
        urlThumbnail: json["urlThumbnail"] as String);
  }
}