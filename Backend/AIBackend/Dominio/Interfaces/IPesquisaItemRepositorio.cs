using System.Threading.Tasks;
using AIBackend.Dominio.Model;

namespace AIBackend.Dominio.Interfaces
{
    public interface IPesquisaItemRepositorio
    {
        Task<int> Inserir(PesquisaItemModel model);
    }
}
