import 'package:flutter/material.dart';

class ProceedButton extends StatefulWidget {
  final Widget child;
  final Function callback;
  const ProceedButton({
    required this.child,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  State<ProceedButton> createState() => _ProceedButtonState();
}

class _ProceedButtonState extends State<ProceedButton>
    with SingleTickerProviderStateMixin {
  static const clickAnimationDurationMillis = 200;
  double _scaleTransformValue = 1;
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() => _scaleTransformValue = 1 - animationController.value);
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _shrinkCardSize() {
    animationController.forward();
  }

  void _restoreCardSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
      () => animationController.reverse(),
    );
  }

  @override
  void didUpdateWidget(covariant ProceedButton oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _shrinkCardSize();
        _restoreCardSize();

        Future.delayed(
          const Duration(milliseconds: clickAnimationDurationMillis + 100),
          () => {
            widget.callback.call(),
          },
        );
      },
      onTapDown: (_) => _shrinkCardSize(),
      onTapCancel: () => _restoreCardSize(),
      //
      child: Transform.scale(
        scale: _scaleTransformValue,
        child: Container(
          height: 70,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
