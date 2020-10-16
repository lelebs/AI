using AIBackend.Dominio;
using AIBackend.Dominio.Interfaces;
using Google.Apis.Books.v1;
using System.Threading.Tasks;

namespace AIBackend.Handler
{
    public class PesquisarLivroCommandHandler : IPesquisarCommandHandler
    {
        public async Task<object> Pesquisar(PesquisarCommand command)
        {
            var service = new BooksService(new Google.Apis.Services.BaseClientService.Initializer()
            {
                ApiKey = "AIzaSyCMSW6_-zCHM3K8kArW-YT6lj5D8xJlCUI",
                ApplicationName = "AIBackend",
            });

            var query = service.Volumes.List();
            query.Q = command.Pesquisa;
            var result = await query.ExecuteAsync();
            return result.Items;
        }
    }
}
