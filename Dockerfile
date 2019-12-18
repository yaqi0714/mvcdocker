FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk AS build
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
