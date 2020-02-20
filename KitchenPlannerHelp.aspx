<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KitchenPlannerHelp.aspx.cs" Inherits="KitchenPlannerHelp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr style="height:5px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="lblHelp" runat="server" Font-Names="Calibri" Font-Size="20px" Text="Kitchen Planner" Font-Underline="true" ForeColor="Gray"></asp:Label>
                    </td>
                </tr>
                <tr style="height:5px"><td></td></tr>                
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Font-Names="Calibri" Font-Size="14px" Text="The Kitchen Planner helps in proper advance planning at the Kitchen. " ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Save money.  Avoid wastage. Ensure the residents have always a good word for the food served.  Avoid frequent repetitions of the same menu. Have better inventory control and avoid last minute purchases at higher costs. " ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Font-Names="Calibri" Font-Size="14px" Text="The Kitchen Planner is beneficial to all – the Management, The Kitchen Chefs, The Store Keepers and above all the residents." ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
                <tr style="height:5px"><td></td></tr>                
                 <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Font-Bold="true" Text="Menu Item Master"  ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="Here you define the names of the food items that are served in the daily Menu, for the residents. It is very important to define a menu item first before it can be added in a daily menu."  ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Benefits of Kitchen Planner:  Helps in advance planning. Saves Cost. Reduces wastage. Frequent repetitions avoided. Better inventory control and therefore no last minute purchases at higher cost. Improved service levels." ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
                <tr style="height:5px"><td></td></tr>                
                 <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Font-Bold="true" Text="Standard Menu"  ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="To avoid worrying about what to cook for tomorrow, one can set a standard menu for each day of the week. Here you add a menu item and define which days of the week you are planning to serve it.  Example:  Idlies only on Monday, Wednesday and Friday for breakfast."  ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Font-Names="Calibri" Font-Size="14px" Text="If a Menu Item is special and reserved only for a special day (Ex: Diwali day breakfast) it can be defined so." ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Font-Names="Calibri" Font-Size="14px" Text="The average quantity per menu item per person, when set here,  lets one estimate the total quantity to be prepared later. " ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
                 <tr style="height:5px"><td></td></tr>                
                 <tr>
                    <td>
                        <asp:Label ID="Label11" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Font-Bold="true" Text="Day planner"  ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label12" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="The planner for a day lets you mention how many persons are estimated to dine on a day. If it is a special day (Ex: Diwali or Independence day) mention this as well. The Menu for the day can be set up only after doing the initial planning.  By estimating how many people may arrive for breakfast, the quantity of each item to be cooked can be estimated."  ></asp:Label>
                    </td>
                </tr>
                <tr style="height:5px"><td></td></tr>     
                <tr>
                    <td>
                        <asp:Label ID="Label13" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="Every Monday comes and goes. But some Mondays may be special. May be it is a resident’s birthday or may be it is Diwali day. Naturally apart from the regular menu, one may like to add some special item for the special day."  ></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label14" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="You can also set a message for the special day so that everyone knows about it.  (Displayed as a scroll message in the Sign In Screen). If one or more residents are celebrating their birthday on the day, the day planner knows about it and prompts you. "  ></asp:Label>
                    </td>
                </tr>
                <tr style="height:5px"><td></td></tr>                
                 <tr>
                    <td>
                        <asp:Label ID="Label15" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Font-Bold="true" Text="Daily Menu"  ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label16" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="Here one sets the  Menu for different sessions on a particular day and which is to be used by the Kitchen."  ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label17" runat="server" Font-Names="Calibri" Font-Size="14px" Text="The Daily Menu is prepared by referring to the Standard Menu for the day and the Day Planner. " ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label18" runat="server" Font-Names="Calibri" Font-Size="14px" Text="One can remove a Menu Item suggested from the Standard Menu." ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label19" runat="server" Font-Names="Calibri" Font-Size="14px" Text="This Menu can be prepared upto three days in advance." ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label20" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Also shown is the estimated quantity to be prepared, as a guideline for the kitchen." ForeColor="Black" ></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
