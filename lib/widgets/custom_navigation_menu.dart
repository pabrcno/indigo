import 'package:flutter/material.dart';
import 'package:indigo/widgets/custom_app_bar.dart';

class CustomNavigationRail extends StatefulWidget {
  const CustomNavigationRail({super.key});

  @override
  _CustomNavigationRailState createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  int _selectedIndex = 1; // Default selected index for "Usuarios"

  final List<NavigationRailDestination> _menuOptions = [
    const NavigationRailDestination(
      icon: Icon(Icons.home),
      selectedIcon: Icon(
        Icons.home,
        color: Color(0xFF4263EB),
      ),
      label: Text('Inicio'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.people),
      selectedIcon: Icon(
        Icons.people,
        color: Color(0xFF4263EB),
      ),
      label: Text('Usuarios'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.calendar_today),
      selectedIcon: Icon(
        Icons.calendar_today,
        color: Color(0xFF4263EB),
      ),
      label: Text('Planes'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.person),
      selectedIcon: Icon(
        Icons.person,
        color: Color(0xFF4263EB),
      ),
      label: Text('Perfil'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.settings),
      selectedIcon: Icon(
        Icons.settings,
        color: Color(0xFF4263EB),
      ),
      label: Text('Configuracion'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.email),
      selectedIcon: Icon(
        Icons.email,
        color: Color(0xFF4263EB),
      ),
      label: Text('Correos'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.chat),
      selectedIcon: Icon(
        Icons.chat,
        color: Color(0xFF4263EB),
      ),
      label: Text('Chats'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      appBar: const CustomAppBar(
        userAvatarUrl:
            'https://example.com/avatar.png', // Replace with your URL
      ),
      body: Row(
        children: [
          if (isWideScreen)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/indigo_logo.png', // Replace with your logo path
                      height: 40,
                    ),
                  ],
                ),
              ),
              backgroundColor: const Color(0xFF4263EB),
              selectedIconTheme: const IconThemeData(color: Color(0xFF4263EB)),
              unselectedIconTheme: const IconThemeData(color: Colors.white),
              selectedLabelTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelTextStyle: const TextStyle(
                color: Colors.white,
              ),
              destinations: _menuOptions,
            ),
        ],
      ),
      bottomNavigationBar: !isWideScreen
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              fixedColor: const Color(0xFF4263EB),
              unselectedItemColor: const Color(0xFF4263EB),
              items: _menuOptions
                  .map(
                    (destination) => BottomNavigationBarItem(
                      icon: destination.icon,
                      label: "",
                    ),
                  )
                  .toList(),
            )
          : null,
    );
  }
}
