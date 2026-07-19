import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'tasks_screen.dart';
import 'calendar_screen.dart';
import 'timer_screen.dart';
import 'subjects_screen.dart';
import 'analytics_screen.dart';
import 'submissions_screen.dart';

import '../widgets/common_profile_avatar.dart';

import '../l10n/app_localizations.dart';

class MainNavigationScreen
    extends StatefulWidget {

  const MainNavigationScreen(
      {super.key});

  @override
  State<MainNavigationScreen>
      createState() =>

          _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int selectedIndex = 0;

  final List<Widget> screens = [

    const DashboardScreen(),

    const TasksScreen(),

    const CalendarScreen(),

    const TimerScreen(),

    const SubjectsScreen(),

    const AnalyticsScreen(),

    const SubmissionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final lang =
        AppLocalizations.of(context);

    bool isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(

      appBar: AppBar(

        title: Text(

          selectedIndex == 0
              ? lang.translate('home')

          : selectedIndex == 1
              ? lang.translate('tasks')

          : selectedIndex == 2
              ? lang.translate('calendar')

          : selectedIndex == 3
              ? lang.translate('study_timer')

          : selectedIndex == 4
              ? lang.translate('subjects')

          : selectedIndex == 5
              ? lang.translate('analytics')

          : lang.translate('submissions'),
        ),

        actions: const [

          CommonProfileAvatar(),
        ],
      ),

      drawer: Drawer(

        child: Column(

          children: [

            const DrawerHeader(

              decoration:
                  BoxDecoration(
                color: Colors.blue,
              ),

              child: Align(

                alignment:
                    Alignment.centerLeft,

                child: Text(

                  "EduTrack",

                  style: TextStyle(

                    color: Colors.white,

                    fontSize: 24,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            buildDrawerItem(

              icon: Icons.home,

              title:
                  lang.translate('home'),

              index: 0,

              isDark: isDark,
            ),

            buildDrawerItem(

              icon: Icons.task_alt,

              title:
                  lang.translate('tasks'),

              index: 1,

              isDark: isDark,
            ),

            buildDrawerItem(

              icon:
                  Icons.calendar_month,

              title:
                  lang.translate('calendar'),

              index: 2,

              isDark: isDark,
            ),

            buildDrawerItem(

              icon: Icons.timer,

              title:
                  lang.translate(
                      'study_timer'),

              index: 3,

              isDark: isDark,
            ),

            buildDrawerItem(

              icon: Icons.menu_book,

              title:
                  lang.translate('subjects'),

              index: 4,

              isDark: isDark,
            ),

            buildDrawerItem(

              icon: Icons.bar_chart,

              title:
                  lang.translate('analytics'),

              index: 5,

              isDark: isDark,
            ),

            buildDrawerItem(

              icon:
                  Icons.assignment,

              title:
                  lang.translate(
                      'submissions'),

              index: 6,

              isDark: isDark,
            ),
          ],
        ),
      ),

      body:
          screens[selectedIndex],
    );
  }

  Widget buildDrawerItem({

    required IconData icon,

    required String title,

    required int index,

    required bool isDark,
  }) {

    bool selected =
        selectedIndex == index;

    return ListTile(

      leading: Icon(

        icon,

        color:

            selected

                ? Colors.blue

                : isDark
                    ? Colors.white
                    : Colors.black,
      ),

      title: Text(

        title,

        style: TextStyle(

          color:

              selected

                  ? Colors.blue

                  : isDark
                      ? Colors.white
                      : Colors.black,

          fontWeight:

              selected

                  ? FontWeight.bold

                  : FontWeight.normal,
        ),
      ),

      selected: selected,

      selectedTileColor:

          Colors.blue.withOpacity(0.12),

      onTap: () {

        setState(() {

          selectedIndex = index;
        });

        Navigator.pop(context);
      },
    );
  }
}