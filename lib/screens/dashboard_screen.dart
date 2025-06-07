import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:flutter_tap2025/utils/global_values.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarX(
        headerBuilder: (context, extended) {
          return const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/105646626?v=4'),
            ),
            accountName: Text('Jesus Pacheco'), 
            accountEmail: Text('22030874@itcelaya.edu.mx')
          );
        },
        extendedTheme: const SidebarXTheme(
          width: 250
        ),
        controller: SidebarXController(selectedIndex: 0, extended: true),
        items: [
          SidebarXItem(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/api');
            },
            icon: Icons.movie, label: 'Popular Movies'
          ),
          SidebarXItem(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
            icon: Icons.home, label: 'Shoe App'
          ),
          SidebarXItem(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/favorites');
            },
            icon: Icons.favorite, label: 'Favorites'
          ),
          SidebarXItem(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/weather');
            },
            icon: Icons.air, label: 'weather'
          )
        ],
      ),
      appBar: AppBar(
        title: Text('Panel de control'),
      ),
      body: HawkFabMenu(
        icon: AnimatedIcons.menu_arrow,
        body: const Center(
          child: Text('Your content here :)'),
        ), 
        items: [
          HawkFabMenuItem(
            label: 'Theme Light', 
            ontap: () => GlobalValues.themeMode.value = 1, 
            icon: const Icon(Icons.light_mode)
          ),
          HawkFabMenuItem(
            label: 'Theme Dark', 
            ontap: () => GlobalValues.themeMode.value = 0, 
            icon: const Icon(Icons.dark_mode)
          ),
          HawkFabMenuItem(
            label: 'Theme Warm', 
            ontap: () => GlobalValues.themeMode.value = 2, 
            icon: const Icon(Icons.hot_tub)
          )
        ]
      )
    );
  }
}