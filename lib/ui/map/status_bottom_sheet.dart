import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:handover/ui/map/vertical_stepper.dart';

import '../../main.dart';
import '../../model/status.dart';
import '../../model/user.dart';

class StatusBottomSheet extends StatelessWidget {
  const StatusBottomSheet({super.key, required this.selectedDeliveryStatusIndex});

  final int selectedDeliveryStatusIndex;

  bool get showRatingDialog => currentUser?.userType != UserType.driver && appStatus?.deliveryStatus == DeliveryStatus.done;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.only(top: 60),
            decoration: const BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Column(
              children: [
                const Text(
                  "Mohammad Touhid",
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
                ),
                Visibility(
                  visible: !showRatingDialog,
                  child: SizedBox(
                    height: VerticalStepperView.stepHeight * DeliveryStatus.values.length,
                    child: VerticalStepperView(
                        selectedIndex: selectedDeliveryStatusIndex,
                        list: DeliveryStatus.values.map((e) => e.stepperText).toList()),
                  ),
                ),
                Visibility(
                  visible: showRatingDialog,
                  child: SizedBox(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.white,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          pickupTimeWidget("Pickup Time", "10:00 PM"),
                          const SizedBox(
                            height: 10,
                          ),
                          pickupTimeWidget("Delivery Time", "10:30 PM"),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: AlignmentDirectional.centerStart,
                            child: const Text(
                              "Total",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),

                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "\$30.00",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Submit",
                                          style: TextStyle(fontWeight: FontWeight.w700),
                                        ),
                                        Image.asset(
                                          "assets/images/arrow_next.png",
                                          height: 15,
                                          width: 15,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/round_avatar.png",
              width: 100,
              height: 100,
            )),
      ],
    );
  }

  Widget pickupTimeWidget(String label, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(time)
        ],
      ),
    );
  }
}
