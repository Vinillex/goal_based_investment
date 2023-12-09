class UnitValueEntity {
  double? value;
  String? unit;

  UnitValueEntity({
    this.value,
    this.unit,
  });

  Map<String, dynamic> toJson() => {
        "value": value,
        "unit": unit,
      };

  UnitValueEntity.fromJson(Map<String, dynamic> json) {
    value = json['value'].toDouble();
    unit = json['unit'];
  }

  @override
  String toString() {
    return '$unit $value';
  }

  bool isMonthly() {
    if (unit == "month") {
      return true;
    } else {
      return false;
    }
  }

  


}
