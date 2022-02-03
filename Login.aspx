<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SITConnect.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
    <script src="https://www.google.com/recaptcha/api.js?render=6Le5juIdAAAAALLDNCmp1FlmUhpmTmuQP-JXfxP8"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <strong>Login<br />
            </strong>
            <table class="auto-style1">
                <tr>
                    <td>
                        <asp:Label ID="lbl_email" runat="server" Text="Email"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_email" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_password" runat="server" Text="Password"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_password" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Login" Width="168px" />
                    &nbsp;&nbsp;
                        <asp:Button ID="btn_register" runat="server" OnClick="Button1_Click" Text="Register" Width="162px" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Label ID="lbl_error" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
            </table>
            <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
        </div>
    </form>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6Le5juIdAAAAALLDNCmp1FlmUhpmTmuQP-JXfxP8', { action: 'Login' }).then(function (token) {
            document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
