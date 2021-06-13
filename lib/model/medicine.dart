final String tableMedicine = 'medicine';

class MedicineFields {
  static final List<String> values = [
    colId,
    colName,
    colTotalAmount,
    colCurrentAmount,
    colDosageAmount,
    colAmountUnit,
    colIsBefore,
    colTimesPerDay,
    colColor
  ];

  static final String colId = '_id';
  static final String colName = 'name';
  static final String colTotalAmount = 'totalAmount';
  static final String colCurrentAmount = 'currentAmount';
  static final String colDosageAmount = 'dosageAmount';
  static final String colAmountUnit = 'amountUnit';
  static final String colIsBefore = 'isBefore';
  static final String colTimesPerDay = 'timesPerDay';
  static final String colColor = 'color';
}

class Medicine {
  final int id;
  final String name;
  final int totalAmount;
  final int currentAmount;
  final int dosageAmount;
  final String amountUnit;
  final bool isBefore;
  final int timesPerDay;
  final String color;

  const Medicine({
    this.id,
    this.name,
    this.totalAmount,
    this.currentAmount,
    this.dosageAmount,
    this.amountUnit,
    this.isBefore,
    this.timesPerDay,
    this.color,
  });

  Medicine copy({
    int id,
    String name,
    int totalAmount,
    int currentAmount,
    int dosageAmount,
    String amountUnit,
    bool isBefore,
    int timesPerDay,
    String color,
  }) =>
      Medicine(
        id: id ?? this.id,
        name: name ?? this.name,
        totalAmount: totalAmount ?? this.totalAmount,
        currentAmount: currentAmount ?? this.currentAmount,
        dosageAmount: dosageAmount ?? this.dosageAmount,
        amountUnit: amountUnit ?? this.amountUnit,
        isBefore: isBefore ?? this.isBefore,
        timesPerDay: timesPerDay ?? this.timesPerDay,
        color: color ?? this.color,
      );

  static Medicine fromJson(Map<String, Object> json) => Medicine(
        id: json[MedicineFields.colId] as int,
        name: json[MedicineFields.colName] as String,
        totalAmount: json[MedicineFields.colTotalAmount] as int,
        currentAmount: json[MedicineFields.colCurrentAmount] as int,
        dosageAmount: json[MedicineFields.colDosageAmount] as int,
        amountUnit: json[MedicineFields.colAmountUnit] as String,
        isBefore: json[MedicineFields.colIsBefore] == 1,
        timesPerDay: json[MedicineFields.colTimesPerDay] as int,
        color: json[MedicineFields.colColor] as String,
      );

  Map<String, Object> toJson() => {
        MedicineFields.colId: id,
        MedicineFields.colName: name,
        MedicineFields.colTotalAmount: totalAmount,
        MedicineFields.colCurrentAmount: currentAmount,
        MedicineFields.colDosageAmount: dosageAmount,
        MedicineFields.colAmountUnit: amountUnit,
        MedicineFields.colTimesPerDay: timesPerDay,
        MedicineFields.colIsBefore: isBefore == true ? 1 : 0,
        MedicineFields.colColor: color,
      };
}
