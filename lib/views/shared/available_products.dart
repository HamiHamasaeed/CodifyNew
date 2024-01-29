import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/sensors_model.dart';
import 'stagger_tile.dart';

class AvailableProducts extends StatelessWidget {
  const AvailableProducts({
    super.key,
    required Future<List<Sensors>> arduino,
  }) : _arduino = arduino;

  final Future<List<Sensors>> _arduino;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sensors>>(
      future: _arduino,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          final arduino = snapshot.data;
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            itemCount: arduino!.length,
            scrollDirection: Axis.vertical,
            staggeredTileBuilder: (index) => StaggeredTile.extent(
                (index % 2 == 0) ? 1 : 1,
                (index % 4 == 1 || index % 4 == 3)
                    ? MediaQuery.of(context).size.height * 0.35
                    : MediaQuery.of(context).size.height * 0.3),
            itemBuilder: (context, index) {
              final myArduino = snapshot.data![index];
              return StaggerTile(
                  imageUrl: myArduino.imageUrl[0],
                  name: myArduino.name,
                  price: "\$${myArduino.price}");
            },
          );
        }
      },
    );
  }
}
