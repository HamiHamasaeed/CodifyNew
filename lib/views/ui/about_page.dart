import 'package:url_launcher/url_launcher.dart';
import '../shared/export.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  final String aboutParagraphe =
      "We are a passionate team dedicated to pushing the boundaries of technology through innovative coding, software development, and hardware solutions. At Codify, we believe in the power of collaboration, creativity, and clean code to transform ideas into reality";

  Future<void> _launchUrl(String myUrl) async {
    Uri _url = Uri.parse(myUrl);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe2e2e2),
      body: SizedBox(
        height: 812.h,
        width: 375.w,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
                  height: 325.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/top_page.png'),
                          fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomSpacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              style:
                                  appstyle(36, Colors.white, FontWeight.bold)),
                          Padding(
                            padding: EdgeInsets.only(right: 12.h),
                            child: Image.asset("assets/images/offwhite.png",
                                width: 30.w),
                          ),
                        ],
                      ),
                    ],
                  ),
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
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                children: [
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
                    // height: 300.h,
                    width: 340.w,
                    child: Column(
                      children: [
                        Text(
                          "Who Are We?",
                          style: appstyle(
                              30,
                              const Color.fromARGB(255, 31, 31, 31),
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
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: Text(
                            "Contact Us",
                            style: appstyle(16, Colors.black, FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/email.png',
                                  height: 20.h,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "Codify.iq@gmail.com",
                                  style: appstyle(
                                      12, Colors.black, FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => _launchUrl(
                                      'https://www.facebook.com/Codify.iq/'),
                                  child: Image.asset(
                                    'assets/images/facebook.png',
                                    height: 20.h,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                InkWell(
                                  onTap: () => _launchUrl(
                                      'https://www.instagram.com/Codify.iq/'),
                                  child: Image.asset(
                                    'assets/images/instagram.png',
                                    height: 20.h,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                InkWell(
                                  onTap: () => _launchUrl(
                                      'https://www.linkedin.com/company/codify-iq/'),
                                  child: Image.asset(
                                    'assets/images/linkedin.png',
                                    height: 20.h,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                InkWell(
                                  onTap: () => _launchUrl(
                                      'https://www.tiktok.com/@codify.iq'),
                                  child: Image.asset(
                                    'assets/images/tiktok.png',
                                    height: 20.h,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
