import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/screens/place_list/place_list_screen.dart';
import 'package:interesting_places/presentation/screens/place_map/place_map_screen.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColor.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.transparent,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: SvgPicture.asset(AppImages.listFull),
            icon: SvgPicture.asset(AppImages.list),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(AppImages.mapFull),
            icon: SvgPicture.asset(AppImages.map),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(AppImages.heart),
            icon: SvgPicture.asset(AppImages.heart),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(AppImages.settings),
            icon: SvgPicture.asset(AppImages.settings),
            label: '',
          ),
        ],
      ),
      body: <Widget>[
        const PlaceListScreen(),
        const PlaceMapScreen(),
        Container(),
        Container(),
      ][currentPageIndex],
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColor.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.listFull),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.map),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.heart),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.settings),
          label: '',
        ),
      ],
    );
  }
}
*/
