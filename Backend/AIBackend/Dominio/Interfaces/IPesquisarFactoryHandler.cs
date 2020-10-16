namespace AIBackend.Dominio.Interfaces
{
    public interface IPesquisarFactoryHandler
    {
        IPesquisarCommandHandler ObterHandler(TipoPesquisaEnum tipoPesquisaEnum);
    }
}
