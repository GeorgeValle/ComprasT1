<%@ Page Title="" Language="C#" MasterPageFile="~/Perfil_Comprador.Master" AutoEventWireup="true" CodeBehind="FComprador.aspx.cs" Inherits="ComprasT1.Comprador" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Comprador</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="display-6 ps-5">Perfil Comprador</h1>
    
    
    <h2 class="mt-4 ps-5">Productos Disponibles</h2>
    <!-- SQL data source de Productos -->
    <asp:SqlDataSource ID="SqlDataSourceProducts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ComprasT1Connection %>" 
        SelectCommand="SELECT id, descripcion, precio, nombreArchivo FROM Productos">
    </asp:SqlDataSource>
    <!-- GridView de Productos -->
    <asp:GridView ID="GridViewProducts1" runat="server"  AutoGenerateColumns="False" DataSourceID="SqlDataSourceProducts" 
        CssClass="table table-striped ms-4" Width="80%" 
        OnSelectedIndexChanged="GridViewProducts1_SelectedIndexChanged" 
        DataKeyNames="id">
        <Columns>
            <asp:CommandField ShowSelectButton="True" SelectText="Seleccionar"  HeaderText="Seleccionar" />
            <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="descripcion" HeaderText="Descripción" SortExpression="descripcion" />
            <asp:BoundField DataField="precio" HeaderText="Monto" SortExpression="precio"   />
            <asp:BoundField DataField="nombreArchivo" HeaderText="Nombre de Archivo" SortExpression="nombreArchivo" />
            <asp:TemplateField HeaderText="Imagen">
                <ItemTemplate>
                    <asp:Image ID="imgProducto" runat="server" 
                        ImageUrl='<%# "~/images/" + Eval("nombreArchivo") %>' 
                        Width="80px" Height="80px" 
                        AlternateText="Imagen no disponible" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <!-- Card para detalles del producto seleccionado -->
    <div id="divDetalles" runat="server" class="card ms-4 mt-4" style="width: 30rem;" visible="false">
        <h5 class="card-title ms-4 mt-2">Detalles del Producto</h5>
        <div class="card-body">
            
            <p><strong>Descripción:</strong> <asp:Label ID="lblDescripcion" runat="server" ></asp:Label></p>
            <p><strong>Monto:</strong> <asp:Label ID="lblMonto" runat="server"></asp:Label></p>
            <p><strong>Imagen:</strong></p>
            <asp:Image ID="imgDetalle" runat="server" Width="80px" Height="80px" AlternateText="Imagen no disponible" />
            <br />
            <div class="input-group mt-2">
                <asp:Label ID="LabelCantidad" class="input-group-text " Text="Cantidad (1-99):" runat="server"> </asp:Label>
                <asp:TextBox ID="txtCantidad"  runat="server" Text="1" CssClass="form-control mt-2" TextMode="Number" Min="1" Max="99"></asp:TextBox>
            </div>
            <asp:Button ID="BtnAgregar" runat="server" Text="Agregar al Carrito" CssClass="btn btn-success mt-3" OnClick="BtnAgregar_Click" />
        </div>
    </div>

    <!-- Carrito de Compras con AJAX -->
    <asp:UpdatePanel ID="UpdatePanelCarrito" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <h2 class="mt-4 ps-5">Carrito de Compras</h2>
            <asp:GridView ID="GridViewCarrito" runat="server" AutoGenerateColumns="False" CssClass="table table-striped ms-4" Width="80%">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                    <asp:BoundField DataField="Monto" HeaderText="Monto"  />
                    <asp:TemplateField HeaderText="Imagen">
                        <ItemTemplate>
                            <asp:Image ID="imgCarrito" runat="server" 
                                ImageUrl='<%# "~/images/" + Eval("NombreArchivo") %>' 
                                Width="50px" Height="50px" 
                                AlternateText="Imagen no disponible" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                </Columns>
            </asp:GridView>
            <asp:Button ID="BtnBorrarCarrito" runat="server" Text="Borrar Carrito" CssClass="btn btn-danger mt-3 ms-4 mb-4" OnClick="BtnBorrarCarrito_Click" />
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="BtnAgregar" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="BtnBorrarCarrito" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>

</asp:Content>
