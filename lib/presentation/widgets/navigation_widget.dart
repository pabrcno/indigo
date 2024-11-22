import 'package:flutter/material.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:indigo/presentation/constants/colors.dart';
import 'package:indigo/presentation/screens/home_screen.dart';
import 'package:indigo/presentation/screens/patient_profile_screen.dart';
import 'package:indigo/presentation/screens/patients_screen.dart';
import 'package:indigo/presentation/widgets/custom_app_bar.dart';
import 'package:indigo/presentation/widgets/paddings.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int _selectedIndex = 0;

  final List<_MenuOption> _menuOptions = [
    const _MenuOption(icon: Icon(Icons.home), label: 'Inicio'),
    const _MenuOption(icon: Icon(Icons.people), label: 'Pacientes'),
    const _MenuOption(icon: Icon(Icons.calendar_today), label: 'Planes'),
    const _MenuOption(icon: Icon(Icons.person), label: 'Perfil'),
    const _MenuOption(icon: Icon(Icons.settings), label: 'Configuracion'),
    const _MenuOption(icon: Icon(Icons.email), label: 'Correos'),
    const _MenuOption(icon: Icon(Icons.chat), label: 'Chats'),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      appBar: const CustomAppBar(
        userAvatarUrl: 'assets/images/coach.png',
        key: Key('customAppBar'),
      ),
      body: Row(
        children: [
          if (isWideScreen)
            NavigationRail(
              key: const Key('navigationRail'),
              backgroundColor: darkPurple,
              indicatorColor: Colors.white,
              unselectedLabelTextStyle: const TextStyle(color: Colors.white),
              selectedLabelTextStyle: const TextStyle(color: Colors.white),
              selectedIconTheme: const IconThemeData(color: darkPurple),
              unselectedIconTheme: const IconThemeData(color: Colors.white),
              selectedIndex: _selectedIndex,
              leading: Padding(
                padding: kPadding,
                child: Image.asset(
                  "assets/images/indigo_logo.png",
                  height: 35,
                  key: const Key('navigationRailLogo'),
                ),
              ),
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: _menuOptions
                  .map((option) => NavigationRailDestination(
                        icon: option.icon,
                        label: Text(option.label),
                      ))
                  .toList(),
            ),
          Expanded(
            child: IndexedStack(
              key: const Key('indexedStack'),
              index: _selectedIndex,
              children: [
                const HomeScreen(key: Key('homeScreen')),
                _buildPatientsNavigator(),
                const Center(key: Key('planesScreen'), child: Text('Planes')),
                const Center(key: Key('perfilScreen'), child: Text('Perfil')),
                const Center(
                    key: Key('configuracionScreen'),
                    child: Text('Configuracion')),
                const Center(key: Key('correosScreen'), child: Text('Correos')),
                const Center(key: Key('chatsScreen'), child: Text('Chats')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: !isWideScreen
          ? BottomNavigationBar(
              key: const Key('bottomNavigationBar'),
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedItemColor: darkPurple,
              unselectedItemColor: darkPurple.withOpacity(0.6),
              items: _menuOptions
                  .map(
                    (option) => BottomNavigationBarItem(
                      icon: option.icon,
                      label: option.label,
                    ),
                  )
                  .toList(),
            )
          : null,
    );
  }

  Widget _buildPatientsNavigator() {
    return Navigator(
      key: const Key('patientsNavigator'),
      onGenerateRoute: (settings) {
        Widget page;

        if (settings.name == '/patientProfile') {
          final args = settings.arguments as Patient;
          page = PatientProfileScreen(patient: args);
        } else {
          page = const PatientsScreen(); // Default route
        }

        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}

class _MenuOption {
  final Icon icon;
  final String label;

  const _MenuOption({required this.icon, required this.label});
}
