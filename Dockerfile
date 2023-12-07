#########################################################
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS final

ARG GITHASH

# Store git commit hash
RUN echo $GITHASH > githash.txt

WORKDIR /app
COPY ./app .
COPY ./app githash.txt

# Start Service
EXPOSE 5000
CMD ["dotnet", "api1-svc.Api.dll"]

