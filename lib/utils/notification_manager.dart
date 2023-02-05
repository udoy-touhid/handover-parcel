import 'dart:math';

import 'package:flutter/material.dart';
import 'package:handover/main.dart';
import 'package:handover/model/status.dart';
import 'package:handover/model/user.dart';

class NotificationManager {
  BuildContext context;
  var isNotificationShow = false;
  var nearbyDistance = 50;
  var arrivalDistance = 5;

  NotificationManager(this.context) {}

  handleUpdates() {
    if (isNotificationShow) {
      return;
    }
    if (appStatus?.deliveryStatus == DeliveryStatus.ongoingPickup && userType == UserType.sender) {
      var distance = calculateDistance(currentUser?.latitude, currentUser?.longitude,
          appStatus?.driver.latitude, appStatus?.driver.longitude);

      if (distance > nearbyDistance) {
        return;
      }
      if (distance > arrivalDistance) {
        notifyUser("Driver coming", "Be prepared");
        return;
      } else {
        notifyUser("Driver arrived", "Deliver the parcel");
      }
    }
    else if (appStatus?.deliveryStatus == DeliveryStatus.ongoingDelivery && userType == UserType.receiver) {
      var distance = calculateDistance(currentUser?.latitude, currentUser?.longitude,
          appStatus?.driver.latitude, appStatus?.driver.longitude);

      if (distance > nearbyDistance) {
        return;
      }
      if (distance > arrivalDistance) {
        notifyUser("Driver coming", "Be prepared");
        return;
      } else {
        notifyUser("Driver arrived", "Receive the parcel");
      }
    }
  }

  notifyUser(String title, String description) {

    var dialog = showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(description),
            ));

    isNotificationShow = true;
  }

  //in kilometers
  double calculateDistance(double? lat1, double? lon1, double? lat2, double? lon2) {
    lat1 ??= 0.0;
    lat2 ??= 0.0;
    lon1 ??= 0.0;
    lon2 ??= 0.0;
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
