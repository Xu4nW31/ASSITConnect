<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="SITConnect.Registration"  ValidateRequest="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>

    <script type="text/javascript">
        function validate() {
            var str = document.getElementById('<%=tb_password.ClientID %>').value;

            if (str.length < 12) {
                document.getElementbyId("lbl_pwdchecker").innerHTML = "Password Length Must be at Least 8 Characters";
                document.getElementbyId("lbl_pwdchecker").style.color = "Red";
                return ("too_short");
       
            }

            else if (str.search(/[0-9]/) == - 1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 number";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_number");
            }

            else if (str.search(/[a-z]/) == - 1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 lowercase letter";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_lower");
            }

            else if (str.search(/[A-Z]/) == - 1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 uppercase letter";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_upper");
            }

            else if (str.search(/[^a-zA-Z0-9]/) == - 1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require special character";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_specialchar");
            }
            

            document.getElementById("lbl_pwdchecker").innerHTML = "Excellent!"
            document.getElementById("lbl_pwdchecker").style.color = "Green";
        }

        function validatefirstname() {
            var str = document.getElementById('<%=tb_firstname.ClientID %>').value;

            if (str.length == 0) {
                document.getElementbyId("lbl_firstnamechecker").innerHTML = "Field cannot be empty";
                document.getElementbyId("lbl_firstnamechecker").style.color = "Red";
            }

            document.getElementById("lbl_firstnamechecker").innerHTML = "Excellent!"
            document.getElementById("lbl_firstnamechecker").style.color = "Green";
        }

        function validatelastname() {
            var str = document.getElementById('<%=tb_lastname.ClientID %>').value;

            if (str.length == 0) {
                document.getElementbyId("lbl_lastnamechecker").innerHTML = "Field cannot be empty";
                document.getElementbyId("lbl_lastnamechecker").style.color = "Red";
            }

            document.getElementById("lbl_lastnamechecker").innerHTML = "Excellent!"
            document.getElementById("lbl_lastnamechecker").style.color = "Green";
        }

        function validatecreditcard() {
            var str = document.getElementById('<%=tb_creditcard.ClientID %>').value;

            if (str.length == 0) {
                document.getElementbyId("lbl_creditcardchecker").innerHTML = "Field cannot be empty";
                document.getElementbyId("lbl_creditcardchecker").style.color = "Red";
            }
            else if (str.length > 16) {
                document.getElementbyId("lbl_creditcardchecker").innerHTML = "Credit Card Number can only be 16 digits";
                document.getElementbyId("lbl_creditcardchecker").style.color = "Red";
            }

            document.getElementById("lbl_creditcardchecker").innerHTML = "Excellent!"
            document.getElementById("lbl_creditcardchecker").style.color = "Green";
        }

        function validatecardexpiry() {
            var str = document.getElementById('<%=tb_expirydate.ClientID %>').value;

            if (str.length == 0) {
                document.getElementbyId("lbl_cardexpirychecker").innerHTML = "Field cannot be empty";
                document.getElementbyId("lbl_cardexpirychecker").style.color = "Red";
            }

            document.getElementById("lbl_cardexpirychecker").innerHTML = "Excellent!"
            document.getElementById("lbl_cardexpirychecker").style.color = "Green";
        }

        function validatecvv() {
            var str = document.getElementById('<%=tb_creditcardcvv.ClientID %>').value;

            if (str.length == 0) {
                document.getElementbyId("lbl_cvvchecker").innerHTML = "Field cannot be empty";
                document.getElementbyId("lbl_cvvchecker").style.color = "Red";
            }

            if (str.length > 3) {
                document.getElementbyId("lbl_cvvchecker").innerHTML = "CVV cannot be more than 3 digits";
                document.getElementbyId("lbl_cvvchecker").style.color = "Red";
            }

            document.getElementById("lbl_cvvchecker").innerHTML = "Excellent!"
            document.getElementById("lbl_cvvchecker").style.color = "Green";
        }

        function validateemail() {
            var str = document.getElementById('<%=tb_email.ClientID %>').value;

            if (str.length == 0) {
                document.getElementbyId("lbl_emailchecker").innerHTML = "Field cannot be empty";
                document.getElementbyId("lbl_emailchecker").style.color = "Red";
            }

            document.getElementById("lbl_cvvchecker").innerHTML = "Excellent!"
            document.getElementById("lbl_cvvchecker").style.color = "Green";
        }

        function validatedob() {
            var str = document.getElementById('<%=tb_DOB.ClientID %>').value;

            if (str.length == 0) {
                document.getElementbyId("lbl_dobchecker").innerHTML = "Field cannot be empty";
                document.getElementbyId("lbl_dobchecker").style.color = "Red";
            }

            document.getElementById("lbl_dobchecker").innerHTML = "Excellent!"
            document.getElementById("lbl_dobchecker").style.color = "Green";
        }

    </script>
    
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            height: 26px;
        }
        .auto-style3 {
            height: 28px;
        }
        .auto-style4 {
            height: 29px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <strong>Registration</strong><br />
            <br />
            <table class="auto-style1">
                <tr>
                    <td class="auto-style3">
                        <asp:Label ID="lbl_firstname" runat="server" Text="First Name"></asp:Label>
                    </td>
                    <td class="auto-style3">
                        <asp:TextBox ID="tb_firstname" onkeyup="javascript:validatefirstname()" runat="server"></asp:TextBox>
                        <asp:Label ID="lbl_firstnamechecker" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_lastname" runat="server" Text="Last Name"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tb_lastname" onkeyup="javascript:validatelastname()" runat="server"></asp:TextBox>
                        <asp:Label ID="lbl_lastnamechecker" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_creditcardinfo" runat="server" Text="Credit Card Number"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_creditcard" onkeyup="javascript:validatecreditcard()" runat="server"></asp:TextBox>
                        <asp:Label ID="lbl_creditcardchecker" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_creditcardexpiry" runat="server" Text="Credit Card Expiry Date"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_expirydate" onkeyup="validatecardexpiry()" runat="server"></asp:TextBox>
                        <asp:Label ID="lbl_cardexpirychecker" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">
                        <asp:Label ID="lbl_creditcardinfo0" runat="server" Text="Credit Card CVV"></asp:Label>
                    </td>
                    <td class="auto-style4">
                        <asp:TextBox ID="tb_creditcardcvv" onkeyup="validatecvv()" runat="server"></asp:TextBox>
                        <asp:Label ID="lbl_cvvchecker" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_email" runat="server" Text="Email Address"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tb_email" onkeyup="validateemail()" runat="server" Width="160px"></asp:TextBox>
                        <asp:Label ID="lbl_emailchecker" runat="server" Text=" "></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_pwd" runat="server" Text="Password"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tb_password" runat="server" onkeyup="javascript:validate()" TextMode="Password"></asp:TextBox>
&nbsp;&nbsp;
                        <asp:Label ID="lbl_pwdchecker" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_DOB" runat="server" Text="Date of Birth"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tb_DOB" onkeyup="validatedob()" runat="server" TextMode="Date"></asp:TextBox>
                        <asp:Label ID="lbl_dobchecker" runat="server" Text=" "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_photo" runat="server" Text="Photo"></asp:Label>
                    </td>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Submit" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
