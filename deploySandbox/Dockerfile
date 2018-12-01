FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["deploySandbox/deploySandbox.csproj", "./deploySandbox/"]
RUN dotnet restore "deploySandbox/deploySandbox.csproj"
COPY . .
WORKDIR "/src/deploySandbox"
RUN dotnet build "deploySandbox.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "deploySandbox.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "deploySandbox.dll"]