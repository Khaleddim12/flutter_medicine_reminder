class Pill{
  int? id;
  String name;
  String amount;
  int howManyWeeks;
  String medicineForm;
  int time;
  int notifyId;

  Pill(
      {this.id,
       required this.howManyWeeks,
        required this.time,
        required this.amount,
        required this.medicineForm,
        required this.name,
        required this.notifyId});

  Pill copy({
  int? id,
    String? name,
    String? amount,
    int? howManyWeeks,
    String? medicineForm,
    int? time,
    int? notifyId,
})=>
  Pill(
    id:id ?? this.id,
    name:name ?? this.name,
    amount: amount ?? this.amount,
    howManyWeeks: howManyWeeks ?? this.howManyWeeks,
    medicineForm: medicineForm ?? this.medicineForm,
    time: time ?? this.time,
    notifyId: notifyId ?? this.notifyId
  );

  //------------------set pill to map-------------------
  Map<String, dynamic> toMap(){
    var map = <String, Object?>{
      'id':id,
    'name':name,
    'amount':amount,
    'howManyWeeks': howManyWeeks,
    'medicineForm':medicineForm,
    'time':time,
    'notifyId':notifyId,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

//---------------------create pill object from map---------------------

  factory Pill.fromMap( pillMap){
    return Pill(
        id: pillMap['id'],
        name: pillMap['name'],
        amount: pillMap['amount'],

        howManyWeeks: pillMap['howManyWeeks'],
        medicineForm: pillMap['medicineForm'],
        time: pillMap['time'],
        notifyId: pillMap['notifyId']);
  }

  ////---------------------| Get the medicine image path |-------------------------
  String get image{
    switch(medicineForm){
      case "Syrup": return "assets/images/syrup.png";
      case "Pill":return "assets/images/pills.png";
      case "Capsule":return "assets/images/capsule.png";
      case "Cream":return "assets/images/cream.png";
      case "Drops":return "assets/images/drops.png";
      case "Syringe":return "assets/images/syringe.png";
      default : return "assets/images/pills.png";
    }
  }
}


