FROM mcr.microsoft.com/dotnet/sdk:7.0 as build-env
WORKDIR /src
COPY src/*.csproj .
RUN dotnet restore
COPY src .
# RUN dotnet build -c Release
# publish command do build and release
RUN dotnet publish -c Release -o /publish
# final image without source
FROM mcr.microsoft.com/dotnet/aspnet:7.0 as runtime
WORKDIR /app
COPY --from=build-env /publish .
EXPOSE 80
ENTRYPOINT [ "dotnet","myWebApp.dll" ]