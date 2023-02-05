import 'package:flutter/material.dart';
import 'package:handover/main.dart';
import 'package:handover/model/user.dart';
import 'package:handover/ui/map/map_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var buttonColor = Colors.green;
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Handover.\nBefore we get started, please let us know who you are.",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Select your role from below:",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              // height: 100,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: UserType.values.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      userType = UserType.values[index];
                    });
                  },
                  child: itemOptions(index),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const MapView()));
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                  foregroundColor: MaterialStateProperty.all<Color>(buttonColor),
                  backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ))),
              child: Text(
                "Start as a ${userType.name}",
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemOptions(int index) {
    bool isSelected = UserType.values[index] == userType;
    return Row(
      children: [
        Text(UserType.values[index].name.toUpperCase(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? Colors.red : Colors.black)),
        const SizedBox(width: 10,),
        Image.asset("assets/images/${UserType.values[index].name}_marker.png", width: 40,height: 40,)
      ],
    );
  }
}
