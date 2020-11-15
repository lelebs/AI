namespace AIBackend.Dominio.Interfaces
{
    public interface IJwtGenerationCommandHandler
    {
        string GenerateToken(JwtGenerationCommand command);
    }
}
