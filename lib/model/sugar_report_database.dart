final String tableSugar = "sugar";

class SugarFields {
  static final List<String> values = [
    id,
    sugarLevelF,
    sugarLevelPP,
    reportDate
  ];

  static final String id = "_id";
  static final String sugarLevelF = "sugarLevelF";
  static final String sugarLevelPP = "sugarLevelPP";
  static final String reportDate = "reportDate";
}

class Sugar {
  final int id;
  final String sugarLevelF;
  final String sugarLevelPP;
  final DateTime reportDate;

  const Sugar({
    this.id,
    this.sugarLevelF,
    this.sugarLevelPP,
    this.reportDate,
  });

  Sugar copy({
    int id,
    String sugarLevelF,
    String sugarLevelPP,
    DateTime reportDate,
  }) =>
      Sugar(
        id: id ?? this.id,
        sugarLevelF: sugarLevelF ?? this.sugarLevelF,
        sugarLevelPP: sugarLevelPP ?? this.sugarLevelPP,
        reportDate: reportDate ?? this.reportDate,
      );

  static Sugar fromJson(Map<String, Object> json) => Sugar(
        id: json[SugarFields.id] as int,
        sugarLevelF: json[SugarFields.sugarLevelF] as String,
        sugarLevelPP: json[SugarFields.sugarLevelPP] as String,
        reportDate: DateTime.parse(json[SugarFields.reportDate] as String),
      );

  //map to Json object
  Map<String, Object> toJson() => {
        SugarFields.id: id,
        SugarFields.sugarLevelF: sugarLevelF,
        SugarFields.sugarLevelPP: sugarLevelPP,
        SugarFields.reportDate: reportDate.toIso8601String(),
      };
}
