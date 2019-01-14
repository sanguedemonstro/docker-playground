<%@ Page Language="c#" AutoEventWireup="false" EnableTheming="false" Theme="" StylesheetTheme="" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>hello!</title>
</head>
<body>
    <h1><%= "Hello from: "+ System.Environment.MachineName%></h1><br />
    <%= "OS Version: "+System.Environment.OSVersion.VersionString%><br /><br />
    <%= "UserName: "+System.Environment.UserName %><br />
    <%= "CurrentCulture: "+System.Globalization.CultureInfo.CurrentCulture.Name %><br />
    <%= "CurrentCulture.OEMCodePage: "+System.Globalization.CultureInfo.CurrentCulture.TextInfo.OEMCodePage %><br />
    <%= "CurrentUICulture: "+System.Globalization.CultureInfo.CurrentUICulture.Name %><br />
    <%= "CurrentUICulture.OEMCodePage: "+System.Globalization.CultureInfo.CurrentUICulture.TextInfo.OEMCodePage %><br />
    <%= "InstalledUICulture: "+System.Globalization.CultureInfo.InstalledUICulture.Name %><br />
    <%= "InstalledUICulture.OEMCodePage: "+System.Globalization.CultureInfo.InstalledUICulture.TextInfo.OEMCodePage %><br />
    <%= "InvariantCulture: "+System.Globalization.CultureInfo.InvariantCulture.EnglishName %><br />
    <%= "InvariantCulture.OEMCodePage: "+System.Globalization.CultureInfo.InvariantCulture.TextInfo.OEMCodePage %><br />
</body>
</html>
<% 
    HttpContext.Current.Response.AppendHeader("Pragma", "no-cache");
    HttpContext.Current.Response.Expires = 0;
    HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    HttpContext.Current.Response.Cache.SetExpires(DateTime.Now.AddSeconds(-60));
    HttpContext.Current.Response.Cache.SetNoStore();
    HttpContext.Current.Response.Cache.SetValidUntilExpires(false);
%>