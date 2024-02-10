import 'package:cached_network_image/cached_network_image.dart';
import 'package:codifyecommerce/views/shared/app_style.dart';
import 'package:codifyecommerce/views/shared/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price});
  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.only(top: 12.h),
                height: 75.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: widget.name,
                      style: appstyleWithHeight(
                          20, Colors.black, FontWeight.w700, 1),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    ReusableText(
                      text: widget.price,
                      style: appstyleWithHeight(
                          20, Colors.black, FontWeight.w500, 1),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
