final String tableDiary = 'diary';

class DiaryFields {
  static final List<String> values = [
    colId,
    colDate,
    colDiary,
    colRate,
  ];

  static final String colId = '_id';
  static final String colDate = 'date';
  static final String colDiary = 'diary';
  static final String colRate = 'rate';
}

class Diary {
  final int id;
  final String date;
  final String diary;
  final int rate;

  const Diary({
    this.id,
    this.date,
    this.diary,
    this.rate,
  });

  Diary copy({
    int id,
    String date,
    String diary,
    int rate,
  }) =>
      Diary(
        id: id ?? this.id,
        date: date ?? this.date,
        diary: diary ?? this.diary,
        rate: rate ?? this.rate,
      );

  static Diary fromJson(Map<String, Object> json) => Diary(
        id: json[DiaryFields.colId] as int,
        date: json[DiaryFields.colDate] as String,
        diary: json[DiaryFields.colDiary] as String,
        rate: json[DiaryFields.colRate] as int,
      );

  Map<String, Object> toJson() => {
        DiaryFields.colId: id,
        DiaryFields.colDate: date,
        DiaryFields.colDiary: diary,
        DiaryFields.colRate: rate,
      };
}
