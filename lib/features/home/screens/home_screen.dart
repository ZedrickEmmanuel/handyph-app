import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/routes/app_routes.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/features/home/data/mock_home_data.dart';
import 'package:handyph_app/features/home/widgets/upcoming_job_card.dart';
import 'package:handyph_app/features/home/widgets/category_item.dart';
import 'package:handyph_app/features/home/widgets/top_rated_pro_card.dart';
import 'package:handyph_app/shared/widgets/app_bottom_nav_bar.dart';
import 'package:handyph_app/shared/widgets/skeletons/home_skeleton_screen.dart';

/// Homeowner — Home Dashboard Screen
///
/// Main screen after login showing:
///   - Greeting + search bar
///   - Upcoming job card
///   - Service categories
///   - Top rated pros (horizontal scroll)
///   - Bottom navigation bar
///
/// Demonstrates loading → content transition with skeleton screens.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate initial data fetch
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final upcomingJob = MockHomeData.upcomingJob;
    final categories = MockHomeData.categories;
    final topPros = MockHomeData.topRatedPros;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      extendBody: true, // Allow body to flow under the floating nav bar

      // ── App Bar ──────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        titleSpacing: 20,
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Row(
            children: [
              // Profile avatar
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primarySurface,
                child: const Icon(
                  Icons.person_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const Spacer(),
              // HandyPH logo
              Image.asset(
                'assets/logo/handyPH_logo.png',
                height: 24,
                fit: BoxFit.contain,
              ),
              const Spacer(),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 8),
            child: IconButton(
              icon: const Icon(
                Icons.search_rounded,
                color: AppColors.textPrimary,
              ),
              onPressed: () => context.push(AppRoutes.discovery),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),

      // ── Body ─────────────────────────────────────────────
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _isLoading
            ? Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 90,
                ),
                key: const ValueKey('skeleton'),
                child: const HomeSkeletonScreen(),
              )
            : SingleChildScrollView(
        key: const ValueKey('content'),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 90,
          bottom: 100, // Extra padding for the floating nav bar
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Greeting ──────────────────────────────
                  Text(
                    'Magandang araw!',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'What service do you need today?',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Search Bar ────────────────────────────
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.discovery),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.divider,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: AppColors.textTertiary,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Search for plumbers, electricians..',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Upcoming Job ──────────────────────────
                  Text(
                    'Upcoming Job',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  UpcomingJobCard(
                    title: upcomingJob['title'] as String,
                    date: upcomingJob['date'] as String,
                    workerName: upcomingJob['workerName'] as String,
                    category: upcomingJob['category'] as String,
                    onTap: () {
                      // Navigate to job details
                    },
                  ),
                  const SizedBox(height: 28),

                  // ── Categories ────────────────────────────
                  Text(
                    'Categories',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: categories.map((cat) {
                      return CategoryItem(
                        name: cat['name'] as String,
                        iconType: cat['icon'] as String,
                        onTap: () => context.push(AppRoutes.discovery),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),

                  // ── Top Rated Pros Header ─────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Rated Pros',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.discovery),
                        child: Text(
                          'See All',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // ── Top Rated Pros Scroll ─────────────────────
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: topPros.length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final pro = topPros[index];
                  return TopRatedProCard(
                    name: pro['name'] as String,
                    title: pro['title'] as String,
                    rating: pro['rating'] as double,
                    reviews: pro['reviews'] as int,
                    isVerified: pro['isVerified'] as bool,
                    onBookNow: () => context.push(AppRoutes.booking),
                    onTap: () => context.push(AppRoutes.viewWorkerProfile),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      ),

      // ── Bottom Navigation ────────────────────────────────
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}
