import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'cupertino_modal_page_inherited.dart';

class CupertinoModalPage extends StatefulWidget {
  const CupertinoModalPage({required this.child, super.key});

  final Widget child;

  @override
  State<CupertinoModalPage> createState() => CupertinoModalPageState();
}

class CupertinoModalPageState extends State<CupertinoModalPage> with SingleTickerProviderStateMixin {
  static const Duration _backTransitionDuration = Duration(milliseconds: 400);
  static const Duration _transitionDuration = Duration(milliseconds: 300);
  static const Curve _transitionCurve = Curves.linearToEaseOut;

  late final AnimationController _controller;
  late final Animation<double> _radiusAnimation;
  late final ValueNotifier<bool> _openedNotifier;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _backTransitionDuration, reverseDuration: _backTransitionDuration);
    _radiusAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(CurvedAnimation(parent: _controller, curve: _transitionCurve));
    _openedNotifier = ValueNotifier<bool>(false)..addListener(() {
      if (_openedNotifier.value == true) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return CupertinoModalPageInherited(
      data: this,
      child: ValueListenableBuilder(
        valueListenable: _openedNotifier,
        builder: (context, isOpen, child) {
          return AnimatedPadding(
            duration: _backTransitionDuration,
            curve: _transitionCurve,
            padding: isOpen ? EdgeInsets.fromLTRB(16.0, topPadding + 10.0, 16.0, 0.0) : EdgeInsets.zero,
            child: AnimatedBuilder(
              animation: _radiusAnimation,
              builder: (context, child) {
                return ClipRRect(borderRadius: BorderRadius.all(Radius.circular(_radiusAnimation.value)), child: child);
              },
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }

  Future<T?> show<T>(BuildContext context, WidgetBuilder builder) async {
    if (_openedNotifier.value == true) {
      return throw Exception('CupertinoModalPage is now displayed');
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;

    _openedNotifier.value = true;
    final result = await Navigator.of(context).push<T>(
      PageRouteBuilder(
        opaque: false,
        barrierLabel: '',
        barrierColor: const Color(0x4D000000),
        transitionDuration: _transitionDuration,
        reverseTransitionDuration: _transitionDuration,
        pageBuilder: (context, animation, secondaryAnimation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 1.0),
              end: Offset(0.0, 1.0 - ((screenHeight - topPadding - 20.0) / screenHeight)),
            ).animate(CurvedAnimation(parent: animation, curve: _transitionCurve)),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0 * animation.value)), child: child);
              },
              child: builder(context),
            ),
          );
        },
      ),
    );
    _openedNotifier.value = false;

    return result;
  }
}
