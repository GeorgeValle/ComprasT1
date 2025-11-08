using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComprasT1
{
    public partial class FLogoutVendedor : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Obtener el nombre de la cookie y mostrar mensaje
                HttpCookie cookieNombre = Request.Cookies["nombreUsuario"];
                string nombre = cookieNombre != null ? cookieNombre.Value : "Usuario";
                lblMensajeDespedida.Text = "Hasta Luego " + nombre;
                // Inicializar contador en ViewState
                ViewState["Contador"] = 5;
                lblCuentaRegresiva.Text = "5";
            }
            else
            {
                // Restaurar contador desde ViewState en PostBacks
                if (ViewState["Contador"] != null)
                {
                    lblCuentaRegresiva.Text = ViewState["Contador"].ToString();
                }
            }
        }

        protected void TimerLogout_Tick(object sender, EventArgs e)
        {
            // Obtener contador desde ViewState
            int contador = Convert.ToInt32(ViewState["Contador"]);
            contador--;
            ViewState["Contador"] = contador;  // Guardar el nuevo valor
            lblCuentaRegresiva.Text = contador.ToString();
            if (contador <= 0)
            {
                // Detener el timer
                TimerLogout.Enabled = false;
                // Borrar cookie "nombreUsuario"
                HttpCookie cookie = Request.Cookies["nombreUsuario"];
                if (cookie != null)
                {
                    cookie.Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies.Add(cookie);
                }
                // Borrar sesiones
                Session.Remove("tipoDeUsuario");
                Session.Remove("Carrito");
                // Redirigir a Registro.aspx
                Response.Redirect("Login.aspx");
            }
            // Forzar actualización del UpdatePanel
            UpdatePanelTimer.Update();
        }
    }
}