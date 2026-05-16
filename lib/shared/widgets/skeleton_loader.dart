import 'package:flutter/material.dart';
import 'package:handyph_app/core/theme/app_colors.dart';

/// Shimmer animation wrapper for skeleton loading placeholders.
///
/// Wraps child skeleton shapes in a pulsing gradient animation
/// to indicate content is loading.
class ShimmerLoader extends StatefulWidget {
  final Widget child;

  const ShimmerLoader({super.key, required this.child});

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                Color(0xFFEBEDF0),
                Color(0xFFF5F6F8),
                Color(0xFFEBEDF0),
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SKELETON SHAPE PRIMITIVES
// ════════════════════════════════════════════════════════════════

/// Rectangular skeleton placeholder (for text lines, buttons, images).
class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF0),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Circular skeleton placeholder (for avatars).
class SkeletonCircle extends StatelessWidget {
  final double size;

  const SkeletonCircle({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFFE8EAF0),
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Card-shaped skeleton (for worker cards, job cards, etc.).
class SkeletonCard extends StatelessWidget {
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const SkeletonCard({
    super.key,
    this.height = 140,
    this.borderRadius = 16,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: child != null ? null : height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: child,
    );
  }
}
