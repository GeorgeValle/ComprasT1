using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;

namespace ComprasT1
{
    public partial class FVendedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnGuardar_Click(object sender, EventArgs e)
        {
            // Sector Validaciones Básicas
            if (string.IsNullOrWhiteSpace(Description.Text))
            {
                Response.Write("La descripción es obligatoria.");
                return;
            }
            if (string.IsNullOrWhiteSpace(Monto.Text) || !decimal.TryParse(Monto.Text, out decimal precio))
            {
                Response.Write("El monto debe ser un número decimal válido.");
                return;
            }
            if (!FileUploadImage.HasFile)
            {
                Response.Write("Debes seleccionar un archivo de imagen.");
                return;
            }


            // Verificar que el archivo sea una imagen (opcional, pero recomendado)
            string extension = Path.GetExtension(FileUploadImage.FileName).ToLower();
            if (extension != ".jpg" && extension != ".jpeg" )
            {
                Response.Write("Solo se permiten archivos de imagen (.jpg o jpeg ).");
                return;
            }

            // Subir el archivo a la carpeta ~/images/
            string folderPath = Server.MapPath("~/images/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath); // Crear la carpeta si no existe
            }

            string fileName = Path.GetFileName(FileUploadImage.FileName);
            string filePath = Path.Combine(folderPath, fileName);
            FileUploadImage.SaveAs(filePath);

            // Guardar en la base de datos
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ComprasT1Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Productos (descripcion, nombreArchivo, precio) VALUES (@descripcion, @nombreArchivo, @precio)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@descripcion", Description.Text.Trim());
                    cmd.Parameters.AddWithValue("@nombreArchivo", fileName); // Solo el nombre del archivo, no la ruta completa
                    cmd.Parameters.AddWithValue("@precio", precio);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Limpiar los campos y mostrar mensaje de éxito
            Description.Text = string.Empty;
            Monto.Text = string.Empty;
            Response.Write("Producto guardado exitosamente.");
            GridViewProducts1.DataBind();



        }

        protected void GridViewProducts1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Description.Text = GridViewProducts1.SelectedRow.Cells[2].Text;
            Monto.Text = GridViewProducts1.SelectedRow.Cells[3].Text;
        }

        protected void BtnEditar_Click(object sender, EventArgs e)
        {
            // Verificar que haya una fila seleccionada
            if (GridViewProducts1.SelectedIndex == -1)
            {
                Response.Write("Selecciona un producto para modificar.");
                return;
            }
            // Validaciones básicas
            if (string.IsNullOrWhiteSpace(Description.Text))
            {
                Response.Write("La descripción es obligatoria.");
                return;
            }
            if (string.IsNullOrWhiteSpace(Monto.Text) || !decimal.TryParse(Monto.Text, out decimal precio))
            {
                Response.Write("El monto debe ser un número decimal válido.");
                return;
            }

            // Obtener el ID de la fila seleccionada
            int idProducto = Convert.ToInt32(GridViewProducts1.SelectedDataKey.Value);


            // obtengo el nombre de la columna nombre de archivo
            string fileName = GridViewProducts1.SelectedRow.Cells[4].Text; ;

            //verifico si tiene algo el uploader
            if (FileUploadImage.HasFile)
            {
                fileName = Path.GetFileName(FileUploadImage.FileName);
                FileUploadImage.SaveAs(Server.MapPath("~/images/" + fileName));
            }

            // Actualizar en la base de datos
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ComprasT1Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Productos SET descripcion = @descripcion, precio = @precio, nombreArchivo = @nombreArchivo  WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@descripcion", Description.Text.Trim());
                    cmd.Parameters.AddWithValue("@precio", precio);
                    cmd.Parameters.AddWithValue("@nombreArchivo", fileName);
                    cmd.Parameters.AddWithValue("@id", idProducto);
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Response.Write("Producto modificado exitosamente.");
                    }
                    else
                    {
                        Response.Write("Error al modificar el producto.");
                    }
                }
            }

            // Refrescar el GridView y limpiar TextBox
            GridViewProducts1.DataBind();
            Description.Text = string.Empty;
            Monto.Text = string.Empty;
            // Deseleccionar la fila
            GridViewProducts1.SelectedIndex = -1;  


        }

        protected void BtnEliminar_Click(object sender, EventArgs e)
        {
            // Verifica si hay una fila seleccionada
            if (GridViewProducts1.SelectedIndex == -1)
            {
                Response.Write("Selecciona un producto para eliminar.");
                return;
            }
            // Obtiene el ID y el nombre del archivo de la fila seleccionada
            int idProducto = Convert.ToInt32(GridViewProducts1.SelectedDataKey.Value);
            string nombreArchivo = GridViewProducts1.SelectedRow.Cells[4].Text;

            // Elimina el archivo de la carpeta images del servidor 
            if (!string.IsNullOrEmpty(nombreArchivo))
            {
                string filePath = Server.MapPath("~/images/" + nombreArchivo);
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }
            }

            // Elimina de la base de datos
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ComprasT1Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Productos WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", idProducto);
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Response.Write("Producto eliminado exitosamente.");
                    }
                    else
                    {
                        Response.Write("Error al eliminar el producto.");
                    }
                }
            }

            // Refresca el GridView y limpia TextBoxs
            GridViewProducts1.DataBind();
            Description.Text = string.Empty;
            Monto.Text = string.Empty;
            // Deseleccionar la fila
            GridViewProducts1.SelectedIndex = -1;  


        }
    }
}