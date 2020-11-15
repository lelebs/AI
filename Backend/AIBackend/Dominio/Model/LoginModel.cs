namespace AIBackend.Dominio.Model
{
    public class LoginModel
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public string Email { get; set; }

        public static explicit operator JwtGenerationCommand(LoginModel origem)
        {
            return new JwtGenerationCommand()
            {
                Email = origem.Email,
                Id = origem.Id,
                Nome = origem.Nome
            };
        }
    }
}
