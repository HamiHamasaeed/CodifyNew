import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/export.dart';

late GoogleMapController mapController;

void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  final String aboutParagraphe =
      "We are a passionate team dedicated to pushing the boundaries of technology through innovative coding, software development, and hardware solutions. At Codify, we believe in the power of collaboration, creativity, and clean code to transform ideas into reality";

  final String facebookUrl = "https://www.facebook.com/Codify.iq/";
  final String instagramUrl = 'https://www.instagram.com/Codify.iq/';
  final String linkedinUrl = 'https://www.linkedin.com/company/codify-iq/';
  final String tiktokUrl = 'https://www.tiktok.com/@codify.iq';

  Future<void> _launchUrl(String myUrl) async {
    Uri url = Uri.parse(myUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  final LatLng _center = const LatLng(35.55771617311098, 45.42851667365644);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe2e2e2),
      body: Column(children: [
        Stack(children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
            height: 325.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/top_page.png'),
                    fit: BoxFit.fill)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const CustomSpacer(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                Text("About Us",
                    style: appstyle(36, Colors.white, FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(right: 12.h),
                  child: Image.asset("assets/images/offwhite.png", width: 30.w),
                ),
              ]),
            ]),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.h, 150.h, 16.h, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image.asset(
                'assets/images/coverPage.png',
                fit: BoxFit.cover,
                height: 170.h,
              ),
            ),
          ),
        ]),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  width: 340.w,
                  child: Column(children: [
                    Text(
                      "Who Are We?",
                      style: appstyle(26, const Color.fromARGB(255, 31, 31, 31),
                          FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.w),
                      child: Text(
                        aboutParagraphe,
                        style: appstyle(12, Colors.black, FontWeight.w500),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Center(
                      child: Text(
                        "Contact Us",
                        style: appstyle(16, Colors.black, FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Image.asset(
                              'assets/images/email.png',
                              height: 20.h,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "Codify.iq@gmail.com",
                              style:
                                  appstyle(12, Colors.black, FontWeight.w500),
                            ),
                          ]),
                          Row(children: [
                            InkWell(
                              onTap: () => _launchUrl(facebookUrl),
                              child: Image.asset(
                                'assets/images/facebook.png',
                                height: 20.h,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            InkWell(
                              onTap: () => _launchUrl(instagramUrl),
                              child: Image.asset(
                                'assets/images/instagram.png',
                                height: 20.h,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            InkWell(
                              onTap: () => _launchUrl(linkedinUrl),
                              child: Image.asset(
                                'assets/images/linkedin.png',
                                height: 20.h,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            InkWell(
                              onTap: () => _launchUrl(tiktokUrl),
                              child: Image.asset(
                                'assets/images/tiktok.png',
                                height: 20.h,
                              ),
                            ),
                          ]),
                        ]),
                  ]),
                ),
                SizedBox(height: 15.h),
                Container(
                  padding: EdgeInsets.all(8.h),
                  width: 340.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(22, 174, 174, 174)
                            .withOpacity(0.3), // Shadow color
                        spreadRadius: 5.0, // Spread radius
                        blurRadius: 10.0, // Blur radius
                        offset: const Offset(1, 4), // Offset
                      )
                    ],
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Address",
                        style: appstyle(26, Colors.black, FontWeight.bold),
                      ),
                      Text(
                        "Iraq - Sulaymaniyah - Ali Namali - 3rd floor - Store 39",
                        style: appstyle(10, Colors.black, FontWeight.w500),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 230.h,
                        width: 340.h,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 15.0,
                          ),
                          markers: {
                            const Marker(
                              markerId: MarkerId('demo'),
                              position:
                                  LatLng(35.55771617311098, 45.42851667365644),
                            )
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
