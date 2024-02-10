import 'package:flutter_slidable/flutter_slidable.dart';
import '../shared/export.dart';
import '../shared/export_packages.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCart();
    return Scaffold(
      backgroundColor: const Color(0xffe2e2e2),
      body: cartProvider.cart.isEmpty
          ? SafeArea(
              child: Center(
                  child: Image.asset(
              'assets/images/empty.png',
              fit: BoxFit.fill,
            )))
          : Padding(
              padding: EdgeInsets.all(12.h),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                          },
                          child: const Icon(
                            Ionicons.close,
                            color: Colors.black,
                          )),
                      ReusableText(
                        text: "My Cart",
                        style: appstyle(36, Colors.black, FontWeight.bold),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 527.h,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: cartProvider.cart.length,
                            itemBuilder: (context, index) {
                              final data = cartProvider.cart[index];
                              return Padding(
                                padding: EdgeInsets.all(8.h),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Slidable(
                                    key: const ValueKey(0),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            cartProvider
                                                .deleteCart(data['key']);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainScreen()));
                                          },
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: "Delete",
                                        ),
                                      ],
                                    ),
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
                                                  imageUrl: data['imageUrl'][0],
                                                  width: 70.w,
                                                  height: 70.h,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 12.h, left: 20.w),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ReusableText(
                                                      text: data['name'],
                                                      style: appstyle(
                                                          16,
                                                          Colors.black,
                                                          FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    ReusableText(
                                                      text: data['category'],
                                                      style: appstyle(
                                                          14,
                                                          Colors.grey,
                                                          FontWeight.w600),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Row(
                                                      children: [
                                                        ReusableText(
                                                          text: data['price'],
                                                          style: appstyle(
                                                              20,
                                                              Colors.black,
                                                              FontWeight.w600),
                                                        ),
                                                        SizedBox(width: 40.w),
                                                        ReusableText(
                                                            text: "Size",
                                                            style: appstyle(
                                                                18,
                                                                Colors.grey,
                                                                FontWeight
                                                                    .w600)),
                                                        SizedBox(width: 15.w),
                                                        Text(
                                                          "${data['sizes']}",
                                                          style: appstyle(
                                                              18,
                                                              Colors.grey,
                                                              FontWeight.w600),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.h),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16)),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          cartProvider
                                                              .increament();
                                                        },
                                                        child: Icon(
                                                          Ionicons.add_circle,
                                                          size: 25.h,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      ReusableText(
                                                        text: cartProvider
                                                            .counter
                                                            .toString(),
                                                        style: appstyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          cartProvider
                                                              .decreament();
                                                        },
                                                        child: Icon(
                                                          Ionicons
                                                              .remove_circle,
                                                          size: 25.h,
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckOutButton(
                      label: "Tap To Checkout",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text(
                              "Your Total is: \$99\nProcced the process?",
                              style:
                                  appstyle(18, Colors.black, FontWeight.bold),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: ReusableText(
                                    text: "Cancel",
                                    style: appstyle(
                                        14, Colors.red, FontWeight.bold),
                                  )),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                  );
                                  cartProvider.deleteAllCart();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()),
                                    (route) => false,
                                  );
                                },
                                child: Text("Accept",
                                    style: appstyle(
                                        14, Colors.green, FontWeight.bold)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
