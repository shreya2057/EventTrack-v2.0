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

router.get("/", function (_, res) {
	return res.send("You are not authorized to visit this website.");
});
router.post("/create", upload.single("eventCover"), function (req, res) {
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
				let newEvent = new Event(req.body);
				cloudinary.uploader.upload(
					req.file.path,
					{
						folder: "/events/" + newEvent.title + "-" + newEvent._id,
						public_id: req.file.filename + "-u" + Date.now().toString(),
					},
					function (err, result) {
						if (err) {
							res.json({
								message: err.message,
								isSuccess: false,
							});
						} else {
							newEvent.eventCoverUrl = result.secure_url;
							newEvent.save(function (err) {
								if (!err) {
									return res.json({
										message: "Your event has been created.",
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
