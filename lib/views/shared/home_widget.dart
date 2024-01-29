import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../models/sensors_model.dart';
import 'app_style.dart';
import 'new_arduino.dart';
import 'product_cart.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sensors>> arduino,
  }) : _arduino = arduino;

  final Future<List<Sensors>> _arduino;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child: FutureBuilder<List<Sensors>>(
              future: _arduino,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final arduino = snapshot.data;
                  return ListView.builder(
                      itemCount: arduino!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final myArduino = snapshot.data![index];
                        return ProductCart(
                            price: "\$${myArduino.price}",
                            category: myArduino.category,
                            id: myArduino.id,
                            name: myArduino.name,
                            image: myArduino.imageUrl[0]);
                      });
                }
              }),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Sensors",
                    style: appstyle(24, Colors.black, FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Show All",
                        style: appstyle(22, Colors.black, FontWeight.normal),
                      ),
                      const Icon(
                        Ionicons.caret_forward,
                        size: 20,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          child: FutureBuilder<List<Sensors>>(
              future: _arduino,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final arduino = snapshot.data;
                  return ListView.builder(
                      itemCount: arduino!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final myArduino = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NewArduino(imageUrl: myArduino.imageUrl[1]),
                        );
                      });
                }
              }),
        )
      ],
    );
  }
}
