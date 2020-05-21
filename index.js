require("dotenv").config({ silent: process.env.NODE_ENV === "production" });
const path = require("path");
const express = require("express");
const cors = require("cors");

const port = process.env.PORT || 3000;
const api_router = express.Router();
const api = require("./api");
const app = express();

/* Middleware */
app.use(express.json());
app.use(cors());

/* API */
api_router.get("/", (req, res) => {
  res.sendStatus(200);
});
api_router.use("/tasks", api.tasks);
api_router.use("/mechanics", api.mechanics);
api_router.use("/machines", api.machines);
api_router.use((req, res) => {
  res.sendStatus(501);
});

/* Bind routes */
app.use("/api", api_router);
app.use(express.static(__dirname + "/src/dist"));
app.get("*", (req, res) => {
  res.sendFile(path.resolve(__dirname, "src/dist/index.html"));
});
console.log(__dirname);

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
