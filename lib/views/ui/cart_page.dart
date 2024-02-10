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
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                          },
                          child: const Icon(
                            Ionicons.close,
                            color: Colors.black,
                          )),
                      Text(
                        "My Cart",
                        style: appstyle(36, Colors.black, FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: cartProvider.cart.length,
                            itemBuilder: (context, index) {
                              final data = cartProvider.cart[index];
                              return Padding(
                                padding: const EdgeInsets.all(8),
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                      width: MediaQuery.of(context).size.width,
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
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: CachedNetworkImage(
                                                  imageUrl: data['imageUrl'][0],
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12, left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data['name'],
                                                      style: appstyle(
                                                          16,
                                                          Colors.black,
                                                          FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      data['category'],
                                                      style: appstyle(
                                                          14,
                                                          Colors.grey,
                                                          FontWeight.w600),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          data['price'],
                                                          style: appstyle(
                                                              20,
                                                              Colors.black,
                                                              FontWeight.w600),
                                                        ),
                                                        const SizedBox(
                                                            width: 40),
                                                        Text("Size",
                                                            style: appstyle(
                                                                18,
                                                                Colors.grey,
                                                                FontWeight
                                                                    .w600)),
                                                        const SizedBox(
                                                            width: 15),
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
                                                padding:
                                                    const EdgeInsets.all(8),
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
                                                        child: const Icon(
                                                          Ionicons.add_circle,
                                                          size: 25,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        cartProvider.counter
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
                                                        child: const Icon(
                                                          Ionicons
                                                              .remove_circle,
                                                          size: 25,
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
                                  child: Text(
                                    "Cancel",
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
