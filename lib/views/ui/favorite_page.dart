import 'package:codifyecommerce/views/shared/export.dart';
import '../shared/export_packages.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier =
        Provider.of<FavoriteNotifier>(context, listen: true);
    favoritesNotifier.getAllFav();
    return Scaffold(
        backgroundColor: const Color(0xffe2e2e2),
        body: favoritesNotifier.fav.isEmpty
            ? SafeArea(
                child: Center(
                    child: Column(
                children: [
                  ReusableText(
                      text: "Favorite is Empty",
                      style: appstyle(35, Colors.black, FontWeight.bold)),
                  SizedBox(
                    height: 150.h,
                  ),
                  Image.asset(
                    'assets/images/emptyfavorite.png',
                    fit: BoxFit.fill,
                  ),
                ],
              )))
            : SizedBox(
                height: 812.h,
                width: 375.w,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
                      height: 325.h,
                      width: 375.w,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/top_page.png'),
                              fit: BoxFit.fill)),
                      child: Padding(
                        padding: EdgeInsets.all(8.h),
                        child: Text(
                          "My Favorites",
                          style: appstyle(40, Colors.white, FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.h),
                        child: ListView.builder(
                            itemCount: favoritesNotifier.fav.length,
                            padding: EdgeInsets.only(top: 120.h),
                            itemBuilder: (BuildContext context, index) {
                              final product = favoritesNotifier.fav[index];
                              return Padding(
                                padding: EdgeInsets.all(8.h),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Container(
                                    height: 95.h,
                                    width: 375.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade500,
                                              spreadRadius: 5,
                                              blurRadius: 0.3,
                                              offset: const Offset(0, 1)),
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(12.h),
                                              child: CachedNetworkImage(
                                                imageUrl: product['imageUrl'],
                                                width: 70.h,
                                                height: 70.h,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 10.h,
                                                left: 20.w,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                    text: product['name'],
                                                    style: appstyle(
                                                        16,
                                                        Colors.black,
                                                        FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  ReusableText(
                                                    text: product['category'],
                                                    style: appstyle(
                                                        14,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ReusableText(
                                                        text:
                                                            "${product['price']}",
                                                        style: appstyle(
                                                            18,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.h),
                                          child: GestureDetector(
                                            onTap: () {
                                              favoritesNotifier
                                                  .deleteFav(product['key']);
                                              favoritesNotifier.ids.removeWhere(
                                                  (element) =>
                                                      element == product['id']);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainScreen(),
                                                  ));
                                            },
                                            child: const Icon(
                                              Ionicons.heart_dislike,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ],
                ),
              ));
  }
}
