using System.Threading.Tasks;

namespace AIBackend.Dominio.Interfaces
{
    public interface IPesquisarCommandHandler
    {
        Task<object> Pesquisar(PesquisarCommand command);
    }
}
