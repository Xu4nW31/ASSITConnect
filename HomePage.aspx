<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="SITConnect.HomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <strong>HomePage<br />
            <br />
            <asp:Label ID="lbl_message" runat="server" Text=" "></asp:Label>
            <br />
            <asp:Label ID="lbl_email" runat="server" Text=" "></asp:Label>
            <br />
            <asp:Button ID="btn_logout" runat="server" OnClick="btn_logout_Click" Text="Log Out" />
            </strong>
        </div>
        <p>
            <strong>
            <asp:Button ID="btn_changepwd" runat="server" OnClick="btn_changepwd_Click" Text="Change Password" Width="231px" />
            </strong>
        </p>
    </form>
</body>
</html>
