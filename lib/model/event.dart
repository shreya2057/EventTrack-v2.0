import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventModel {
  String id;
  String title;
  File eventCover;
  String eventCoverUrl;
  List<String> date;
  List<String> time;
  String description;
  String author;
  List categories;
  LocationModel location;

  EventModel({
    this.id,
    this.title,
    this.eventCover,
    this.eventCoverUrl,
    this.date,
    this.time,
    this.description,
    this.categories,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      // 'eventCover': eventCover,
      'eventCoverUrl': eventCoverUrl,
      'date': date,
      'time': time,
      'description': description,
      'categories': categories,
      'location': location != null ? location.toMap() : null,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['_id'],
      title: map['title'],
      eventCoverUrl: map['eventCoverUrl'],
      date: map['date'],
      time: map['time'],
      description: map['description'],
      categories: map['categories'],
      location: map['location'] != null
          ? LocationModel.fromMap(map['location'])
          : null,
    );
  }
}

class LocationModel {
  final Placemark placemark;
  final LatLng coordinates;

  LocationModel({this.coordinates, this.placemark});

  Map<String, dynamic> toMap() => {
        'latitude': coordinates.latitude ?? null,
        'longitude': coordinates.longitude ?? null,
        'name': placemark.name ?? null,
        'street': placemark.street ?? null,
        'locality': placemark.locality ?? '',
        'subLocality': placemark.subLocality ?? '',
        'administrativeArea': placemark.administrativeArea ?? '',
        'subAdministrativeArea': placemark.subAdministrativeArea ?? '',
        'country': placemark.country ?? null,
      };

  factory LocationModel.fromMap(Map<String, dynamic> map) => LocationModel(
        placemark: Placemark(
          name: map['name'],
          street: map['street'],
          locality: map['locality'],
          subLocality: map['subLocality'],
          administrativeArea: map['administrativeArea'],
          subAdministrativeArea: map['subAdministrativeArea'],
          country: map['country'],
        ),
        coordinates: LatLng(
          map['latitude'],
          map['longitude'],
        ),
      );
}
