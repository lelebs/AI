using AIBackend.Dominio;
using AIBackend.Dominio.Interfaces;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Text;

namespace AIBackend.Handler
{
    public class JwtGenerationCommandHandler : IJwtGenerationCommandHandler
    {
        private readonly IConfiguration configuration;
        private readonly JwtSecurityTokenHandler tokenHandler;

        public JwtGenerationCommandHandler(IConfiguration configuration, JwtSecurityTokenHandler tokenHandler)
        {
            this.configuration = configuration;
            this.tokenHandler = tokenHandler;
        }

        public string GenerateToken(JwtGenerationCommand command)
        {
            var issuer = configuration["Jwt:Issuer"];
            var audience = configuration["Jwt:Audience"];
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Key"]));
            var descriptor = new SecurityTokenDescriptor()
            {
                Issuer = issuer,
                Audience = audience,
                Expires = DateTime.Now.AddDays(1),
                SigningCredentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256Signature),
                Claims = ObterClaims(command)
            };

            var token = this.tokenHandler.CreateToken(descriptor);

            return tokenHandler.WriteToken(token);
        }

        protected IDictionary<string, object> ObterClaims(JwtGenerationCommand model)
        {
            var claims = new Dictionary<string, object>();

            claims.Add("UserId", model.Id);
            claims.Add("Nome", model.Nome);
            claims.Add("Email", model.Email);

            return claims;
        }
    }
}
