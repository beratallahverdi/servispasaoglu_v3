class Stage {
  final String title;
  final String fullname;
  final String ecu;
  final String fuel;
  final int originalPower;
  final int tuningPower;
  final int originalTorque;
  final int tuningTorque;

  Stage(
      {required this.title,
      required this.fullname,
      required this.ecu,
      required this.fuel,
      required this.originalPower,
      required this.tuningPower,
      required this.originalTorque,
      required this.tuningTorque});
  Stage getOriginal() {
    return Stage(
      title: "Original",
      fullname: fullname,
      ecu: ecu,
      fuel: fuel,
      originalPower: originalPower,
      tuningPower: originalPower,
      originalTorque: originalTorque,
      tuningTorque: originalTorque,
    );
  }

  Stage getDifference() {
    return Stage(
      title: "Difference",
      fullname: fullname,
      ecu: ecu,
      fuel: fuel,
      originalPower: tuningPower - originalPower,
      tuningPower: tuningPower - originalPower,
      originalTorque: tuningTorque - originalTorque,
      tuningTorque: tuningTorque - originalTorque,
    );
  }
}
