
const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
var async = require("async");
var nodemailer = require("nodemailer");
var crypto = require("crypto");
const Event = require("../models/event");


router.get("/", function (_, res) {
    return res.send("You are not authorized to visit this website.");
});
router.post("/eventform", function (req, res) {
    Event.findOne(
        { title: req.body.title },
        { _id: 0, title: 1 },
        function (_, foundTitle) {
            if (foundTitle) {
                return res.json({
                    message: "Title Already Exists",
                    status: false,
                });
            } else {
                const newEvent = new Event();
                newEvent.title = req.body.title;
                newEvent.description = req.body.description;
                // newEvent.eventPhotoUrl = req.body.url;
                // var categories = req.body.category.split(",");
                // newEvent.category = categories;
                // var location = {
                //     latitude: req.body.latitude,
                //     longitude: req.body.longitude,
                //     city: req.body.city,
                //     country: req.body.country,
                // };
                // newEvent.location = location;
                // newEvent.dateTime.startDate = Date.now();

                newEvent.save(function (err) {
                    if (!err) {
                        return res.json({ event: { _id: newEvent._id }, status: true });
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



);



module.exports = router;