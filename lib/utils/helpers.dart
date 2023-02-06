import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/user.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List()!;
}

Future<Marker> getMarkerForUser(User user) async {
  var markerSize = 130;
  if (user.userType == UserType.driver) {
    markerSize = 80;
  }
  markerSize = 100;
  var markerImage =
      await getBytesFromAsset("assets/images/${user.userType.name}_marker.png", markerSize);

  return Marker(
      markerId: MarkerId(user.userType.name),
      position: LatLng(user.latitude, user.longitude),
      icon: BitmapDescriptor.fromBytes(markerImage));
}
