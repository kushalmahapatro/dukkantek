// ignore_for_file: prefer_is_empty

import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/profile/interactor/profile_interactor.dart';

class ProfileView extends HookConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = '';
    List<String> parts = userName.split(" ");
    if (parts.isNotEmpty) {
      if (parts.length >= 1) {
        name = parts[0].substring(0, 1) + parts[1].substring(0, 1);
      } else {
        name = parts[0].substring(0, 1);
      }
    }
    return Scaffold(
      backgroundColor: DTColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DTColors.white,
        title: logo(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          nameLogo(name).circularWidget(size: 100).marginAll(20),
          "Personal Information"
              .text
              .bodyLarge(color: DTColors.secondary)
              .start
              .make(),
          infoWidget("Name", userName, Icons.person),
          infoWidget("Email", userEmail, Icons.mail),
          const Spacer(),
          "Logout"
              .ctaActive(ProfileInteractor.onLogoutClicked(context))
              .paddingSymmetric(vertical: 20)
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }

  Container nameLogo(String name) {
    return Container(
      height: 100,
      width: 100,
      color: DTColors.primary,
      child: name.text.headline(color: DTColors.white).make().centre,
    );
  }

  Widget logo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DtAssets.logo.assetImage(height: 25),
        DtAssets.logoText.assetImage(height: 20)
      ],
    );
  }

  Widget infoWidget(String title, String text, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: DTColors.secondary,
              size: 35,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.text.bodySmall(color: DTColors.secondary).make(),
                text.text.bodyLarge().make()
              ],
            )
          ],
        ).paddingSymmetric(vertical: 10),
        Container(
          height: 2,
          color: DTColors.grey.withOpacity(0.4),
        ),
      ],
    );
  }
}
