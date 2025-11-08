using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComprasT1
{
    public partial class Comprador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Inicializar el carrito si no existe
                if (Session["Carrito"] == null)
                {
                    Session["Carrito"] = new List<CarritoItem>();
                }
                // Cargar el carrito en el GridView
                CargarCarrito();
            }
        }

        protected void GridViewProducts1_SelectedIndexChanged(object sender, EventArgs e)
        {
            divDetalles.Visible = true;
            // Cargar datos de la fila seleccionada
            lblDescripcion.Text = GridViewProducts1.SelectedRow.Cells[2].Text;  // Descripción
            lblMonto.Text = GridViewProducts1.SelectedRow.Cells[3].Text;        // Monto
            string nombreArchivo = GridViewProducts1.SelectedRow.Cells[4].Text; // NombreArchivo (de la celda de imagen)
            imgDetalle.ImageUrl = "~/images/" + nombreArchivo;
        }

        protected void BtnAgregar_Click(object sender, EventArgs e)
        {
            if (GridViewProducts1.SelectedIndex == -1)
            {
                // Mostrar error (puedes usar un Label en lugar de Response.Write)
                return;
            }
            // Validar cantidad
            if (!int.TryParse(txtCantidad.Text, out int cantidad) || cantidad < 1 || cantidad > 99)
            {
                // Mostrar error
                return;
            }

            // Obtener datos del producto seleccionado
            int id = Convert.ToInt32(GridViewProducts1.SelectedDataKey.Value);
            string descripcion = lblDescripcion.Text;
            decimal monto = decimal.Parse(GridViewProducts1.SelectedRow.Cells[3].Text);  // Limpiar formato de moneda
            string nombreArchivo = GridViewProducts1.SelectedRow.Cells[4].Text;
            // Crear item del carrito
            CarritoItem item = new CarritoItem
            {
                Id = id,
                Descripcion = descripcion,
                Monto = monto,
                Cantidad = cantidad,
                NombreArchivo = nombreArchivo
            };

            
            // Agregar a la sesión (lista)
            List<CarritoItem> carrito = (List<CarritoItem>)Session["Carrito"];
            carrito.Add(item);
            Session["Carrito"] = carrito;
            // Actualizar el GridView del carrito (dentro del UpdatePanel)
            CargarCarrito();
            UpdatePanelCarrito.Update();  // Forzar actualización del panel
        }

        protected void BtnBorrarCarrito_Click(object sender, EventArgs e)
        {
            Session["Carrito"] = new List<CarritoItem>();  // Limpiar la sesión
            CargarCarrito();
            UpdatePanelCarrito.Update();
        }

        private void CargarCarrito()
        {
            List<CarritoItem> carrito = (List<CarritoItem>)Session["Carrito"];
            GridViewCarrito.DataSource = carrito;
            GridViewCarrito.DataBind();
        }
    }
}