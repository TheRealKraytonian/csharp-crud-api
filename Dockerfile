FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

#Copy csproj and restore as distinct layrs
COPy *.csproj ./

RUN dotnet restore

COPY . ./

RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS runtime

WORKDIR /app

COPY --from=build /app/out ./

ENTRYPOINT ["dotnet", "csharp-crud-api.dll"]