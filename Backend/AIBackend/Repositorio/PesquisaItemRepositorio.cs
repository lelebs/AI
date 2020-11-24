using Dapper;
using System.Threading.Tasks;
using AIBackend.Dominio.Model;
using AIBackend.Dominio.Interfaces;

namespace AIBackend.Repositorio
{
    public class PesquisaItemRepositorio : IPesquisaItemRepositorio
    {
        private readonly ConnectionHandler connectionHandler;
        public PesquisaItemRepositorio(ConnectionHandler connectionHandler)
        {
            this.connectionHandler = connectionHandler;
        }

        public async Task<int> Inserir(PesquisaItemModel model)
        {
            var query = @"INSERT INTO pesquisaitem (idpesquisa, autores, ispdfavailable,sinopse,titulo,urlthumbnail)
                          VALUES (@IdPesquisa, @Autores, @IsPdfAvailable, @Sinopse, @Titulo, @UrlThumbnail) RETURNING id";

            using (var conexao = connectionHandler.Create())
            {
                model.Id = await conexao.QueryFirstOrDefaultAsync<int>(query, model);
                return model.Id;
            }
        }
    }
}
