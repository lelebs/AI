using AIBackend.Dominio;
using AIBackend.Dominio.Interfaces;
using System;
using System.Threading.Tasks;

namespace AIBackend.Handler
{
    public class PesquisarFilmeCommandHandler : IPesquisarCommandHandler
    {
        public Task<object> Pesquisar(PesquisarCommand command)
        {
            throw new NotImplementedException();
        }
    }
}
