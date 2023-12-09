import 'package:flutter/material.dart';
import 'package:flutter_application_1/common_widgets/proceed_button.dart';
import 'package:flutter_application_1/common_widgets/snappinng_scroll_wheel.dart';
import 'package:flutter_application_1/goal_based/widgets/emi_scroll_selector.dart';
import 'package:flutter_application_1/model/unit_value_entity.dart';

class EMISelectorPage extends StatefulWidget {
  final int amount;
  final Function(UnitValueEntity) callback;
  const EMISelectorPage(
      {super.key, required this.callback, required this.amount});

  @override
  State<EMISelectorPage> createState() => _EMISelectorPageState();
}

class _EMISelectorPageState extends State<EMISelectorPage> {
  UnitValueEntity unitValueEntity = UnitValueEntity(value: 12, unit: "month");

  int maxAmount() {
    final maxAmount = widget.amount ~/ 2000;
    return maxAmount;
  }

  Widget _scrollSelector() {
    return EMIScrollSelector(
      heading: 'Select your investment',
      selectorPageArguments1: SelectorPageArguments(
        scroller1: Scroller(
          header: "Months",
          list: List.generate(60, (index) => (index + 1).toString()),
          initialValue: 11,
          selectedValue: (value, unit) {
            setState(() {
              unitValueEntity =
                  UnitValueEntity(value: value!.toDouble(), unit: "month");
            });
          },
        ),
      ),
      selectorPageArguments2: SelectorPageArguments(
        scroller1: Scroller(
          header: "Monthly Amount",
          list: List.generate(
              maxAmount(), (index) => ((index + 1) * 1000).toString()),
          initialValue: 1,
          selectedValue: (value, unit) {
            setState(() {
              unitValueEntity =
                  UnitValueEntity(value: value!.toDouble(), unit: "amount");
            });
          },
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ProceedButton(
        child: const Text(
          "Confirm",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        callback: () {
          widget.callback(unitValueEntity);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _scrollSelector(),
        const SizedBox(
          height: 80,
        ),
        _confirmButton(),
      ],
    );
  }
}
