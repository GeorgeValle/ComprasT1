<%@ Page Title="" Language="C#" MasterPageFile="~/Perfil_Vendedor.Master" AutoEventWireup="true" CodeBehind="FVendedor.aspx.cs" Inherits="ComprasT1.FVendedor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>
        Vendedor
    </title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="display-6 ps-5">Perfil Vendedor</h1>
    <div class="card ms-4 text-center" style="width: 35rem;" >
        <h5 class="card-title ms-4 mt-2">Producto</h5>
        <div class="input-group mb-2 p-2">
            <asp:Label ID="LabelDescription" class="input-group-text" runat="server" Text="Descripción:"></asp:Label>
            <asp:TextBox ID="Description" class="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="input-group mb-2 p-2">
            <asp:Label ID="LabelMonto" class="input-group-text" runat="server" Text="Monto:"></asp:Label>
            <asp:TextBox ID="Monto" class="form-control" runat="server"></asp:TextBox>
        </div>
        <div class="input-group mx-auto mb-2 p-2">
            <asp:Label ID="LabelSubirImagen" runat="server" class="input-group-text" Text="Subir Imagen:"></asp:Label>
            <asp:FileUpload ID="FileUploadImage"  class="form-control" runat="server" />
        </div>
        <div>
            <asp:Button ID="BtnGuardar" CssClass="btn btn-primary  ms-2 mb-2" runat="server" Text="Guardar" OnClick="BtnGuardar_Click" />
            <asp:Button ID="BtnEditar" CssClass="btn btn-warning ms-2 mb-2" runat="server" Text="Editar" OnClick="BtnEditar_Click" />
            <asp:Button ID="BtnEliminar" runat="server" CssClass="btn btn-danger mb-2 ms-2" Text="Eliminar" OnClick="BtnEliminar_Click" />
        </div>
    </div>

    <h2 class="display-7 mt-4 mb-3 ps-5">Listado de Productos</h2>

    <asp:GridView ID="GridViewProducts1" DataKeyNames="id" CssClass="table table-striped ms-2" style="width: 50rem;"  runat="server"  AutoGenerateColumns="False" DataSourceID="SqlDataSourceProducts" OnSelectedIndexChanged="GridViewProducts1_SelectedIndexChanged">
        <Columns>

            <asp:CommandField ShowSelectButton="True" SelectText="Seleccionar" HeaderText="Seleccionar" />
            
             <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" SortExpression="id" />

            <asp:BoundField DataField="descripcion" HeaderText="Descripción" SortExpression="descripcion" />

            <asp:BoundField DataField="precio" HeaderText="Monto" SortExpression="precio"  />

            <asp:BoundField DataField="nombreArchivo" HeaderText="Nombre de Archivo" SortExpression="nombreArchivo" />

            <asp:TemplateField HeaderText="Imagen">
                <ItemTemplate>
                    <asp:Image ID="imgProducto" runat="server" 
                        ImageUrl='<%# "~/images/" + Eval("nombreArchivo") %>' 
                        Width="70px" Height="70px" 
                        AlternateText="Imagen no disponible" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceProducts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ComprasT1Connection %>" 
        SelectCommand="SELECT id, descripcion, precio, nombreArchivo FROM Productos">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1"  runat="server"  ConnectionString="<%$ ConnectionStrings:ComprasT1Connection %>" SelectCommand="SELECT [id], [descripcion], [nombreArchivo], [precio] FROM [Productos]"></asp:SqlDataSource>
</asp:Content>
