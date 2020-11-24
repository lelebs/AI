using System.Collections.Generic;

namespace AIBackend.Dominio
{
    public class LivroViewModel
    {
        public IList<string> Autores { get; set; } = new List<string>();
        public bool IsPdfAvailable { get; set; }
        public string Sinopse { get; set; } = string.Empty;
        public string Titulo { get; set; } = string.Empty;
        public string UrlThumbnail { get; set; }
    }
}
