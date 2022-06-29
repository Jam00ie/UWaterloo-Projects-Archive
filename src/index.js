import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import data from "./data.js";
import * as utilities from "./functions.js";
import {isInvalidId} from "./functions.js";
const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json()).use(cors());

app.get("/", (request, response) => response.send("/professors | /professor/:id | /courses | /course/:id"));

app.get("/professors", (req, res) => {
    res.json(data.professors);
}
);

app.get("/professor/:id", (req, res) => {
    if (utilities.isInvalidId(req.params.id)) {
        return res.status(400).json({ error: "Invalid id." })
    }
    const id = parseInt(req.params.id);
    const professor = data.professors.find((prof) => prof.id === id);
    if (!professor) {
        res.status(404).json({error: "Professor not found."});
    }
    return res.json(professor);
}
);

app.get("/courses", (req, res) => {
    res.json(data.courses);
}
);

app.get("/course/:id", (req, res) => {
    if (utilities.isInvalidId(req.params.id)) {
        return res.status(400).json({ error: "Invalid id." })
    }
    const id = parseInt(req.params.id);
    const course = data.courses.find((cour) => cour.id === id);
    if (!course) {
        res.status(404).json({error: "Course not found."});
    }
    return res.json(course);
}
);

app.listen(PORT, () => console.log(`Listening on http://localhost:${PORT}`));
