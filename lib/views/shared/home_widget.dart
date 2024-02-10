import 'export.dart';
import 'export_packages.dart';

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
          height: 325.h,
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
              padding: EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: "Latest Products",
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
                        ReusableText(
                          text: "Show All",
                          style: appstyle(18, Colors.black, FontWeight.normal),
                        ),
                        Icon(
                          Ionicons.caret_forward,
                          size: 20.h,
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
          height: 99.h,
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
                          padding: EdgeInsets.all(8.0.h),
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
