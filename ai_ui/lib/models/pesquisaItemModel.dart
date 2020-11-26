class PesquisaItem {
  PesquisaItem({
    this.autores,
    this.isPdfAvailable,
    this.sinopse,
    this.titulo,
    this.urlThumbnail
  });

  List<String> autores = List<String>();
  bool isPdfAvailable;
  String sinopse;
  String titulo;
  String urlThumbnail;

  factory PesquisaItem.fromJson(Map<dynamic, dynamic> json){
    return PesquisaItem(
        autores: (json["autores"] as List).map((e) => e.toString()).toList(),
        isPdfAvailable: json["isPdfAvailable"] as bool,
        sinopse: json["sinopse"] as String,
        titulo: json["titulo"] as String,
        urlThumbnail: json["urlThumbnail"] as String);
  }
}