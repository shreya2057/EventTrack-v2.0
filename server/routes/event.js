const express = require("express");
const router = express.Router();
const multer = require("multer");
const cloudinary = require("cloudinary").v2;
const Event = require("../models/event");

var storage = multer.diskStorage({
	filename: function (_, file, callback) {
		callback(null, Date.now() + file.originalname);
	},
});

var upload = multer({ storage: storage });

router.post("/create", function (req, res) {
	Event.findOne(
		{ title: req.body.title },
		{ _id: 0, title: 1 },
		function (_, foundTitle) {
			if (foundTitle) {
				return res.json({
					message:
						"Event with same name already exists. Please try a new title for your event.",
					status: false,
				});
			} else {
				let newEvent = new Event({
					title: req.body.title,
					description: req.body.description,
					categories: req.body.categories,
					location: req.body.location,
					dateTime: {
						date: req.body.date,
						time: req.body.time,
					},
				});

				newEvent.save(function (err) {
					if (!err) {
						return res.json({
							message: "Your event has been created.",
							value: newEvent._id,
							status: true,
						});
					} else {
						return res.json({
							message: err.message,
							status: false,
						});
					}
				});
			}
		}
	);
});

router.post("/upload-cover", upload.single("eventCover"), function (req, res) {
	Event.findOne(
		{ _id: req.body.id },
		{ eventCoverUrl: 1, title: 1, images: 1 },
		function (err, foundEvent) {
			if (err) {
				return res.json({
					message: "Could not find your event.",
					status: false,
				});
			} else {
				cloudinary.uploader.upload(
					req.file.path,
					{
						folder: "/events/" + foundEvent.title + "-" + foundEvent._id,
						public_id: req.file.filename + "-u" + Date.now().toString(),
					},
					function (err, result) {
						if (err) {
							res.json({
								message: err.message,
								isSuccess: false,
							});
						} else {
							foundEvent.eventCoverUrl = result.secure_url;
							foundEvent.images.push({
								url: result.secure_url,
								description: "",
							});
							foundEvent.save(function (err) {
								if (!err) {
									return res.json({
										value: result.secure_url,
										status: true,
									});
								} else {
									return res.json({
										message: err.message,
										status: false,
									});
								}
							});
						}
					}
				);
			}
		}
	);
});
module.exports = router;
