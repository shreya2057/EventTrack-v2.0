const express = require("express");
const router = express.Router();
// const multer = require("multer");
// const cloudinary = require("cloudinary").v2;
const User = require("../models/user");

// var storage = multer.diskStorage({
// 	filename: function (_, file, callback) {
// 		callback(null, Date.now() + file.originalname);
// 	},
// });

// var upload = multer({ storage: storage });

router.get("/", function (req, res) {
	User.findOne(
		{ _id: req.query.id },
		{ tokenInfo: 0, password: 0 },
		function (err, foundUser) {
			if (!err) {
				if (foundUser) {
					return res.json({
						user: foundUser,
						status: true,
					});
				} else {
					return res.json({
						message: "There was an error. Please try logging in again.",
					});
				}
			} else {
				return res.json({
					message: err.message,
				});
			}
		}
	);
});

module.exports = router;
