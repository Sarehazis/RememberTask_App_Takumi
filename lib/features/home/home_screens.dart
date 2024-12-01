import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_task/features/component/forum_page.dart';
import 'package:re_task/features/component/home_page.dart';
import 'package:re_task/features/component/profile_pages.dart';
import 'package:re_task/features/component/statistic_page.dart';
import 'package:re_task/features/component/widget/task_form.dart';
import 'package:re_task/features/task/bloc/task_bloc.dart';
import 'package:re_task/features/task/data/task_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart'; // Untuk navigasi logout

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          BlocProvider(
            create: (context) =>
                TaskBloc(TaskRepository())..add(FetchTasksEvent()),
            child: const HomePage(),
          ),
          const ProfilePage(),
          const ForumPage(),
          const StatisticsPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset:
            const Offset(0, -10), // Angka negatif di Y untuk menaikkan tombol
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskForm()),
            ).then((_) {
              context.read<TaskBloc>().add(FetchTasksEvent());
            });
          },
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shadowColor: Colors.indigoAccent,
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 6,
            ),
            minimumSize: const Size(40, 40),
          ),
          child: const Icon(
            Icons.add,
            size: 14,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: buildNavbar(),
    );
  }

  Container buildNavbar() {
    return Container(
      height: 80.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, .3),
            color: Colors.grey.withOpacity(.23),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: Icons.home_filled,
            label: "Home",
            isSelected: index == 0,
            onTap: () => setState(() => index = 0),
          ),
          _buildNavItem(
            icon: Icons.person,
            label: "Profile",
            isSelected: index == 1,
            onTap: () => setState(() => index = 1),
          ),
          _buildNavItem(
            icon: Icons.message,
            label: "Message",
            isSelected: index == 2,
            onTap: () => setState(() => index = 2),
          ),
          _buildNavItem(
            icon: Icons.bar_chart, // Ikon untuk statistik
            label: "Stats",
            isSelected: index == 3,
            onTap: () => setState(() => index = 3),
          ),
          _buildNavItem(
            icon: Icons.logout,
            label: "Logout",
            isSelected: false,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Future.delayed(const Duration(milliseconds: 600), () {
                context.go('/login');
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected ? Colors.blueAccent : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blueAccent : Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
