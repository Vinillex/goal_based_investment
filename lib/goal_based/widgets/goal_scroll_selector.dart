import 'package:flutter/material.dart';
import 'package:flutter_application_1/common_widgets/snappinng_scroll_wheel.dart';

class GoalScrollSelector extends StatefulWidget {
  final String heading;
  final SelectorPageArguments selectorPageArguments1;

  const GoalScrollSelector({
    super.key,
    required this.heading,
    required this.selectorPageArguments1,
  });

  @override
  State<GoalScrollSelector> createState() => _GoalScrollSelectorState();
}

class _GoalScrollSelectorState extends State<GoalScrollSelector> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  int pageNo = 0;

  late PageController _pageController;

  int scrollOneValue = 0;

  @override
  void initState() {
    setInitialValues();
    _pageController = PageController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GoalScrollSelector oldWidget) {
    setInitialValues();
    super.didUpdateWidget(oldWidget);
  }

  setInitialValues() {
    scrollOneValue = widget.selectorPageArguments1.scroller1.initialValue;
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
                  .selectedValue((scrollOneValue + 1) * 1000, '');
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        onChanged: (value) {
          widget.selectorPageArguments1.scroller1
              .selectedValue(int.tryParse(value)!, '');
        },
        focusNode: _focusNode,
        style: TextStyle(
          color: Colors.white,
        ),
        controller: _textEditingController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Enter your goal",
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.heading,
            style: TextStyle(
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
                _pageController
                    .animateToPage(1,
                        duration: Duration(
                          milliseconds: 200,
                        ),
                        curve: Curves.linear)
                    .then(
                  (value) {
                    FocusScope.of(context).requestFocus(_focusNode);
                    if (_textEditingController.value.text.isEmpty) {
                      widget.selectorPageArguments1.scroller1
                          .selectedValue(scrollOneValue * 1000, '');
                    } else {
                      widget.selectorPageArguments1.scroller1.selectedValue(
                          int.parse(_textEditingController.value.text), '');
                    }
                  },
                );
              } else {
                if (_focusNode.hasFocus) {
                  _focusNode.unfocus();
                }
                setState(() {
                  pageNo = 0;
                });
                _pageController
                    .animateToPage(0,
                        duration: Duration(
                          milliseconds: 200,
                        ),
                        curve: Curves.linear)
                    .then((value) {
                  widget.selectorPageArguments1.scroller1
                      .selectedValue(scrollOneValue * 1000, '');
                });
              }
            },
            child: Text(
              (pageNo == 0) ? "Enter Manually" : "Select from options",
              style: TextStyle(
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
}
