import express from "express"; //importing a module
const app = express(); //creating an express app
import bodyParser from "body-parser";
import cors from "cors";
import data from "./data.js";

app.get("/", (request, response) => response.send("Hello World!"));