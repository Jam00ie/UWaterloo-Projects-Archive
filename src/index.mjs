import express from "express"; //importing a module
import bodyParser from "body-parser";
import cors from "cors";
import data from "./data.js";
const app = express();
const { PORT = 3000 } = process.env;

app.use(bodyParser.json()).use(cors())

app.get("/", (request, response) => response.send("Hello World!"));

app.listen(PORT, () =>
    console.log(`Hello World, I'm listening http://localhost:${PORT}`)
);