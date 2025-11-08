using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComprasT1
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)  // me aseguro que solo me cargue una vez
            {
                //  agregar las dos opciones
                DropDownListTypeUser.Items.Add(new ListItem("Vendedor", "vendedor"));
                DropDownListTypeUser.Items.Add(new ListItem("Comprador", "comprador"));

                //selecciona por default
                DropDownListTypeUser.SelectedValue = "comprador";
            }
        }

        protected void ButtonRegistro_Click(object sender, EventArgs e)
        {
            // Verifica que pasan todas las validaciones
            if (Page.IsValid) 
            {
                
                string nombreUsuario = NameUserRegistro.Text.Trim();
                string email = EmailUser.Text.Trim();
                // Texto seleccionado
                string tipoUsuario = DropDownListTypeUser.SelectedItem.Text; 
                // Guardar en Session
                Session["tipoDeUsuario"] = tipoUsuario;
                // Crea Cookie para nombreUsuario con duración de 3 días
                HttpCookie cookieNombre = new HttpCookie("nombreUsuario");
                cookieNombre.Value = nombreUsuario;
                cookieNombre.Expires = DateTime.Now.AddDays(3);
                Response.Cookies.Add(cookieNombre);
                // Redirige al login o mostrar mensaje de éxito
                Response.Redirect("Login.aspx");
            }
        }
    }
}