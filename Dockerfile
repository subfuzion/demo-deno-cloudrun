FROM denoland/deno:distroless-1.21.3

WORKDIR /app
COPY deps.ts .
RUN ["deno", "cache", "deps.ts"]
COPY . .
RUN ["deno", "cache", "main.ts"]

EXPOSE 8080
CMD ["run", "--allow-net", "--allow-env", "main.ts"]
