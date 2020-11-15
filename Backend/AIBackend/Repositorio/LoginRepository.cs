using AIBackend.Dominio.Interfaces;
using AIBackend.Dominio.Model;
using Dapper;
using System.Threading.Tasks;

namespace AIBackend.Repositorio
{
    public class LoginRepository : ILoginRepository
    {
        private readonly ConnectionHandler connectionHandler;

        public LoginRepository(ConnectionHandler connectionHandler)
        {
            this.connectionHandler = connectionHandler;
        }

        public async Task<LoginModel> ObterLogin(AuthModel auth)
        {
            using(var conexao = connectionHandler.Create())
            {
                var sql = @"SELECT * FROM login WHERE email = @Email AND senha = @Password";
                return await conexao.QueryFirstOrDefaultAsync<LoginModel>(sql, auth);
            }
        }
    }
}
