import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' as geoCo;
import 'package:location/location.dart';

class LocationService {
  final _location = Location();

  Future<bool> _checkForService() async {
    bool isEnabled = await _location.serviceEnabled();

    if (isEnabled) {
      return true;
    }

    isEnabled = await _location.requestService();

    if (isEnabled) {
      return true;
    }

    return false;
  }

  Future<bool> _checkForPermission() async {
    PermissionStatus status = await _location.hasPermission();
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
      return status == PermissionStatus.granted;
    } else {
      return false;
    }
  }

  Future<geoCo.Placemark> getUserLocation() async {
    if (!(await _checkForService())) {
      throw Exception("Location service not available");
    }
    if (!(await _checkForPermission())) {
      throw Exception("Permission not available");
    }
    final LocationData locationData = await _location.getLocation();

    List<geoCo.Placemark> placemarks = await geoCo.placemarkFromCoordinates(
        locationData.latitude!, locationData.longitude!);
    if (placemarks.first.country != null) {
      final geoCo.Placemark placemark = placemarks.first;
      return placemark;
    }
    return Future.error("cant find country");
  }
}

final userLocationProvider = FutureProvider<geoCo.Placemark>((ref) async {
  final locationService = LocationService();
  return locationService.getUserLocation();
});
