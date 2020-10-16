using AIBackend.Dominio;
using AIBackend.Dominio.Interfaces;
using System.Collections.Generic;

namespace AIBackend.Handler
{
    public class PesquisarFactoryHandler : IPesquisarFactoryHandler
    {
        private readonly IDictionary<TipoPesquisaEnum, IPesquisarCommandHandler> factory;

        public PesquisarFactoryHandler(
            PesquisarFilmeCommandHandler pesquisarFilmeCommandHandler,
            PesquisarLivroCommandHandler pesquisarLivroCommandHandler)
        {
            factory = new Dictionary<TipoPesquisaEnum, IPesquisarCommandHandler>()
            {
                { TipoPesquisaEnum.Filme, pesquisarFilmeCommandHandler },
                { TipoPesquisaEnum.Livro, pesquisarLivroCommandHandler },
            };
        }

        public IPesquisarCommandHandler ObterHandler(TipoPesquisaEnum tipoPesquisaEnum)
        {
            return factory[tipoPesquisaEnum];
        }
    }
}
