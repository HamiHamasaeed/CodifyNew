import 'export.dart';

class TeamInfo extends StatelessWidget {
  const TeamInfo({
    super.key,
    required this.picUrl,
    required this.name,
    required this.titlePosition,
  });
  final String picUrl;
  final String name;
  final String titlePosition;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              picUrl,
              height: 40.h,
            ),
          )
        ]),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: appstyle(8, Colors.black, FontWeight.w700),
              ),
              Text(
                titlePosition,
                style: appstyle(7, Colors.blueGrey, FontWeight.w500),
              ),
            ],
          ),
        )
      ],
    );
  }
}
