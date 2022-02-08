<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="SITConnect.ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
            function validate() {
            var str = document.getElementById('<%=tb_pwd.ClientID %>').value;
    
            if (str.length < 12) {
                document.getElementbyId("lbl_password").innerHTML = "Password Length Must be at Least 8 Characters";
                document.getElementbyId("lbl_password").style.color = "Red";
                return ("too_short");

            }

            else if (str.search(/[0-9]/) == - 1) {
                document.getElementById("lbl_password").innerHTML = "Password require at least 1 number";
                document.getElementById("lbl_password").style.color = "Red";
                return ("no_number");
            }

            else if (str.search(/[a-z]/) == - 1) {
                document.getElementById("lbl_password").innerHTML = "Password require at least 1 lowercase letter";
                document.getElementById("lbl_password").style.color = "Red";
                return ("no_lower");
            }

            else if (str.search(/[A-Z]/) == - 1) {
                document.getElementById("lbl_password").innerHTML = "Password require at least 1 uppercase letter";
                document.getElementById("lbl_password").style.color = "Red";
                return ("no_upper");
            }

            else if (str.search(/[^a-zA-Z0-9]/) == - 1) {
                document.getElementById("lbl_password").innerHTML = "Password require special character";
                document.getElementById("lbl_password").style.color = "Red";
                return ("no_specialchar");
            }
            

                document.getElementById("lbl_password").innerHTML = "Excellent!"
                document.getElementById("lbl_password").style.color = "Green";
        }
    </script>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td>
                        <asp:Label ID="lbl_pwd" runat="server" Text="New Password:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_pwd" runat="server" TextMode ="Password"></asp:TextBox>
                        <asp:Label ID="lbl_password" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_cfmpwd" runat="server" Text="Confirm Password: "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_cfmpwd" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Submit" Width="168px" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Label ID="lbl_error" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
