using AIBackend.Dominio;
using AIBackend.Dominio.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace AIBackend.Controllers
{
    [ApiController]
    [Authorize]
    [Produces("application/json")]
    [Route("api/data")]
    public class DataController : Controller
    {
        private readonly IPesquisarFactoryHandler factory;
        public DataController(IPesquisarFactoryHandler factory)
        {
            this.factory = factory;
        }

        [HttpPost("pesquisar")]
        public async Task<IActionResult> Pesquisar([FromBody] PesquisarCommand command)
        {
            var pesquisaHandler = factory.ObterHandler((TipoPesquisaEnum)command.TipoPesquisa);
            return Ok(pesquisaHandler.Pesquisar(command));
        }
    }
}
