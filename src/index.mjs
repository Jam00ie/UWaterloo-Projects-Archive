import express from "express"; //importing a module
import bodyParser from "body-parser";
import cors from "cors";
import data from "./data.js";
const app = express();

let PORT = process.env.PORT;
if (PORT == null || PORT == "") {
  PORT = 3000;
}

app.use(bodyParser.json()).use(cors())

app.get("/", (request, response) => response.send("Hello World!"));

app.listen(PORT);