var mongoose = require("mongoose");

var eventSchema = new mongoose.Schema({
	title: { type: String, required: true, unique: true },
	description: { type: String },
	categories: Array,
	eventCoverUrl: { type: String },
	location: {
		latitude: Number,
		longitude: Number,
		name: String,
		street: String,
		locality: String,
		subLocality: String,
		administrativeArea: String,
		subAdministrativeArea: String,
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
		// required: true,
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
