namespace AIBackend.Dominio.Model
{
    public class PesquisaModel
    {
        public int Id { get; set; }
        public string TextoPesquisa { get; set; }
        public int IdTipoPesquisa { get; set; }

        public static explicit operator PesquisaModel(PesquisarCommand source)
        {
            return new PesquisaModel()
            {
                IdTipoPesquisa = source.TipoPesquisa,
                TextoPesquisa = source.Pesquisa
            };
        }
    }
}
