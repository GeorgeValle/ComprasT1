using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ComprasT1
{
    [Serializable]
    public class CarritoItem
    {
        public int Id { get; set; }
        public string Descripcion { get; set; }
        public decimal Monto { get; set; }
        public int Cantidad { get; set; }
        public string NombreArchivo { get; set; }
    }
}