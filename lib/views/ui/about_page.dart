import '../shared/export.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                          Text("About",
                              style:
                                  appstyle(42, Colors.white, FontWeight.bold)),
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
              child: Text("About",
                  style: appstyle(40, Colors.black, FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
