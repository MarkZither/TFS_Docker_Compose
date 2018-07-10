ARG version=ltsc2016
FROM microsoft/windowsservercore:$version

LABEL maintainer "Mark Burton"

# Download Links:
ENV tfs_express_download_url "https://go.microsoft.com/fwlink/?LinkId=870792"

ENV chocolateyUseWindowsCompression false

RUN powershell -Command Install-WindowsFeature –Name Remote-Desktop-Services

RUN powershell -Command \
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest -Uri $env:tfs_express_download_url -OutFile tfsexpress.exe ; \
    #Start-Process -Wait -FilePath .\tfsexpress.exe -ArgumentList /Q /AdminFile c:\adsads /NoRestart /L ;