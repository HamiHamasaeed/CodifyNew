import 'package:codifyecommerce/controllers/favoirte_provider.dart';
import 'package:codifyecommerce/views/shared/app_style.dart';
import 'package:codifyecommerce/views/shared/reusable_text.dart';
import 'package:codifyecommerce/views/ui/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ProductCart extends StatefulWidget {
  const ProductCart(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.imageUrl});

  final String price;
  final String category;
  final String id;
  final String name;
  final String imageUrl;

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier =
        Provider.of<FavoriteNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();

    bool selected = true;
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0, 20.w, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: 325.h,
          width: 225.w,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 186.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.imageUrl))),
                  ),
                  Positioned(
                      right: 10.w,
                      top: 10.h,
                      child: GestureDetector(
                          onTap: () async {
                            if (favoritesNotifier.ids.contains(widget.id)) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FavoritePage()));
                            } else {
                              favoritesNotifier.createFav({
                                "id": widget.id,
                                "name": widget.name,
                                "category": widget.category,
                                "price": widget.price,
                                "imageUrl": widget.imageUrl
                              });
                            }
                            setState(() {});
                          },
                          child: favoritesNotifier.ids.contains(widget.id)
                              ? const Icon(Ionicons.heart)
                              : const Icon(Ionicons.heart_outline)))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: widget.name,
                      style: appstyleWithHeight(
                          36, Colors.black, FontWeight.bold, 1.1),
                    ),
                    ReusableText(
                      text: widget.category,
                      style: appstyleWithHeight(
                          18, Colors.blueGrey, FontWeight.bold, 1.5),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: widget.price,
                        style: appstyle(25, Colors.black, FontWeight.w600)),
                    Row(
                      children: [
                        ReusableText(
                            text: "Colors",
                            style: appstyle(16, Colors.grey, FontWeight.w500)),
                        ChoiceChip(
                          label: Container(),
                          selected: selected,
                          shape: const CircleBorder(),
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
