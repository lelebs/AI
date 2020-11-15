using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Threading.Tasks;
using AIBackend.Dominio.Interfaces;
using AIBackend.Handler;
using AIBackend.Repositorio;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace AIBackend
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddScoped<PesquisarFilmeCommandHandler>();
            services.AddScoped<PesquisarLivroCommandHandler>();
            services.AddScoped<IPesquisarFactoryHandler, PesquisarFactoryHandler>();
            services.AddScoped(typeof(ConnectionHandler));
            services.AddScoped<ILoginRepository, LoginRepository>() ;
            services.AddScoped(typeof(JwtSecurityTokenHandler));
            services.AddScoped<IJwtGenerationCommandHandler, JwtGenerationCommandHandler>();
            services.AddRouting();
            services.AddControllers();

            services.AddCors(option =>
            {
                option.AddDefaultPolicy(options =>
                {
                    options.AllowAnyOrigin()
                        .AllowAnyMethod()
                        .AllowAnyOrigin()
                        .Build();
                });
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();
            app.UseCors(builder =>
            {
                builder
                .AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader();
            });
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
