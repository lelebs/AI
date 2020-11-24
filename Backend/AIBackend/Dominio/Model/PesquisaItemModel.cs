namespace AIBackend.Dominio.Model
{
    public class PesquisaItemModel
    {
        public int Id { get; set; }
        public int IdPesquisa { get; set; }
        public string Autores { get; set; }
        public bool IsPdfAvailable { get; set; }
        public string Sinopse { get; set; } = string.Empty;
        public string Titulo { get; set; } = string.Empty;
        public string UrlThumbnail { get; set; }

        public static explicit operator PesquisaItemModel(LivroViewModel viewModel)
        {
            return new PesquisaItemModel()
            {
                Autores = string.Join(",", viewModel.Autores),
                IsPdfAvailable = viewModel.IsPdfAvailable,
                Sinopse = viewModel.Sinopse,
                Titulo = viewModel.Titulo,
                UrlThumbnail = viewModel.UrlThumbnail
            };
        }
    }
}
