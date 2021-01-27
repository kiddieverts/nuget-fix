FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

COPY dktest.csproj .
# Make sure you copy the Nuget.Config file or else this will not work
COPY ./NuGet.Config .
# Make sure you copy the solution file or else this will not work
COPY ./dktest.sln . 

RUN dotnet restore

COPY . .

RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/runtime:5.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["./dotnetapp"]
