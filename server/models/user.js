var mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
	name: { type: String, required: true },
	email: { type: String, unique: true, required: true },
	password: { type: String, required: true },
	phone: Number,
	profileUrl: {
		type: String,
		default:
			"https://res.cloudinary.com/eventtrack39823/image/upload/v1615991990/defaultAvatar.jpg",
	},
	isEmailVerified: { type: Boolean, default: false },
	tokenInfo: {
		token: String,
		tokenExpiration: Date,
	},
	userRole: {
		admin: Boolean,
		eventOrganizer: Boolean,
	},
	registeredEvents: [mongoose.Schema.Types.ObjectId],
});

module.exports = new mongoose.model("User", userSchema);
