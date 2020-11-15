using AIBackend.Dominio.Model;
using System.Threading.Tasks;

namespace AIBackend.Dominio.Interfaces
{
    public interface ILoginRepository
    {
        Task<LoginModel> ObterLogin(AuthModel auth);
    }
}
