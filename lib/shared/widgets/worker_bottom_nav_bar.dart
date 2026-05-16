import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/routes/app_routes.dart';
import 'package:handyph_app/core/theme/app_colors.dart';

/// Worker-specific floating bottom navigation bar.
/// Same UI/UX as [AppBottomNavBar] but routes to worker screens.
class WorkerBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const WorkerBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textTertiary,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            if (index == currentIndex) return;
            switch (index) {
              case 0:
                context.go(AppRoutes.workerHome);
                break;
              case 1:
                context.go(AppRoutes.workerDashboard);
                break;
              case 2:
                context.go(AppRoutes.workerDiscovery);
                break;
              case 3:
                context.go(AppRoutes.workerProfile);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: 'My Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Discovery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
