import 'package:handover/model/user.dart';

class Status {
  User driver;
  User sender;
  User receiver;
  DeliveryStatus deliveryStatus;

  Status(this.driver, this.sender, this.receiver, this.deliveryStatus);

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['driver'] = driver.toMap();
    map['sender'] = sender.toMap();
    map['receiver'] = receiver.toMap();
    map['deliveryStatus'] = deliveryStatus.name;

    return map;
  }

  static Status toStatus(Map<dynamic, dynamic> map) {
    var driver = User.toUser(map['driver']);
    var sender = User.toUser(map['sender']);
    var receiver = User.toUser(map['receiver']);
    DeliveryStatus deliveryStatus =
        DeliveryStatus.values.firstWhere((element) => element.name == map['deliveryStatus']);

    var status = Status(driver, sender, receiver, deliveryStatus);

    return status;
  }
}

enum DeliveryStatus {
  ongoingPickup("On the way"),
  ongoingDelivery("Picked up delivery"),
  nearbyDelivery("Near Delivery destination"),
  done("Delivered package");

  final String stepperText;

  const DeliveryStatus(this.stepperText);
}
