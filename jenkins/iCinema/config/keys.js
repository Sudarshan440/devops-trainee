require('dotenv').config(); // for local development

const dev = {
  mongoURI: process.env.MONGO_URI || "mongodb://localhost:27017/icinemadb",
  secretOrKey: process.env.SECRET_OR_KEY || "localsecret"
};

const prod = {
  mongoURI: process.env.MONGODB_URI,
  secretOrKey: process.env.SECRET_OR_KEY
};

const config = process.env.NODE_ENV === 'production' ? prod : dev;

module.exports = config;
