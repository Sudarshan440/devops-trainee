require("./config/config"); // for local dev only

const express = require("express");
const path = require("path");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const cors = require("cors");
const db = require("./db");
const fs = require("fs");

const app = express();

// Read port and mongo URI from environment variables (ECS/Fargate)
const PORT = process.env.PORT || 3000;
const MONGO_URI = process.env.MONGO_URI;

// Connect to MongoDB / DocumentDB
db.connect({
  mongoUri: MONGO_URI,
  sslCAPath: "/usr/src/app/global-bundle.pem", // make sure Dockerfile copies this
  appInstance: app
});

// Middlewares
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

// Routes
require("./routes")(app);

// Start server
app.listen(PORT, () => {
  console.log(`Server is up on port ${PORT}`);
});

module.exports = app;
