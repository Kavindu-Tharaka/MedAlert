final String tableReminder = 'reminder';

class ReminderFields {
  static final List<String> values = [
    colId,
    colMedicineId,
    colHour,
    colMinute,
    colMonday,
    colTuesday,
    colWednesday,
    colThursday,
    colFriday,
    colSaturday,
    colSunday,
    colMedicineName,
    colIsBefore,
  ];

  static final String colId = '_id';
  static final String colMedicineId = 'medicineId';
  static final String colHour = 'hour';
  static final String colMinute = 'minute';
  static final String colMonday = 'monday';
  static final String colTuesday = 'tuesday';
  static final String colWednesday = 'wednesday';
  static final String colThursday = 'thursday';
  static final String colFriday = 'friday';
  static final String colSaturday = 'saturday';
  static final String colSunday = 'sunday';
  static final String colMedicineName = 'medicineName';
  static final String colIsBefore = 'isBefore';
}

class Reminder {
  final int id;
  final int medicineId;
  final int hour;
  final int minute;
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;
  final bool sunday;
  final String medicineName;
  final bool isBefore;

  const Reminder({
    this.id,
    this.medicineId,
    this.hour,
    this.minute,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.medicineName,
    this.isBefore,
  });

  Reminder copy({
    final int id,
    final int medicineId,
    final int hour,
    final int minute,
    final bool monday,
    final bool tuesday,
    final bool wednesday,
    final bool thursday,
    final bool friday,
    final bool saturday,
    final bool sunday,
    final String medicineName,
    final bool isBefore,
  }) =>
      Reminder(
        id: id ?? this.id,
        medicineId: medicineId ?? this.medicineId,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
        medicineName: medicineName ?? this.medicineName,
        isBefore: isBefore ?? this.isBefore,
      );

  static Reminder fromJson(Map<String, Object> json) => Reminder(
        id: json[ReminderFields.colId] as int,
        medicineId: json[ReminderFields.colMedicineId] as int,
        hour: json[ReminderFields.colHour] as int,
        minute: json[ReminderFields.colMinute] as int,
        monday: json[ReminderFields.colMonday] == 1,
        tuesday: json[ReminderFields.colTuesday] == 1,
        wednesday: json[ReminderFields.colWednesday] == 1,
        thursday: json[ReminderFields.colThursday] == 1,
        friday: json[ReminderFields.colFriday] == 1,
        saturday: json[ReminderFields.colSaturday] == 1,
        sunday: json[ReminderFields.colSunday] == 1,
        medicineName: json[ReminderFields.colMedicineName] as String,
        isBefore: json[ReminderFields.colIsBefore] == 1,
      );

  Map<String, Object> toJson() => {
        ReminderFields.colId: id,
        ReminderFields.colMedicineId: medicineId,
        ReminderFields.colHour: hour,
        ReminderFields.colMinute: minute,
        ReminderFields.colMonday: monday == true ? 1 : 0,
        ReminderFields.colTuesday: tuesday == true ? 1 : 0,
        ReminderFields.colWednesday: wednesday == true ? 1 : 0,
        ReminderFields.colThursday: thursday == true ? 1 : 0,
        ReminderFields.colFriday: friday == true ? 1 : 0,
        ReminderFields.colSaturday: saturday == true ? 1 : 0,
        ReminderFields.colSunday: sunday == true ? 1 : 0,
        ReminderFields.colMedicineName: medicineName,
        ReminderFields.colIsBefore: isBefore == true ? 1 : 0,
      };
}
