class SysRanges {
  final String currencyCode;
  final List<double> options;

  SysRanges({required this.currencyCode, required this.options});

  // Factory constructor to create an instance of CurrencyOption from a Map (from JSON)
  factory SysRanges.fromJson(Map<String, dynamic> json) {
    List<double> options = [];
    if (json['options'] != null) {
      for (var option in json['options']) {
        if (option is int) {
          options.add(option.toDouble());
        } else if (option is double) {
          options.add(option);
        }
        // Optionally handle other types, or ignore them
      }
    }
    return SysRanges(
      currencyCode: json['currencyCode'],
      options: options,
    );
  }

  // Method to convert the instance back to a Map (to JSON, if needed)
  Map<String, dynamic> toJson() {
    return {
      'currencyCode': currencyCode,
      'options': options,
    };
  }

  static List<String> getFormattedRanges( List<double> options) {
    double? previousEnd;
    List<String> ranges = [];
    for (var option in options) {
      if (previousEnd == null) {
        ranges.add("0-$option");
      } else {
        ranges.add("${previousEnd + 1}-$option");
      }
      previousEnd = option.toDouble();
    }

    if (previousEnd != null) {
      ranges.add("Above $previousEnd");
    }

    return ranges;
  }
}
