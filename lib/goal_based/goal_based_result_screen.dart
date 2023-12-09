import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/unit_value_entity.dart';
import 'package:lottie/lottie.dart';

class GoalBasedResultScreen extends StatefulWidget {
  final UnitValueEntity investmentEntity;
  final UnitValueEntity durationEntity;
  const GoalBasedResultScreen(
      {super.key,
      required this.investmentEntity,
      required this.durationEntity});

  @override
  State<GoalBasedResultScreen> createState() => _GoalBasedResultScreenState();
}

class _GoalBasedResultScreenState extends State<GoalBasedResultScreen> {
  int calculatedInvestmentValue() {
    final calculatedInvestmentValue =
        (widget.investmentEntity.value! ~/ widget.durationEntity.value!);
    return calculatedInvestmentValue;
  }

  Widget _bgImage() {
    return Image.asset(
      "assets/bg.jpg",
      fit: BoxFit.cover,
      opacity: const AlwaysStoppedAnimation(0.3),
    );
  }

  Widget _lottieAsset() {
    return Lottie.asset(
      'assets/success1.json',
    );
  }

  Widget _goalText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(50),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "You can reach your goal of  ",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: "₹${widget.investmentEntity.value!.toInt()}  ",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const TextSpan(
                    text: "by saving  ",
                  ),
                  TextSpan(
                    text: widget.durationEntity.isMonthly()
                        ? "₹${calculatedInvestmentValue()}  "
                        : "₹ ${widget.durationEntity.value!.toInt()}  ",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const TextSpan(
                    text: "over a period of  ",
                  ),
                  TextSpan(
                    text: widget.durationEntity.isMonthly()
                        ? "${widget.durationEntity.value!.toInt()} months"
                        : "${calculatedInvestmentValue()} months",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _bgImage(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _lottieAsset(),
              _goalText(),
            ],
          ),
        ],
      ),
    );
  }
}
