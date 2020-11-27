using System.Collections.Generic;
using System.Threading.Tasks;
using AIBackend.Dominio.Model;

namespace AIBackend.Dominio.Interfaces
{
    public interface IPesquisaRepositorio
    {
        Task<int> Inserir(PesquisaModel model);

        Task<IList<PesquisaModel>> ObterPesquisas();
    }
}
