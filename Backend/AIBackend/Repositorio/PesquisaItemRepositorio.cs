using Dapper;
using System.Threading.Tasks;
using AIBackend.Dominio.Model;
using AIBackend.Dominio.Interfaces;
using System.Collections.Generic;

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

        public async Task<IList<PesquisaItemModel>> ObterPesquisa(int idPesquisa)
        {
            using (var conexao = connectionHandler.Create())
            {
                return (await conexao.QueryAsync<PesquisaItemModel>("SELECT * FROM pesquisaitem WHERE idpesquisa = @idPesquisa", new { idPesquisa })).AsList();
            }
        }
    }
}
