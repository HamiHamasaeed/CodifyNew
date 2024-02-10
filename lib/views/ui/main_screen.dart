// ignore_for_file: unrelated_type_equality_checks
import '../shared/export.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    FavoritePage(),
    CartPage(),
    Profile()
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
