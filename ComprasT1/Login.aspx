<%@ Page Title="" Language="C#" MasterPageFile="~/Logueo_Registrar.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ComprasT1.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>
        Login
    </title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1 class="display-6 ps-5">Login</h1>
    
    <div class="card ms-4" style="width: 25rem;">
        <div class="input-group  p-2">
            <asp:Label ID="LabelNameUserLogin" for="labelName" class="input-group-text" runat="server" Text="Nombre de Usuario:"></asp:Label>
            <asp:TextBox ID="NameUserLogin" class="form-control" for="labelName" runat="server"></asp:TextBox>
            <!-- Validación para el Nombre de Usuario  -->
            <asp:RequiredFieldValidator ID="rfvNombreUsuario" ValidationGroup="vgForm" runat="server" 
                ControlToValidate="NameUserLogin" 
                ErrorMessage="No completó el campo Nombre de Usuario" 
                ForeColor="#CC3300" Display="None">
            </asp:RequiredFieldValidator>
        </div>
        <div class="ps-2 pb-2">
            <asp:Button class="btn btn-primary ps-1 mt-3" ID="ButtonLogin" ValidationGroup="vgForm" runat="server" Text="Login" OnClick="ButtonLogin_Click" />
        </div>
        <p>
            <asp:Label ID="EstadoLogin" CssClass="mb-1 ps-3 text-danger-emphasis" runat="server" Text=""></asp:Label>
            <!-- ValidationSummary para mostrar errores  -->
            <asp:ValidationSummary ID="vsErrores" class="mb-2 p-2" ValidationGroup="vgForm" runat="server" 
            ForeColor="#CC3300" HeaderText="Error:" />
            

            
        </p>
    </div>
    <div>
            
    </div>
</asp:Content>
