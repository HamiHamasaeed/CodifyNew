import 'package:cached_network_image/cached_network_image.dart';
import 'package:codifyecommerce/controllers/product_provider.dart';
import 'package:codifyecommerce/views/shared/app_style.dart';
import 'package:codifyecommerce/views/ui/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../../controllers/favoirte_provider.dart';
import '../../models/sensors_model.dart';
import '../shared/add_to_cart.dart';

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
  // final _favBox = Hive.box('fav_box');

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
                            padding: const EdgeInsets.only(bottom: 10),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width: MediaQuery.of(context).size.width,
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.39,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: const Color.fromARGB(
                                                255, 240, 233, 233),
                                            child: CachedNetworkImage(
                                              imageUrl: product.imageUrl[index],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.105,
                                            right: 15,
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
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
                                  bottom: 30,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.645,
                                      width: MediaQuery.of(context).size.width,
                                      color: const Color(0xeef2f2f2),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: appstyle(35, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  product.category,
                                                  style: appstyle(
                                                      20,
                                                      Colors.blueGrey,
                                                      FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  width: 20,
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
                                                      const Icon(Icons.star,
                                                          size: 18,
                                                          color: Colors.black),
                                                  onRatingUpdate: (rating) {},
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$${product.price}",
                                                  style: appstyle(
                                                      26,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Colors",
                                                      style: appstyle(
                                                          18,
                                                          Colors.black,
                                                          FontWeight.w500),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.blue,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Select Sizes",
                                                      style: appstyle(
                                                          20,
                                                          Colors.black,
                                                          FontWeight.w600),
                                                    ),
                                                    const SizedBox(width: 20),
                                                    Text(
                                                      "View size guide",
                                                      style: appstyle(
                                                          20,
                                                          Colors.grey,
                                                          FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                SizedBox(
                                                  height: 40,
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
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: ChoiceChip(
                                                            showCheckmark:
                                                                false,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1,
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
                                                              print(
                                                                  productNotifier
                                                                      .sizes);
                                                              productNotifier
                                                                  .toggleCheck(
                                                                      index);
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            const Divider(
                                              indent: 10,
                                              endIndent: 10,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Text(
                                                product.title,
                                                style: appstyle(
                                                    26,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
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
                                            const SizedBox(height: 10),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12),
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
