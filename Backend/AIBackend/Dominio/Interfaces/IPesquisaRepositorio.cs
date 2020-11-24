using System.Threading.Tasks;
using AIBackend.Dominio.Model;

namespace AIBackend.Dominio.Interfaces
{
    public interface IPesquisaRepositorio
    {
        Task<int> Inserir(PesquisaModel model);
    }
}
