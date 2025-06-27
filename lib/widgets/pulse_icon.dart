import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PulseIcon extends StatefulWidget {
  final IconData? icon;
  final String? imageAsset;
  final Widget? customChild;
  final Color primaryColor;
  final Color pulseColor;
  final double size;
  final Duration duration;

  const PulseIcon({
    Key? key,
    this.icon,
    this.imageAsset,
    this.customChild,
    this.primaryColor = const Color(0xFF2196F3),
    this.pulseColor = const Color(0xFF2196F3),
    this.size = 120.0,
    this.duration = const Duration(seconds: 2),
  })  : assert(icon != null || imageAsset != null || customChild != null,
            'Either icon, imageAsset, or customChild must be provided'),
        super(key: key);

  @override
  State<PulseIcon> createState() => _PulseIconState();
}

class _PulseIconState extends State<PulseIcon> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.6,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildInnerContent() {
    if (widget.customChild != null) {
      return widget.customChild!;
    } else if (widget.imageAsset != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          width: 32.0.w,
          height: 32.0.w,
          widget.imageAsset!,
        ),
      );
    } else {
      return Icon(
        widget.icon!,
        size: widget.size * 0.25,
        color: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 2,
      height: widget.size * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulsing outer circle
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        widget.pulseColor.withOpacity(_opacityAnimation.value),
                  ),
                ),
              );
            },
          ),
          Container(
            width: widget.size * 0.6,
            height: widget.size * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: widget.primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(child: _buildInnerContent()),
          ),
        ],
      ),
    );
  }
}
