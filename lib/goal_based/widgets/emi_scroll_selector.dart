import 'package:flutter/material.dart';
import 'package:flutter_application_1/common_widgets/snappinng_scroll_wheel.dart';

class EMIScrollSelector extends StatefulWidget {
  final String heading;
  final SelectorPageArguments selectorPageArguments1;
  final SelectorPageArguments selectorPageArguments2;

  const EMIScrollSelector({
    super.key,
    required this.heading,
    required this.selectorPageArguments1,
    required this.selectorPageArguments2,
  });

  @override
  State<EMIScrollSelector> createState() => _EMIScrollSelectorState();
}

class _EMIScrollSelectorState extends State<EMIScrollSelector> with AutomaticKeepAliveClientMixin{
  int pageNo = 0;

  late PageController _pageController;

  int scrollOneValue = 0;
  int scrollTwoValue = 0;

  @override
  void initState() {
    setInitialValues();
    _pageController = PageController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EMIScrollSelector oldWidget) {
    setInitialValues();
    super.didUpdateWidget(oldWidget);
  }

  setInitialValues() {
    scrollOneValue = widget.selectorPageArguments1.scroller1.initialValue;
    scrollTwoValue = widget.selectorPageArguments2.scroller1.initialValue;
  }

  Widget _pageOne() {
    return Stack(
      children: [
        Center(
          child: SnappingScrollWheel(
            header: widget.selectorPageArguments1.scroller1.header,
            list: widget.selectorPageArguments1.scroller1.list,
            initialValue: scrollOneValue,
            selectedValue: (index) {
              setState(() {
                scrollOneValue = index;
              });

              widget.selectorPageArguments1.scroller1
                  .selectedValue(scrollOneValue + 1, 'month');
            },
          ),
        ),
        IgnorePointer(
          child: Container(
            margin: const EdgeInsets.only(top: 150),
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.white.withOpacity(0.1),
            //color: NewAppColor.snowDrift.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _pageTwo() {
    return Stack(
      children: [
        Center(
          child: SnappingScrollWheel(
            header: widget.selectorPageArguments2.scroller1.header,
            list: widget.selectorPageArguments2.scroller1.list,
            initialValue: scrollTwoValue,
            selectedValue: (index) {
              setState(() {
                scrollTwoValue = index;
              });

              widget.selectorPageArguments2.scroller1!
                  .selectedValue((scrollTwoValue + 1) * 1000, 'amount');
            },
          ),
        ),
        IgnorePointer(
          child: Container(
            margin:const  EdgeInsets.only(top: 150),
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.white.withOpacity(0.1),
            //color: NewAppColor.snowDrift.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.heading,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_pageController.page == 0) {
                setState(() {
                  pageNo = 1;
                });
                _pageController.animateToPage(1,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.linear);
                widget.selectorPageArguments2.scroller1!
                    .selectedValue((scrollTwoValue + 1) * 1000, 'amount');
              } else {
                setState(() {
                  pageNo = 0;
                });
                _pageController.animateToPage(0,
                    duration:const  Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.linear);
                widget.selectorPageArguments1.scroller1
                    .selectedValue(scrollOneValue + 1, 'month');
              }
            },
            child: Text(
              (pageNo == 0) ? "Enter Amount" : "Enter Months",
              style: const TextStyle(
                color: Colors.orangeAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _header(),
        const SizedBox(
          height: 50,
        ),
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  _pageOne(),
                  _pageTwo(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
