<%@ Page Title="" Language="C#" MasterPageFile="~/Logueo_Registrar.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="ComprasT1.Registro" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>
        Registro
    </title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="display-6 ps-5">Registro</h1>
    <div class="card ms-4" style="width: 25rem;">
        <div class="input-group mb-2 p-2">
            <!-- Label y Texbox de Nombre de Usuario  -->
            <asp:Label ID="LabelNameUserRegistro" for="labelName" class="input-group-text" runat="server" Text="Nombre de Usuario:"></asp:Label>
            <asp:TextBox ID="NameUserRegistro" class="form-control" for="labelName" runat="server"></asp:TextBox>
            <!-- Validación para el Nombre de Usuario  -->
            <asp:RequiredFieldValidator ID="rfvNombreUsuario" ValidationGroup="vgForm" runat="server" 
                ControlToValidate="NameUserRegistro" 
                ErrorMessage="No completó el campo Nombre de Usuario" 
                ForeColor="#CC3300" Display="None">
            </asp:RequiredFieldValidator>
         </div>
        <div class="input-group mb-2 p-2">
            <!-- Label y Texbox para el Email  -->
            <asp:Label ID="LabelEmail" class="input-group-text" runat="server" Text="Email:"></asp:Label> 
            <asp:TextBox ID="EmailUser" class="form-control"  runat="server"></asp:TextBox>
            <!-- Validadació para el Email  -->
            <asp:RequiredFieldValidator ID="rfvEmail" ValidationGroup="vgForm" runat="server" 
                ControlToValidate="EmailUser" 
                ErrorMessage="No completó el campo Email" 
                ForeColor="#CC3300" Display="None"></asp:RequiredFieldValidator>
            <!-- Validación para el formato de Email -->
            <asp:RegularExpressionValidator ID="revEmail" ValidationGroup="vgForm" runat="server" 
                ControlToValidate="EmailUser" 
                Display="None" 
                ErrorMessage="El valor ingresado no es un Email válido" 
                ForeColor="#CC3300" 
                ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"></asp:RegularExpressionValidator>
        </div>
        <div class="input-group mb-2 p-2">
            <asp:Label ID="LabelTypeUser" class="input-group-text" runat="server" Text="Tipo de Usuario:"></asp:Label>
            <asp:DropDownList ID="DropDownListTypeUser" class="form-select" runat="server"></asp:DropDownList>

        </div>

        <div class="ps-2 pb-2">
            <asp:Button ID="ButtonRegistro" class="btn btn-primary" ValidationGroup="vgForm" runat="server" Text="Registrar" OnClick="ButtonRegistro_Click" />
        </div>
        <!-- ValidationSummary para mostrar errores  -->
        <asp:ValidationSummary ID="vsErrores" class="mb-2 p-2" ValidationGroup="vgForm" runat="server" 
            ForeColor="#CC3300" HeaderText="Errores al completar:" />
    </div>
</asp:Content>
