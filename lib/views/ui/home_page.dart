import 'package:codifyecommerce/controllers/product_provider.dart';
import 'package:codifyecommerce/views/shared/app_style.dart';
import 'package:codifyecommerce/views/shared/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getArduinoFromHelper();
    productNotifier.getSensorFromHelper();
    productNotifier.getOthersFromHelper();

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
                        fit: BoxFit.fill)),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomSpacer(),
                      Image.asset(
                        ("assets/images/codifyLogo.png"),
                        width: 180,
                      ),
                      const CustomSpacer(),
                      // Text("Shop",
                      //     style: appstyleWithHeight(
                      //         42, Colors.white, FontWeight.bold, 1.2)),
                      TabBar(
                          dividerColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appstyle(24, Colors.white, FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.3),
                          tabs: const [
                            Tab(text: "Arduino"),
                            Tab(text: "Sensors"),
                            Tab(text: "Drivers"),
                          ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.264),
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    HomeWidget(
                      arduino: productNotifier.arduino,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      arduino: productNotifier.sensor,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      arduino: productNotifier.other,
                      tabIndex: 2,
                    ),
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}
