using AIBackend.Dominio;
using AIBackend.Dominio.Interfaces;
using Google.Apis.Books.v1;
using System.Threading.Tasks;
using System.Linq;
using AIBackend.Dominio.Model;
using System.Collections.Generic;

namespace AIBackend.Handler
{
    public class PesquisarLivroCommandHandler : IPesquisarCommandHandler
    {
        private readonly IPesquisaRepositorio pesquisaRepositorio;
        private readonly IPesquisaItemRepositorio pesquisaItemRepositorio;

        public PesquisarLivroCommandHandler(IPesquisaRepositorio pesquisaRepositorio,
            IPesquisaItemRepositorio pesquisaItemRepositorio)
        {
            this.pesquisaRepositorio = pesquisaRepositorio;
            this.pesquisaItemRepositorio = pesquisaItemRepositorio;
        }

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
            var retorno = result.Items.Select(s => new LivroViewModel()
            {
                Autores = string.Join(", ", s.VolumeInfo.Authors),
                IsPdfAvailable = s.SaleInfo.IsEbook ?? false,
                Sinopse = s.VolumeInfo.Description,
                Titulo = s.VolumeInfo.Title,
                UrlThumbnail = s.VolumeInfo.ImageLinks.Thumbnail
            });
            var pesquisaModel = (PesquisaModel)command;
            pesquisaModel.Id = await pesquisaRepositorio.Inserir(pesquisaModel);
            var itens = retorno.Select(s => new PesquisaItemModel()
            {
                Sinopse = s.Sinopse,
                Autores = s.Autores,
                IdPesquisa = pesquisaModel.Id,
                IsPdfAvailable = s.IsPdfAvailable,
                Titulo = s.Titulo,
                UrlThumbnail = s.UrlThumbnail
            });

            var taskList = new List<Task>();
            foreach (var item in itens)
                taskList.Add(pesquisaItemRepositorio.Inserir(item));

            await Task.WhenAll(taskList);
            return retorno;
        }
    }
}
