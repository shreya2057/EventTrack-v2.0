const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
var async = require("async");
var nodemailer = require("nodemailer");
var crypto = require("crypto");
const User = require("../models/user");

const saltRounds = 10;

router.get("/", function (_, res) {
	return res.send("You are not authorized to visit this website.");
});

router.post("/signup", function (req, res) {
	User.findOne(
		{ email: req.body.email },
		{ _id: 0, email: 1 },
		function (_, foundEmail) {
			if (foundEmail) {
				return res.json({
					message: "Email Already Exists",
					status: false,
				});
			} else {
				const newUser = User();
				newUser.name = req.body.name;
				newUser.email = req.body.email;
				newUser.phone = req.body.phone;
				bcrypt.hash(req.body.password, saltRounds, function (err, hash) {
					if (err) {
						return res.json({
							message: err.message,
							status: false,
						});
					} else {
						newUser.password = hash;

						newUser.save(function (err) {
							if (!err) {
								return res.json({ user: { _id: newUser._id }, status: true });
							} else {
								return res.json({
									message: err.message,
									status: false,
								});
							}
						});
					}
				});
			}
		}
	);
});

router.post("/login", function (req, res) {
	User.findOne(
		{ email: req.body.email },
		{ password: 1, email: 1, isEmailVerified: 1 },
		function (err, foundUser) {
			if (err) {
				return res.json({
					message: err.message,
					status: false,
				});
			} else {
				if (!foundUser) {
					return res.json({
						message: "Invalid Email/Password",
						status: false,
					});
				} else {
					bcrypt.compare(
						req.body.password,
						foundUser.password,
						function (_, result) {
							if (result) {
								return res.json({
									user: {
										_id: foundUser._id,
										isEmailVerified: foundUser.isEmailVerified,
									},
									status: true,
								});
							} else {
								return res.json({
									message: "Invalid Username/Password.",
									status: false,
								});
							}
						}
					);
				}
			}
		}
	);
});

router.post("/sendToken", function (req, res) {
	var token = crypto.randomBytes(2).toString("hex").toUpperCase();

	User.findOne(
		{ email: req.body.email },
		{ _id: 1 },
		function (err, foundUser) {
			if (!err) {
				if (foundUser) {
					async function main() {
						var smtpTransport = nodemailer.createTransport({
							service: "Gmail",
							auth: {
								user: process.env.GMAIL,
								pass: process.env.GMAIL_PASSWORD,
							},
						});
						var mailOptions = {
							from: process.env.GMAIL,
							to: req.body.email,
							subject: "Token Request",
							html:
								'Here is the token you requested: <br><h3 style="font-size: 20px; padding:0 1.5rem; margin: 0.5rem;"><strong>' +
								token +
								"</strong></h3><br>This token expires after 1 hour.<br><br><strong><em>**In case you don't recognize requesting for a token, leave the token as it is.**</em></strong>",
						};
						foundUser.tokenInfo = {
							token: token,
							tokenExpiration: Date.now() + 3600000,
						};
						smtpTransport.sendMail(mailOptions, function (err) {
							if (!err) {
								foundUser.save();
								return res.json({
									message: "A token has been sent. Please check your email.",
									status: true,
								});
							}
							return res.json({
								message: "Error Sending Token. Please try again.",
								status: false,
							});
						});
					}

					main().catch(console.error);
				} else {
					return res.json({
						message:
							"We could not find your account. Please make sure you have your account on the email you provided.",
					});
				}
			} else {
				return res.json({
					message: err.message,
					status: false,
				});
			}
		}
	);
});

router.get("/verify", function (req, res) {
	User.findOne(
		{ email: req.query.email },
		{ _id: 1, tokenInfo: 1, isEmailVerified: 1 },
		function (err, foundUser) {
			if (!err) {
				if (foundUser) {
					if (foundUser.tokenInfo) {
						if (
							foundUser.tokenInfo.token === req.query.token.toUpperCase() &&
							foundUser.tokenInfo.tokenExpiration > Date.now()
						) {
							foundUser.tokenInfo = undefined;
							foundUser.isEmailVerified = true;

							foundUser.save(function (err) {
								if (!err)
									return res.json({
										message: "Your email has been verified.",
										user: { _id: foundUser._id },
										status: true,
									});
								return res.json({
									message: err.message,
									status: false,
								});
							});
						} else {
							return res.json({
								message: "The token is invalid or has expired.",
								status: false,
							});
						}
					} else {
						return res.json({
							message: "There was an error. Please try a new code.",
							status: false,
						});
					}
				}
			} else {
				return res.json({
					message: err.message,
					status: false,
				});
			}
		}
	);
});

router.get("/resetPassword", function (req, res) {
	User.findOne(
		{ email: req.query.email },
		{ tokenInfo: 1 },
		function (err, foundUser) {
			if (!err) {
				if (foundUser) {
					if (foundUser.tokenInfo) {
						if (
							foundUser.tokenInfo.token === req.query.token.toUpperCase() &&
							foundUser.tokenInfo.tokenExpiration > Date.now()
						) {
							foundUser.tokenInfo = undefined;

							foundUser.save(function (err) {
								if (!err)
									return res.json({
										message: "Set your new password.",
										status: true,
									});
								return res.json({
									message: err.message,
									status: false,
								});
							});
						} else {
							return res.json({
								message: "The token is invalid or has expired.",
								status: false,
							});
						}
					} else {
						return res.json({
							message: "There was an error. Please try a new code.",
							status: false,
						});
					}
				} else {
					return res.json({
						message: "We could not find your email.",
						status: false,
					});
				}
			} else {
				return res.json({
					message: err.message,
					status: false,
				});
			}
		}
	);
});

router.post("/resetPassword", function (req, res) {
	User.findOne(
		{ email: req.body.email },
		{ password: 1 },
		function (err, foundUser) {
			if (!err) {
				if (foundUser) {
					bcrypt.hash(req.body.password, saltRounds, function (err, hash) {
						if (!err) {
							foundUser.password = hash;
							foundUser.save(function (err) {
								if (!err)
									return res.json({
										user: { _id: foundUser._id },
										status: true,
									});
								return res.json({
									message: err.message,
									status: false,
								});
							});
						} else {
							return res.json({
								message: err.message,
								status: false,
							});
						}
					});
				}
			} else {
				return res.json({
					message: err.message,
					status: false,
				});
			}
		}
	);
});



module.exports = router;
