import 'package:flutter/material.dart';
import 'package:indigo/models/patient/patient.dart';
import 'package:indigo/screens/home_screen.dart';
import 'package:indigo/screens/patient_profile_screen.dart';
import 'package:indigo/screens/patients_screen.dart';
import 'package:indigo/widgets/custom_app_bar.dart';
import 'package:indigo/widgets/paddings.dart';

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
        userAvatarUrl: 'https://example.com/avatar.png',
      ),
      body: Row(
        children: [
          if (isWideScreen)
            NavigationRail(
              backgroundColor: const Color(0xFF4263EB),
              indicatorColor: Colors.white,
              unselectedLabelTextStyle: const TextStyle(color: Colors.white),
              selectedLabelTextStyle: const TextStyle(color: Colors.white),
              selectedIconTheme: const IconThemeData(color: Color(0xFF4263EB)),
              unselectedIconTheme: const IconThemeData(color: Colors.white),
              selectedIndex: _selectedIndex,
              leading: Padding(
                  padding: kPadding,
                  child: Image.asset(
                    "assets/images/indigo_logo.png",
                    height: 35,
                  )),
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
              index: _selectedIndex,
              children: [
                const HomeScreen(),
                _buildPatientsNavigator(), // Patients section with inner navigation
                const Center(child: Text('Planes')),
                const Center(child: Text('Perfil')),
                const Center(child: Text('Configuracion')),
                const Center(child: Text('Correos')),
                const Center(child: Text('Chats')),
              ],
            ),
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
              selectedItemColor: const Color(0xFF4263EB),
              unselectedItemColor: const Color(0xFF4263EB).withOpacity(0.6),
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
