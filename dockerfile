FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019
WORKDIR /inetpub/wwwroot
COPY webapp ./webapp
RUN powershell -NoProfile -Command \
    Set-WinHomeLocation -GeoId 32;\
    Set-WinUserLanguageList pt-BR -Force;\
    Set-WinUILanguageOverride pt-BR;\
    Set-WinSystemLocale pt-BR;\
    Set-Culture pt-BR;\
    $userName='container.user'; \
    $userPass='@GoToCloud'; \
    net user $userName $userPass /ADD;\
    net localgroup administrators $userName /add;\
    Import-Module WebAdministration; \
    cd IIS:\AppPools\; \
    New-Item webapppool; \
    Set-ItemProperty webapppool managedRuntimeVersion -Value v4.0; \
    Set-ItemProperty webapppool -name processModel.identityType -Value SpecificUser; \
    Set-ItemProperty webapppool -name processModel.userName -Value $userName; \
    Set-ItemProperty webapppool -name processModel.password -Value $userPass; \
    New-WebSite -Name webapp -Port 80 -HostHeader * -PhysicalPath "C:\inetpub\wwwroot\webapp"; \
    cd IIS:\Sites\; \
    Remove-WebSite -Name 'Default Web Site'; \
    Set-ItemProperty webapp -Name "applicationPool" -Value webapppool