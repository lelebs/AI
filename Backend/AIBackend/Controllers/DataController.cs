using AIBackend.Dominio;
using AIBackend.Dominio.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;

namespace AIBackend.Controllers
{
    [ApiController]
    //[Authorize]
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
            try
            {
                var pesquisaHandler = factory.ObterHandler((TipoPesquisaEnum)command.TipoPesquisa);
                return Ok(await pesquisaHandler.Pesquisar(command));
            }
            catch(Exception ex)
            {
                return BadRequest(ex);
            }
        }

        [HttpGet("obterpesquisas")]
        public async Task<IActionResult> ObterPesquisas([FromServices] IPesquisaRepositorio pesquisaRepositorio)
        {
            try
            {
                return Ok(await pesquisaRepositorio.ObterPesquisas());
            }
            catch(Exception ex)
            {
                return BadRequest(ex);
            }
        }

        [HttpGet("obterpesquisa/{id}")]
        public async Task<IActionResult> ObterPesquisa(int id, [FromServices] IPesquisaItemRepositorio pesquisaItemRepositorio)
        {
            try
            {
                return Ok(await pesquisaItemRepositorio.ObterPesquisa(id));
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }
    }
}
