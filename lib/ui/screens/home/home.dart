import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/screens/home/content/home_content.dart';
import 'package:podlove_flutter/ui/screens/home/content/matches_content.dart';
import 'package:podlove_flutter/ui/screens/home/content/notification_content.dart';
import 'package:podlove_flutter/ui/screens/home/content/profile_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      Consumer(
        builder: (context, ref, child) {
          return HomeContent(
            onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
          );
        },
      ),
      MatchesContent(),
      NotificationContent(),
      ProfileContent(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra;
    if (extra is int) {
      setState(() {
        _selectedIndex = extra;
      });
    }
  }

  Future<void> _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToPage(String routeName) {
    context.push(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Image.asset("assets/images/podLove.png"),
              ),
              _buildDrawerItem(
                icon: "assets/images/quiz.png",
                title: 'FAQs',
                routeName: RouterPath.faqs,
              ),
              _buildDrawerItem(
                icon: "assets/images/support.png",
                title: 'Help Center',
                routeName: RouterPath.help,
              ),
              _buildDrawerItem(
                icon: "assets/images/encrypted.png",
                title: 'Terms & Conditions',
                routeName: RouterPath.terms,
              ),
              _buildDrawerItem(
                icon: "assets/images/encrypted.png",
                title: 'Privacy Policy',
                routeName: RouterPath.privacy,
              ),
              _buildDrawerItem(
                icon: "assets/images/settings.png",
                title: 'Settings',
                routeName: RouterPath.settings,
              ),
              _buildDrawerItem(
                icon: "assets/images/quiz.png",
                title: 'Surveys',
                routeName: RouterPath.survey,
              ),
              const Expanded(child: SizedBox()),
              ListTile(
                leading: Image.asset("assets/images/logout.png"),
                title: const Text('Logout'),
                onTap: () async {
                  await _logOut()
                      .whenComplete(() => context.go(RouterPath.signIn));
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _buildBottomNavItems(),
        selectedItemColor: const Color.fromARGB(255, 255, 161, 117),
        unselectedItemColor: const Color.fromARGB(255, 118, 118, 118),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  ListTile _buildDrawerItem({
    required String icon,
    required String title,
    required String routeName,
  }) {
    return ListTile(
      leading: Image.asset(icon),
      title: Text(title),
      onTap: () => _navigateToPage(routeName),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems() {
    final navIcons = [
      "home-icon.png",
      "match-icon.png",
      "bell-icon.png",
      "avatar-icon.png"
    ];
    final navLabels = ['Home', 'Matches', 'Notifications', 'Profile'];

    return List.generate(
      4,
      (index) => BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/${navIcons[index]}"),
          color:
              _selectedIndex == index ? AppColors.accent : AppColors.mutedText,
        ),
        label: navLabels[index],
      ),
    );
  }
}
