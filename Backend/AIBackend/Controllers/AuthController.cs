using AIBackend.Dominio;
using AIBackend.Dominio.Interfaces;
using AIBackend.Dominio.Model;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;

namespace AIBackend.Controllers
{
    [ApiController]
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
                var user = await loginRepository.ObterLogin(authModel);
                if (user != null)
                    return Ok(new { Token = handler.GenerateToken((JwtGenerationCommand)user), Auth = user });
                else
                    return Unauthorized();
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }
    }
}
