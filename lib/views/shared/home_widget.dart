import 'package:codifyecommerce/controllers/product_provider.dart';
import 'package:codifyecommerce/views/ui/product_by_cart.dart';
import 'package:codifyecommerce/views/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../../models/sensors_model.dart';
import 'app_style.dart';
import 'new_arduino.dart';
import 'product_cart.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sensors>> arduino,
    required this.tabIndex,
  }) : _arduino = arduino;

  final Future<List<Sensors>> _arduino;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);

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
                        return GestureDetector(
                          onTap: () {
                            productNotifier.arduinoSize = myArduino.sizes;
                            // print(productNotifier.arduinoSize);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                        id: myArduino.id,
                                        category: myArduino.category)));
                          },
                          child: ProductCart(
                              price: "\$${myArduino.price}",
                              category: myArduino.category,
                              id: myArduino.id,
                              name: myArduino.name,
                              imageUrl: myArduino.imageUrl[0]),
                        );
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
                    "Latest Products",
                    style: appstyle(24, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductByCart(tabIndex: tabIndex),
                        ),
                      );
                    },
                    child: Row(
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
                    ),
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
