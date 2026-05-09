import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handyph_app/core/theme/app_colors.dart';
import 'package:handyph_app/core/theme/app_typography.dart';
import 'package:handyph_app/features/discovery/data/mock_discovery_data.dart';
import 'package:handyph_app/features/discovery/widgets/worker_card.dart';
import 'package:handyph_app/shared/widgets/app_bottom_nav_bar.dart';

/// Discovery — Find Professionals Screen
///
/// Allows homeowners to search and browse workers with:
///   - Search bar
///   - Filter chips (Filters, Rating 4+, Verified Only)
///   - Scrollable list of worker cards
///   - Floating rounded bottom navigation bar
class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  final Set<String> _activeFilters = {};

  @override
  Widget build(BuildContext context) {
    final workers = MockDiscoveryData.workers;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,

      // ── App Bar ──────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'Find Professionals',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),

      // ── Body ─────────────────────────────────────────────
      body: Column(
        children: [
          // ── Search + Filters (fixed top) ─────────────────
          Container(
            color: AppColors.background,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Column(
              children: [
                // Search bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider, width: 1),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppColors.textTertiary,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Search by service or barangay',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Filter chips
                Row(
                  children: [
                    // Filters button
                    _buildFilterChip(
                      label: 'Filters',
                      icon: Icons.tune_rounded,
                      isActive: false,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),

                    // Dynamic filter chips
                    ...MockDiscoveryData.filterChips.map((filter) {
                      final isActive = _activeFilters.contains(filter);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildFilterChip(
                          label: filter,
                          isActive: isActive,
                          onTap: () {
                            setState(() {
                              if (isActive) {
                                _activeFilters.remove(filter);
                              } else {
                                _activeFilters.add(filter);
                              }
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),

          // ── Worker List ──────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
              itemCount: workers.length,
              separatorBuilder: (_, _) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final worker = workers[index];
                return WorkerCard(
                  name: worker['name'] as String,
                  specialty: worker['specialty'] as String,
                  isVerified: worker['isVerified'] as bool,
                  rating: worker['rating'] as double,
                  reviews: worker['reviews'] as int,
                  successRate: worker['successRate'] as int,
                  baseRate: worker['baseRate'] as int,
                  isFavorite: worker['isFavorite'] as bool,
                  onTap: () => context.push('/view-worker-profile'),
                  onFavoriteTap: () {
                    // Toggle favorite — Phase 3
                  },
                );
              },
            ),
          ),
        ],
      ),

      // ── Floating Bottom Navigation ───────────────────────
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }

  /// Builds a filter chip — outlined when inactive, filled primary when active.
  Widget _buildFilterChip({
    required String label,
    IconData? icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.divider,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isActive ? Colors.white : AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: isActive ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
