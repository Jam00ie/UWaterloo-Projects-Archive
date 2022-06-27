import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import data from "./data.js";
const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json()).use(cors());

app.get("/", (request, response) => response.send("Hello World!!"));

app.get("/professors", (req, res) => {
    res.json(data.professors);
}
);

app.listen(PORT, () => console.log(`Listening on http://localhost:${PORT}`));
