const mongoose = require("mongoose");
const fs = require("fs");

exports.connect = (app) => {
  const options = {
    useNewUrlParser: true,
    autoIndex: false,
    maxPoolSize: 10,
    ssl: true,
    sslCA: fs.readFileSync("/usr/src/app/global-bundle.pem") // TLS cert for DocumentDB
  };

  const connectWithRetry = () => {
    mongoose.Promise = global.Promise;
    console.log("MongoDB connection with retry");

    mongoose
      .connect(process.env.MONGO_URI, options) // use ECS injected env variable
      .then(() => {
        console.log("MongoDB is connected");
        app.emit("ready");
      })
      .catch((err) => {
        console.log("MongoDB connection unsuccessful, retry after 2 seconds.", err);
        setTimeout(connectWithRetry, 2000);
      });
  };

  connectWithRetry();
};
