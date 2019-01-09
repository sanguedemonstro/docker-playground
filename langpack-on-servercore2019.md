_Aparently_ for Server Core 2019 you have to take base image and apply the desired language pack by yourself.
- [Release Notes - Important issues in Windows Server 2019](https://docs.microsoft.com/pt-br/windows-server/get-started-19/rel-notes-19)

And, here you can see some tips about how to do it:
- [Cannot configure a language pack for Windows Server 2019 Desktop Experience](https://support.microsoft.com/en-us/help/4466511/cannot-configure-language-pack-for-windows-server-2019)

# Trying to install (and fail) language pack using dockerfile
1. Read [Suport Link](https://support.microsoft.com/en-us/help/4466511/cannot-configure-language-pack-for-windows-server-2019) to understand the suggested approach to install languages over server core 2019
2. Manually download ISO that contains the language packs [here](https://software-download.microsoft.com/download/pr/17763.1.180914-1434.rs5_release_SERVERLANGPACKDVD_OEM_MULTI.iso)
3. Manually mount the ISO image, in my case to: `D:\x64\langpacks`
4. Manually move pt-BR langpack `D:/x64/langpacks/Microsoft-Windows-Server-Language-Pack_x64_pt-br.cab` to current dockerfile dir
5. Create volume dir at host machine, in my case: `c:\shared_at_host`
6. We are good to go, take a look at `dockerfile`:
```
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019
COPY Microsoft-Windows-Server-Language-Pack_x64_pt-br.cab C:/temp/
RUN powershell -NoProfile -Command \
  lpksetup.exe /i pt-BR /f /a /s /p C:\temp
RUN mkdir C:\shared_at_container
```
7. Build it: 
```
docker build -t wes-cloud2019 .
```
8. Run container: 
```
docker run --name wes-cloud2019 -d -v c:\shared_at_host:C:\shared_at_container -p 4000:80 wes-cloud2019
```
9. Enter container using powershell:
```
docker exec -i wes-cloud2019 powershell
```
10. Export event viewer
```
wevtutil epl System C:\shared_at_container\System.evtx /ow
wevtutil epl Application C:\shared_at_container\Application.evtx /ow
```
11. Go back to your host, open host dir `c:\shared_at_host`, evtx and search for errors or anything suspicious

## Conclusion
At this point, we can see intuitive steps to fix doesn't work. And nothing clear was found.. Maybe steps above could help MS to make it easier, or fix something..

# What else can we do here?
Once I'm inside container, let's play and learn some tricks, take a look..

## Run lpksetup.exe inside container
1. `lpksetup.exe /i pt-BR /f /a /s /p C:\temp`
2. Export evtx again and take a look, maybe something new appears

## How to list language pack
`Get-WmiObject -Class Win32_OperatingSystem).MUILanguages`


# Trying to set Internation Settings (and fail)
Following MS docs about [How To Configure Internation Settings](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/configure-international-settings-in-windows), the way to do it is using the [International Windows PowerShell Cmdlets](https://docs.microsoft.com/pt-br/powershell/module/internationalcmdlets/?view=winserver2012-ps).
```
Set-WinUserLanguageList pt-BR -Force
Set-WinUILanguageOverride pt-BR
Set-WinSystemLocale pt-BR
Set-Culture pt-BR
Set-WinHomeLocation -GeoId 32
```
Well, it doesn't work in my case, specially because I'm forcing `pt-BR`, but as far as I can see, pt-BR lang pack fails.. right?!

One thing annoying is the lack of feedback when running powershell inside container, there is no output, **I'm missing something??**

Let's try to read those settings:
```
Get-WinUserLanguageList
Get-WinUILanguageOverride
Get-WinSystemLocale
Get-Culture
Get-WinHomeLocation
```
WOW, some settings changed, another settings still same. The most important setting, in my case, is `WinSystemLocale`.
___
# Why am I playing around this subject?
Our IIS Application make a call to an legacy Win32 .exe process, that Win32 .exe deal with scripts, but scripts are being truncated on Server Core 2019, only when scripts have pt-BR chars like â, ã, é, ç,...
