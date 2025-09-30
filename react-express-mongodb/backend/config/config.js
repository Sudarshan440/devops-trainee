// 

// env.js
const env = process.env.NODE_ENV || "development";

if (env === "development" || env === "test") {
  // In ECS, MONGO_URI and PORT come from environment variables
  const port = process.env.PORT || 3000;
  const mongoUri = process.env.MONGO_URI; // comes from ECS Task Definition

  module.exports = { port, mongoUri };
} else {
  // For production, use ECS environment variables as well
  const port = process.env.PORT;
  const mongoUri = process.env.MONGO_URI;

  module.exports = { port, mongoUri };
}
