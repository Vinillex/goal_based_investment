import 'package:flutter/material.dart';
import 'package:flutter_application_1/goal_based/goal_based_result_screen.dart';
import 'package:flutter_application_1/goal_based/pages/emi_page.dart';
import 'package:flutter_application_1/goal_based/pages/goal_selector_page.dart';
import 'package:flutter_application_1/model/unit_value_entity.dart';

class GoalBasedScreen extends StatefulWidget {
  const GoalBasedScreen({
    super.key,
  });
  @override
  State<GoalBasedScreen> createState() => _GoalBasedScreenState();
}

class _GoalBasedScreenState extends State<GoalBasedScreen> {
  late PageController _controller;
  late AssetImage logo;
  bool showBackButton = false;

  UnitValueEntity investmentUnitValue = UnitValueEntity(value: 10000);
  UnitValueEntity monthUnitValue = UnitValueEntity(value: 12, unit: "month");

  @override
  initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(() {
      if (_controller.page == 1) {
        setState(() {
          showBackButton = true;
        });
      } else {
        setState(() {
          showBackButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    logo = const AssetImage("assets/bg.jpg");
    await precacheImage(logo, context);
    super.didChangeDependencies();
  }

  void _onBackButtonPressed() {
    if (_controller.page != null && _controller.page!.floor() >= 1) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  List<Widget> get _calculatorPages => [
        GoalSelectorPage(
          callback: (entity) {
            setState(() {
              investmentUnitValue = entity;
            });
            _controller.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          },
        ),
        EMISelectorPage(
          callback: (entity) {
            setState(() {
              monthUnitValue = entity;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GoalBasedResultScreen(
                    investmentEntity: investmentUnitValue,
                    durationEntity: monthUnitValue),
              ),
            );
          },
          amount: investmentUnitValue.value!.toInt(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackButtonPressed();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: (showBackButton)
              ? IconButton(
                  onPressed: () {
                    _onBackButtonPressed();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ))
              : null,
          title: const Text(
            "Goal Based Planing",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: logo,
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.3),
            ),
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _calculatorPages.length,
              itemBuilder: (context, index) => _calculatorPages[index],
            ),
          ],
        ),
      ),
    );
  }
}
