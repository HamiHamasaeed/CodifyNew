import 'export_packages.dart';

class NewArduino extends StatelessWidget {
  const NewArduino({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 0.8,
              offset: Offset(0, 1))
        ],
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(16.h)),
      ),
      height: 100.h,
      width: 104.w,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
      ),
    );
  }
}
