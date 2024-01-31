import 'package:codifyecommerce/views/shared/category_btn.dart';
import 'package:codifyecommerce/views/shared/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/sensors_model.dart';
import '../../services/helper.dart';
import '../shared/app_style.dart';
import '../shared/available_products.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Sensors>> _sensor;
  late Future<List<Sensors>> _arduino;
  late Future<List<Sensors>> _other;

  void getSensorFromHelper() {
    _sensor = Helper().getSensor();
  }

  void getArduinoFromHelper() {
    _arduino = Helper().getArduino();
  }

  void getOthersFromHelper() {
    _other = Helper().getOthers();
  }

  List<String> brand = [
    "assets/images/arduino.png",
    "assets/images/arduino.png",
    "assets/images/arduino.png",
    "assets/images/raspberrypi.png",
    "assets/images/raspberrypi.png",
    "assets/images/raspberrypi.png",
  ];

  @override
  void initState() {
    super.initState();
    getSensorFromHelper();
    getArduinoFromHelper();
    getOthersFromHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe2e2e2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/top_page.png'),
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(FontAwesomeIcons.sliders,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  TabBar(                     
                      dividerColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs: const [
                        Tab(text: "Arduino"),
                        Tab(text: "Sensors"),
                        Tab(text: "Drivers"),
                      ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.175,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AvailableProducts(arduino: _arduino),
                    AvailableProducts(arduino: _sensor),
                    AvailableProducts(arduino: _other),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        context: context,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.84,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: 14,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        const CustomSpacer(),
                        Text(
                          "Filter",
                          style: appstyle(40, Colors.black, FontWeight.bold),
                        ),
                        const CustomSpacer(),
                        Text(
                          "Type",
                          style: appstyle(20, Colors.black, FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            CategoryBtn(
                                buttonColor: Colors.black, label: "Arduino"),
                            CategoryBtn(
                                buttonColor: Colors.blueGrey, label: "Sensors"),
                            CategoryBtn(
                                buttonColor: Colors.blueGrey, label: "Drivers"),
                          ],
                        ),
                        const CustomSpacer(),
                        Text(
                          "Price",
                          style: appstyle(20, Colors.black, FontWeight.bold),
                        ),
                        const CustomSpacer(),
                        Slider(
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
                            thumbColor: Colors.black,
                            max: 500,
                            divisions: 50,
                            label: _value.toString(),
                            secondaryTrackValue: 200,
                            value: _value,
                            onChanged: (double value) {}),
                        const CustomSpacer(),
                        Text(
                          "Brand",
                          style: appstyle(20, Colors.black, FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 100,
                          child: ListView.builder(
                            itemCount: brand.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12),
                                      )),
                                  child: Image.asset(
                                    brand[index],
                                    height: 80,
                                    width: 80,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
