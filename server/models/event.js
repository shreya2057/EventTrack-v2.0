var mongoose = require("mongoose");

var eventSchema = new mongoose.Schema({
	title: { type: String, required: true, unique: true },
	description: { type: String },
	category: Array,
	// eventPhotoUrl: { type: String, required: true },
	location: {
		latitude: Number,
		longitude: Number,
		city: String,
		country: String,
	},
	// dateTime: {
	// 	startDate: { type: Date, required: true },
	// 	endDate: Date,
	// },
	createdAt: { type: Date, default: Date.now() },
	eventFee: { type: Number, default: 0.0 },
	verificationState: {
		isVerified: { type: Boolean, default: false },
		verifiedBy: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
		time: { type: Date },
	},
	author: {
		type: mongoose.Schema.Types.ObjectId,
		ref: "User",
	},
	images: [
		{
			url: { type: String, required: true },
			uploadedAt: { type: Date, default: Date.now() },
			description: String,
		},
	],
	registeredUsers: [mongoose.Schema.Types.ObjectId],
});

module.exports = new mongoose.model("Event", eventSchema);
