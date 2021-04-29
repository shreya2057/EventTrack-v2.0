require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cloudinary = require("cloudinary").v2;

const app = express();
app.use(
	express.urlencoded({ extended: true }),
	express.json({ extended: true })
);

var authRoutes = require("./routes/auth");
var userRoutes = require("./routes/user");
var eventRoutes = require("./routes/event");


cloudinary.config({
	cloud_name: process.env.CLOUDINARY_NAME,
	api_key: process.env.CLOUDINARY_API_KEY,
	api_secret: process.env.CLOUDINARY_API_SECRET,
});

mongoose.set("useNewUrlParser", true);
mongoose.set("useUnifiedTopology", true);
mongoose.set("useCreateIndex", true);

mongoose
	.connect(
		"mongodb+srv://" +
		process.env.MONGO_USERNAME +
		":" +
		process.env.MONGO_PASSWORD +
		"@" +
		process.env.MONGO_HOSTNAME +
		"?retryWrites=true&w=majority"
		// "mongodb://localhost/EventTrack"
	)
	.then(
		() => {
			console.log("MongoDB Connected.");
		},
		(err) => {
			console.log(err.message);
		}
	);

app.use("/", authRoutes);
app.use("/u", userRoutes);
app.use("/e", eventRoutes);



app.get("*", function (_, res) {
	return res.json({
		message: "Invalid Route.",
		status: false,
	});
});

app.listen(3000, function () {
	console.log("Server started.");
});
