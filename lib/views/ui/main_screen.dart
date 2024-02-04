// ignore_for_file: unrelated_type_equality_checks

import 'package:codifyecommerce/controllers/main_screen_provider.dart';
import 'package:codifyecommerce/views/ui/cart_page.dart';
import 'package:codifyecommerce/views/ui/home_page.dart';
import 'package:codifyecommerce/views/ui/profile.dart';
import 'package:codifyecommerce/views/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/codify_bottom_nav.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const HomePage(),
    CartPage(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xffe2e2e2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const CodifyBottomNav(),
        );
      },
    );
  }
}
