import 'package:flutter/material.dart';
import 'package:flutter_application_1/common_widgets/proceed_button.dart';
import 'package:flutter_application_1/common_widgets/snappinng_scroll_wheel.dart';
import 'package:flutter_application_1/goal_based/widgets/goal_scroll_selector.dart';
import 'package:flutter_application_1/model/unit_value_entity.dart';

class GoalSelectorPage extends StatefulWidget {
  final Function(UnitValueEntity) callback;
  const GoalSelectorPage({super.key, required this.callback});

  @override
  State<GoalSelectorPage> createState() => _GoalSelectorPageState();
}

class _GoalSelectorPageState extends State<GoalSelectorPage> {
  bool showErrorText = false;

  UnitValueEntity unitValueEntity = UnitValueEntity(value: 10000, unit: "");

  Widget _selector() {
    return GoalScrollSelector(
      heading: "Select your goal..",
      selectorPageArguments1: SelectorPageArguments(
        scroller1: Scroller(
          header: "₹",
          list: List.generate(100, (index) => ((index + 1) * 1000).toString()),
          initialValue: 9,
          selectedValue: (value, unit) {
            setState(() {
              unitValueEntity =
                  UnitValueEntity(value: value!.toDouble(), unit: "");
            });
          },
        ),
      ),
    );
  }

  Widget _errorText() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        showErrorText ? "Enter amount higher than Rs 2000" : "",
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 15,
          fontWeight: FontWeight.w600,
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
          if (unitValueEntity.value! < 2000) {
            setState(() {
              showErrorText = true;
            });
          } else {
            widget.callback(unitValueEntity);
          }
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
        _selector(),
        const SizedBox(
          height: 80,
        ),
        _errorText(),
        _confirmButton(),
      ],
    );
  }
}
