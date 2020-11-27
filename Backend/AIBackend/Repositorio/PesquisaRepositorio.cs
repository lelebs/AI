using Dapper;
using System.Threading.Tasks;
using AIBackend.Dominio.Model;
using AIBackend.Dominio.Interfaces;
using System.Collections.Generic;

namespace AIBackend.Repositorio
{
    public class PesquisaRepositorio : IPesquisaRepositorio
    {
        private readonly ConnectionHandler connectionHandler;

        public PesquisaRepositorio(ConnectionHandler connectionHandler)
        {
            this.connectionHandler = connectionHandler;
        }

        public async Task<int> Inserir(PesquisaModel model)
        {
            using (var conexao = connectionHandler.Create())
            {
                return await conexao.QueryFirstOrDefaultAsync<int>
                    (
                        @"INSERT INTO pesquisa(textopesquisa, idtipopesquisa)
                            VALUES (@TextoPesquisa, @IdTipoPesquisa)
                            RETURNING id", model
                    );
            }
        }

        public async Task<IList<PesquisaModel>> ObterPesquisas()
        {
            using(var conexao = connectionHandler.Create())
            {
                return (await conexao.QueryAsync<PesquisaModel>("SELECT * FROM pesquisa")).AsList();
            }
        }
    }
}
