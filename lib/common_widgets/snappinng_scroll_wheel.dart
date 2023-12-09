import 'package:flutter/material.dart';

class Scroller {
  final String header;
  final List<String> list;
  final int initialValue;
  final Function(int?, String) selectedValue;

  Scroller({
    required this.header,
    required this.list,
    required this.initialValue,
    required this.selectedValue,
  });
}

class UnitSelectorParameter {
  final String defaultValue;
  final List<String> toggleValues;

  UnitSelectorParameter(
      {required this.defaultValue, required this.toggleValues});
}

class SelectorPageArguments {
  final Scroller scroller1;
  final Scroller? scroller2;

  SelectorPageArguments({required this.scroller1, this.scroller2});
}

class ScrollerSelectorTheme {
  final Color unSelectedColor;
  final Color selectedColor;

  ScrollerSelectorTheme(
      {required this.unSelectedColor, required this.selectedColor});
}

class SnappingScrollWheel extends StatefulWidget {
  final String header;
  final List<String> list;
  final int initialValue;
  final Function(int) selectedValue;

  const SnappingScrollWheel({
    super.key,
    required this.header,
    required this.list,
    required this.initialValue,
    required this.selectedValue,
  });

  @override
  State<SnappingScrollWheel> createState() => _SnappingScrollWheelState();
}

class _SnappingScrollWheelState extends State<SnappingScrollWheel> {
  double scrollValue = 0.0;

  late ScrollController _scrollController;

  bool isInteracted = false;

  @override
  void initState() {
    scrollValue = widget.initialValue.toDouble();

    _scrollController = ScrollController(initialScrollOffset: scrollValue * 50);
    _scrollController.addListener(() {
      if (isInteracted) {
        if (scrollValue != (_scrollController.offset / 50).roundToDouble()) {
          setState(() {
            scrollValue = (_scrollController.offset / 50).roundToDouble();
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                widget.header,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: Listener(
              onPointerUp: (event) {
                setState(() {
                  isInteracted = false;
                });
                _scrollController
                    .animateTo(
                  scrollValue * 50,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.linear,
                )
                    .then((value) {
                  widget.selectedValue(scrollValue.toInt());
                });
              },
              onPointerDown: (event) {
                setState(() {
                  isInteracted = true;
                });
              },
              child: ListWheelScrollView(
                physics: const ClampingScrollPhysics(),
                controller: _scrollController,
                itemExtent: 50,
                perspective:
                    0.009, //RenderListWheelViewport.defaultDiameterRatio,
                clipBehavior: Clip.hardEdge,
                children: [
                  ...widget.list.map((e) {
                    return Center(
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white.withOpacity((widget.list
                                      .indexWhere((element) => element == e)
                                      .toDouble() ==
                                  scrollValue)
                              ? 1
                              : 0.3),
                          fontWeight: (widget.list
                                      .indexWhere((element) => element == e)
                                      .toDouble() ==
                                  scrollValue)
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
