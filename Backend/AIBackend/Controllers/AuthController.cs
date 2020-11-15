using AIBackend.Dominio.Interfaces;
using AIBackend.Dominio.Model;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;

namespace AIBackend.Controllers
{
    [AllowAnonymous]
    [Produces("application/json")]
    [Route("api/auth")]
    public class AuthController : ControllerBase
    {
        [HttpPost("generatetoken")]
        public async Task<IActionResult> GenerateToken(
            [FromBody] AuthModel authModel,
            [FromServices] ILoginRepository loginRepository,
            [FromServices] IJwtGenerationCommandHandler handler
        )
        {
            try
            {
                var user = await loginRepository.Obter(authModel);
                return Ok(new { Token = handler.GenerateToken(user), Auth = user });
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }
    }
}
