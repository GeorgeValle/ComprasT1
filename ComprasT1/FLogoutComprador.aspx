<%@ Page Title="" Language="C#" MasterPageFile="~/Perfil_Comprador.Master" AutoEventWireup="true" CodeBehind="FLogoutComprador.aspx.cs" Inherits="ComprasT1.FLogoutComprador" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Logout Comprador</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container mt-5">
        <div class="card text-center" style="width: 50rem; margin: auto;">
            <div class="card-body">
                <h5 class="card-title">Despedida</h5>
                <asp:UpdatePanel ID="UpdatePanelTimer" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <p class="card-text">
                            <asp:Label ID="lblMensajeDespedida" runat="server"></asp:Label>
                        </p>
                        <p>Redirigiendo en: <asp:Label ID="lblCuentaRegresiva" runat="server" Text="5"></asp:Label> segundos...</p>
                        <asp:Timer ID="TimerLogout" runat="server" Interval="1000" OnTick="TimerLogout_Tick"></asp:Timer>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
