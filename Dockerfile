#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Otus.Home.Docker.WebApplication/Otus.Home.Docker.WebApplication.csproj", "Otus.Home.Docker.WebApplication/"]
RUN dotnet restore "Otus.Home.Docker.WebApplication/Otus.Home.Docker.WebApplication.csproj"
COPY . .
WORKDIR "/src/Otus.Home.Docker.WebApplication"
RUN dotnet build "Otus.Home.Docker.WebApplication.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Otus.Home.Docker.WebApplication.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
CMD dotnet Otus.Home.Docker.WebApplication.dll