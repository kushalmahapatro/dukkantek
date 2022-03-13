import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/screens/home/view/home_view.dart';
import 'package:dukkantek/screens/profile/view/profile_view.dart';

class LaunchView extends HookConsumerWidget {
  const LaunchView({this.splashRef, Key? key}) : super(key: key);

  final WidgetRef? splashRef;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = useState<int>(0);

    List<Tabs> tabs = <Tabs>[];
    tabs.add(Tabs(Icons.home, "Home", DTColors.primary));
    tabs.add(Tabs(Icons.search, "Search", DTColors.primary));
    tabs.add(Tabs(Icons.info_outline_rounded, "About us", DTColors.primary));
    tabs.add(Tabs(Icons.person, "Profile", DTColors.primary));

    return Scaffold(
      body: SafeArea(
          child: IndexedStack(
        index: index.value,
        children: const <Widget>[
          HomeView(),
          HomeView(),
          HomeView(),
          ProfileView()
        ],
      )),
      bottomNavigationBar: CubertoBottomBar(
        tabColor: DTColors.primary,
        inactiveIconColor: DTColors.primary,
        tabStyle: CubertoTabStyle.STYLE_NORMAL,
        selectedTab: index.value,
        drawer: const CubertoDrawer(style: CubertoDrawerStyle.NO_DRAWER),
        tabs: tabs
            .map((value) => TabData(
                  key: Key(value.title),
                  iconData: value.icon,
                  title: value.title,
                  tabColor: value.color,
                ))
            .toList(),
        onTabChangedListener: (position, title, color) {
          index.value = position;
        },
      ),
    );
  }
}

class Tabs {
  final IconData icon;
  final String title;
  final Color color;
  final Gradient? gradient;

  Tabs(this.icon, this.title, this.color, {this.gradient});
}
