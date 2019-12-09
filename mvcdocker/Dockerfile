FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY ["mvcdocker/mvcdocker.csproj", "mvcdocker/"]
RUN dotnet restore "mvcdocker/mvcdocker.csproj"
COPY . .
WORKDIR "/src/mvcdocker"
RUN dotnet build "mvcdocker.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "mvcdocker.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "mvcdocker.dll"]