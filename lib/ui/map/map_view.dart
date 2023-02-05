import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handover/main.dart';
import 'package:handover/model/status.dart';
import 'package:handover/model/user.dart';
import 'package:handover/ui/map/status_bottom_sheet.dart';
import 'package:handover/utils/notification_manager.dart';
import 'package:location/location.dart';

import '../../utils/helpers.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MapView> {
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  Location location = Location();

  int selectedDeliveryStatusIndex = 0;

  GoogleMapController? mapController;
  Map<String, Marker> _markers = {};
  final LatLng _center = const LatLng(45.521563, -122.677433);

  StreamSubscription<LocationData>? locationSubscription;

  StreamSubscription<DatabaseEvent>? databaseSubscription;
  NotificationManager? notificationManager;

  @override
  initState() {
    super.initState();
    _markers.clear();

    databaseSubscription = databaseStatusNodeRef?.onValue.listen((DatabaseEvent event) async {
      Map<dynamic, dynamic>? statusValue = event.snapshot.value as Map?;

      if (statusValue != null) {
        Map<String, Marker> newMarkerMap = {};
        appStatus = Status.toStatus(statusValue);
        notificationManager?.handleUpdates();
        var newIndex = appStatus?.deliveryStatus.index ?? 0;
        if (newIndex != selectedDeliveryStatusIndex) {
          setState(() {
            selectedDeliveryStatusIndex = newIndex;
          });
        }
        for (var element in UserType.values) {
          late User currentUserForMarker;
          if (element == UserType.driver) {
            currentUserForMarker = appStatus!.driver;
          } else if (element == UserType.sender) {
            currentUserForMarker = appStatus!.sender;
            //
          } else {
            currentUserForMarker = appStatus!.receiver;
          }

          var marker = await getMarkerForUser(currentUserForMarker);
          newMarkerMap[element.name] = marker;
        }

        if (mounted) {
          setState(() {
            _markers.clear();
            _markers = newMarkerMap;
          });
        }
      }
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    notificationManager = NotificationManager(context);
    await initLocation();
  }

  Future initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.enableBackgroundMode(enable: true);
    locationSubscription = location.onLocationChanged.listen((LocationData currentLocation) async {
      if (!mounted) {
        return;
      }

      currentUser =
          User(userType, currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0);
      var latLong = LatLng(currentLocation.latitude ?? 0.01, currentLocation.longitude ?? 0.01);

      databaseStatusNodeRef?.child(userType.name).set(currentUser!.toMap());

      mapController?.animateCamera(CameraUpdate.newLatLng(latLong));

      var marker = await getMarkerForUser(currentUser!);
      if (mounted) {
        setState(() {
          _markers[userType.name] = marker;
          _markers = _markers;
        });
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 270),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: currentUser != null
                      ? LatLng(currentUser!.latitude, currentUser!.longitude)
                      : _center,
                  zoom: 10.0,
                ),
                markers: _markers.values.toSet(),
              ),
            ),
            Align(alignment: Alignment.topRight, child: restOfContent()),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 350,
                child: StatusBottomSheet(
                  selectedDeliveryStatusIndex: selectedDeliveryStatusIndex,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                          color: Colors.black,
                          height: 20,
                          width: 20,
                          "assets/images/arrow_prev.png"))),
            ),
          ],
        ),
      ),
    );
  }

  Widget restOfContent() {
    String buttonText = "";

    DeliveryStatus? deliveryStatusUpdate;

    if (userType == UserType.sender && appStatus?.deliveryStatus == DeliveryStatus.ongoingPickup) {
      buttonText = "Picked up?";
      deliveryStatusUpdate = DeliveryStatus.ongoingDelivery;
    } else if (userType == UserType.receiver &&
        (appStatus?.deliveryStatus == DeliveryStatus.ongoingDelivery ||
            appStatus?.deliveryStatus == DeliveryStatus.nearbyDelivery)) {
      buttonText = "Got the parcel?";
      deliveryStatusUpdate = DeliveryStatus.done;
    } else if (appStatus?.deliveryStatus == DeliveryStatus.done && userType == UserType.driver) {
      deliveryStatusUpdate = DeliveryStatus.ongoingPickup;
      buttonText = "Start new delivery?";

      //show rating dialog
    }
    return Visibility(
      visible: deliveryStatusUpdate != null,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: TextButton(
            onPressed: () {
              if (deliveryStatusUpdate != null) {
                databaseStatusNodeRef?.update({"deliveryStatus": deliveryStatusUpdate.name});
              }
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ))),
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    databaseSubscription?.cancel();
    mapController?.dispose();
    location.enableBackgroundMode(enable: false);
    super.dispose();
  }
}
