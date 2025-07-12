import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/bloc/bloc_exports.dart';
import 'package:parent_wish/ui/screens/index.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/utils/routers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    _HomeTab(),
    // _TaskListTab(),
    const AddTaskScreen(),
    _StatisticsTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          print("Navigating to splash screen...");
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.splash,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.blue500,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 24.w),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? AppColors.blue500 : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'assets/icons/task-list.png',
                  width: 22.w,
                  height: 22.h,
                  fit: BoxFit.contain,
                ),
              ),
              label: 'Task List',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? AppColors.blue500 : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'assets/icons/charts.png',
                  width: 22.w,
                  height: 22.h,
                  fit: BoxFit.contain,
                ),
              ),
              label: 'Statistics',
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy Home tab
class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            'Home...',
            style: Theme.of(context).textTheme.headline6,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for Task List tab
class _TaskListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Task List',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

// Placeholder for Statistics tab
class _StatisticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Statistics / Charts',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
