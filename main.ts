import {serve} from "./deps.ts";

function handler(req: Request): Response {
    return new Response(
        `Hello, ${req.headers.get("user-agent")} :)`,
        {"status": 200}
    );
}

const port = parseInt(Deno.env.get("PORT") || "8080", 10);
await serve(handler, {port: port});
