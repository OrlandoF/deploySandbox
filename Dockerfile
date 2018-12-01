FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY deploySandbox/*.csproj ./deploySandbox/
RUN dotnet restore

# copy everything else and build app
COPY . .
WORKDIR /app/deploySandbox
RUN dotnet build

FROM build AS publish
WORKDIR /app/deploySandbox
RUN dotnet publish -c Release -o out


FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=publish /app/deploySandbox/out ./
ENTRYPOINT ["dotnet", "deploySandbox.dll"]