using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ComprasT1
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                // Recupera la cookie "nombreUsuario" y completa el textbox asi no me equivoco
                HttpCookie cookie = Request.Cookies["nombreUsuario"];
                if (cookie != null)
                {
                    NameUserLogin.Text = cookie.Value;
                }
            }

            
        }

        protected void ButtonLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

                //recupero el cookie value para comparar con el textbox
                HttpCookie cookie = Request.Cookies["nombreUsuario"];
                if(cookie.Value == NameUserLogin.Text)
                 { 
                    // Recuperar el tipo de usuario de la Session
                    string tipoUsuario = (string)Session["tipoDeUsuario"];


                    if (!string.IsNullOrEmpty(tipoUsuario))
                    {
                        // Redirigir según el Tipo Usuario
                        if (tipoUsuario == "Comprador")
                        {
                            Response.Redirect("FComprador.aspx");
                        }
                        else if (tipoUsuario == "Vendedor")
                        {
                            Response.Redirect("FVendedor.aspx");
                        }
                    }
                    else
                    {
                        // Si no hay session, avisa;
                        EstadoLogin.Text = $"No tiene session de usuario, ir a registro";
                    }
                }
                else
                {
                    EstadoLogin.Text = $"No está registrado o usuario incorrecto";
                }
            }
        }
    }
}