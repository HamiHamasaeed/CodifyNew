import 'package:codifyecommerce/views/shared/export.dart';
import 'package:codifyecommerce/views/shared/export_packages.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getArduino(widget.category, widget.id);

    var favoitresNotifier =
        Provider.of<FavoriteNotifier>(context, listen: true);
    favoitresNotifier.getFavorites();
    return Scaffold(
        backgroundColor: const Color(0xeef2f2f2),
        body: FutureBuilder<Sensors>(
            future: productNotifier.product,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final product = snapshot.data;
                return Consumer<ProductNotifier>(
                  builder: (context, productNotifier, child) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leadingWidth: 0,
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    productNotifier.arduinoSize.clear();
                                  },
                                  child: const Icon(Ionicons.close_sharp),
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child:
                                      const Icon(Ionicons.ellipsis_horizontal),
                                ),
                              ],
                            ),
                          ),
                          pinned: true,
                          snap: false,
                          floating: true,
                          backgroundColor: Colors.transparent,
                          expandedHeight: MediaQuery.of(context).size.height,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                SizedBox(
                                  height: 401.h,
                                  width: 375.w,
                                  child: PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: product!.imageUrl.length,
                                    controller: pageController,
                                    onPageChanged: (page) {
                                      productNotifier.activePage = page;
                                    },
                                    itemBuilder: (context, int index) {
                                      return Stack(
                                        children: [
                                          Container(
                                            height: 316.h,
                                            width: 375.w,
                                            color: const Color.fromARGB(
                                                255, 240, 233, 233),
                                            child: CachedNetworkImage(
                                              imageUrl: product.imageUrl[index],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Positioned(
                                            top: 85.h,
                                            right: 15.w,
                                            child: Consumer<FavoriteNotifier>(
                                              builder: (BuildContext context,
                                                  favoriteNotifier,
                                                  Widget? child) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (favoriteNotifier.ids
                                                        .contains(widget.id)) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const FavoritePage()));
                                                    } else {
                                                      favoitresNotifier
                                                          .createFav({
                                                        "id": product.id,
                                                        "name": product.name,
                                                        "category":
                                                            product.category,
                                                        "price": product.price,
                                                        "imageUrl":
                                                            product.imageUrl[0]
                                                      });
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: favoriteNotifier.ids
                                                          .contains(product.id)
                                                      ? const Icon(
                                                          Ionicons.heart)
                                                      : const Icon(Ionicons
                                                          .heart_outline),
                                                );
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            height: 245.h,
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List<Widget>.generate(
                                                  product.imageUrl.length,
                                                  (index) => Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor:
                                                            productNotifier
                                                                        .activePage !=
                                                                    index
                                                                ? Colors.grey
                                                                : Colors.black),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 30.h,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    child: Container(
                                      height: 525.h,
                                      width: 375.w,
                                      color: const Color(0xeef2f2f2),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ReusableText(
                                              text: product.name,
                                              style: appstyle(35, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                ReusableText(
                                                  text: product.category,
                                                  style: appstyle(
                                                      20,
                                                      Colors.blueGrey,
                                                      FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                RatingBar.builder(
                                                  initialRating: 4,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 22,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(horizontal: 1),
                                                  itemBuilder: (context, _) =>
                                                      Icon(Icons.star,
                                                          size: 18.h,
                                                          color: Colors.black),
                                                  onRatingUpdate: (rating) {},
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ReusableText(
                                                  text: "\$${product.price}",
                                                  style: appstyle(
                                                      26,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                Row(
                                                  children: [
                                                    ReusableText(
                                                      text: "Colors",
                                                      style: appstyle(
                                                          18,
                                                          Colors.black,
                                                          FontWeight.w500),
                                                    ),
                                                    SizedBox(width: 5.h),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.blue,
                                                    ),
                                                    SizedBox(width: 5.h),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    ReusableText(
                                                      text: "Select Sizes",
                                                      style: appstyle(
                                                          20,
                                                          Colors.black,
                                                          FontWeight.w600),
                                                    ),
                                                    SizedBox(width: 20.w),
                                                    ReusableText(
                                                      text: "View size guide",
                                                      style: appstyle(
                                                          20,
                                                          Colors.grey,
                                                          FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.h),
                                                SizedBox(
                                                  height: 40.h,
                                                  child: ListView.builder(
                                                      itemCount: 3,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      padding: EdgeInsets.zero,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final sizes =
                                                            productNotifier
                                                                    .arduinoSize[
                                                                index];
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.0.h),
                                                          child: ChoiceChip(
                                                            showCheckmark:
                                                                false,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.w,
                                                                  style:
                                                                      BorderStyle
                                                                          .solid),
                                                            ),
                                                            disabledColor:
                                                                Colors.white,
                                                            label: Text(
                                                              sizes['size'],
                                                              style: appstyle(
                                                                  18,
                                                                  sizes['isSelected']
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black87,
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                            selectedColor:
                                                                Colors.black,
                                                            selected: sizes[
                                                                'isSelected'],
                                                            onSelected:
                                                                (newState) {
                                                              if (productNotifier
                                                                  .sizes
                                                                  .contains(sizes[
                                                                      'size'])) {
                                                                productNotifier
                                                                    .sizes
                                                                    .remove(sizes[
                                                                        'size']);
                                                              } else {
                                                                productNotifier
                                                                    .sizes
                                                                    .add(sizes[
                                                                        'size']);
                                                              }
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            const Divider(
                                              indent: 10,
                                              endIndent: 10,
                                              color: Colors.black,
                                            ),
                                            SizedBox(height: 10.h),
                                            SizedBox(
                                              width: 300.w,
                                              child: Text(
                                                product.title,
                                                style: appstyle(
                                                    26,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(height: 10.w),
                                            Text(
                                              product.description,
                                              maxLines: 5,
                                              textAlign: TextAlign.justify,
                                              style: appstyle(
                                                  14,
                                                  const Color.fromARGB(
                                                      255, 100, 100, 100),
                                                  FontWeight.normal),
                                            ),
                                            SizedBox(height: 10.h),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2.h),
                                                child: AddToCartBtn(
                                                  label: "Add To Cart",
                                                  onTap: () async {
                                                    _createCart({
                                                      "id": product.id,
                                                      "name": product.name,
                                                      "category":
                                                          product.category,
                                                      "imageUrl":
                                                          product.imageUrl,
                                                      "price": product.price,
                                                      "qty": 1,
                                                      "sizes":
                                                          productNotifier.sizes
                                                    });
                                                    productNotifier.sizes
                                                        .clear();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              }
            }));
  }
}
