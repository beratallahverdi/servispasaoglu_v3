import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:servispasaoglu_v3/api/order.dart';

import 'brand.dart';
import 'ecu.dart';
import 'engine.dart';
import 'fcm_token.dart';
import 'generation.dart';
import 'message.dart';
import 'model.dart';
import 'order_request.dart';
import 'order_status.dart';
import 'order_status_log.dart';
import 'tuning_device.dart';
import 'user.dart';
import 'vehicle_type.dart';

class Order {
  final int? userId;
  final int? orderId;
  VehicleType? vehicleType;
  String? brandId;
  String? modelId;
  String? engineId;
  String? ecuId;
  String? ecuHw;
  String? ecuSw;
  String? powerHp;
  String? powerKw;
  String? torqueNm;
  int? year;
  String? transmission;
  String? engineType;
  TuningDevice? tuningDevice;
  String? interestedIn;
  int? kilometer;
  String? customerDetails;
  String? orderDate;
  String? updatedAt;
  String? appTime;
  String? firstTimeInfo;
  String? lastTimeInfo;
  String? totalTimeInfo;
  OrderStatus? orderStatus;
  String? plateNumber;
  String? chassisNumber;
  String? customerName;
  String? telephoneNumber;
  int? totalCredit;
  String? readType;
  String? readFrom;
  String? generationId;
  List<FcmToken>? fcmToken;
  List<dynamic>? userList;
  Brand? brand;
  Model? model;
  Generation? generation;
  Engine? engine;
  Ecu? ecu;
  List<OrderRequest>? orderRequests;
  List<dynamic>? orderTimedAccess;
  User? user;
  List<Message>? messages;
  List<OrderStatusLog>? orderStatusLogs;

  Order({
    this.userId,
    this.orderId,
    this.vehicleType,
    this.brandId,
    this.modelId,
    this.engineId,
    this.ecuId,
    this.ecuHw,
    this.ecuSw,
    this.powerHp,
    this.powerKw,
    this.torqueNm,
    this.year,
    this.transmission,
    this.engineType,
    this.tuningDevice,
    this.interestedIn,
    this.kilometer,
    this.customerDetails,
    this.orderDate,
    this.updatedAt,
    this.appTime,
    this.firstTimeInfo,
    this.lastTimeInfo,
    this.totalTimeInfo,
    this.orderStatus,
    this.plateNumber,
    this.chassisNumber,
    this.customerName,
    this.telephoneNumber,
    this.totalCredit,
    this.readType,
    this.readFrom,
    this.generationId,
    this.fcmToken,
    this.userList,
    this.brand,
    this.model,
    this.generation,
    this.engine,
    this.ecu,
    this.orderRequests,
    this.orderTimedAccess,
    this.user,
    this.messages,
    this.orderStatusLogs,
  });

  set setBrandId(String? brandId) {
    this.brandId = brandId;
  }

  set setBrand(Brand? brand) {
    this.brand = brand;
  }

  set setModelId(String? modelId) {
    this.modelId = modelId;
  }

  set setModel(Model? model) {
    this.model = model;
  }

  set setGenerationId(String? generationId) {
    this.generationId = generationId;
  }

  set setGeneration(Generation? generation) {
    this.generation = generation;
  }

  set setEngineId(String? engineId) {
    this.engineId = engineId;
  }

  set setEngine(Engine? engine) {
    this.engine = engine;
  }

  set setEcuId(String? ecuId) {
    this.ecuId = ecuId;
  }

  set setEcu(Ecu? ecu) {
    this.ecu = ecu;
  }

  set setPowerHp(String? powerHp) {
    this.powerHp = powerHp;
  }

  set setPowerKw(String? powerKw) {
    this.powerKw = powerKw;
  }

  set setTorqueNm(String? torqueNm) {
    this.torqueNm = torqueNm;
  }

  set setYear(int? year) {
    this.year = year;
  }

  set setFuelType(String? engineType) {
    this.engineType = engineType;
  }

  set setTransmission(String? transmission) {
    this.transmission = transmission;
  }

  set setPlateNumber(String? plateNumber) {
    this.plateNumber = plateNumber;
  }

  set setKilometer(int? kilometer) {
    this.kilometer = kilometer;
  }

  set setChassisNumber(String? chassisNumber) {
    this.chassisNumber = chassisNumber;
  }

  set setCustomerName(String? customerName) {
    this.customerName = customerName;
  }

  set setTelephoneNumber(String? telephoneNumber) {
    this.telephoneNumber = telephoneNumber;
  }

  set setReadType(String? readType) {
    this.readType = readType;
  }

  set setReadFrom(String? readFrom) {
    this.readFrom = readFrom;
  }

  set setCustomerDetails(String? customerDetails) {
    this.customerDetails = customerDetails;
  }

  set setTuningDevice(TuningDevice? tuningDevice) {
    this.tuningDevice = tuningDevice;
  }

  set setOrderRequests(List<OrderRequest>? orderRequests) {
    this.orderRequests = orderRequests;
  }

  @override
  String toString() {
    return 'Order(userId: $userId, orderId: $orderId, vehicleType: $vehicleType, brandId: $brandId, modelId: $modelId, engineId: $engineId, ecuId: $ecuId, ecuHw: $ecuHw, ecuSw: $ecuSw, powerHp: $powerHp, powerKw: $powerKw, torqueNm: $torqueNm, year: $year, transmission: $transmission, engineType: $engineType, tuningDevice: $tuningDevice, interestedIn: $interestedIn, kilometer: $kilometer, customerDetails: $customerDetails, orderDate: $orderDate, updatedAt: $updatedAt, orderStatus: $orderStatus, plateNumber: $plateNumber, chassisNumber: $chassisNumber, customerName: $customerName, telephoneNumber: $telephoneNumber, totalCredit: $totalCredit, readType: $readType, readFrom: $readFrom, generationId: $generationId, fcmToken: $fcmToken, userList: $userList, brand: $brand, model: $model, generation: $generation, engine: $engine, ecu: $ecu, orderRequests: $orderRequests, orderTimedAccess: $orderTimedAccess, user: $user, messages: $messages, orderStatusLogs: $orderStatusLogs)';
  }

  factory Order.fromMap(Map<String, dynamic> data) => Order(
        userId: data['user_id'] as int?,
        orderId: data['order_id'] as int?,
        vehicleType: data['vehicle_type'] == null
            ? null
            : VehicleType.fromMap(data['vehicle_type'] as Map<String, dynamic>),
        brandId: data['brand_id'] as String?,
        modelId: data['model_id'] as String?,
        engineId: data['engine_id'] as String?,
        ecuId: data['ecu_id'] as String?,
        ecuHw: data['ecu_hw'] as String?,
        ecuSw: data['ecu_sw'] as String?,
        powerHp: data['power_hp'] as String?,
        powerKw: data['power_kw'] as String?,
        torqueNm: data['torque_nm'] as String?,
        year: data['year'] as int?,
        transmission: data['transmission'] as String?,
        engineType: data['engine_type'] as String?,
        tuningDevice: data['tuning_device'] == null
            ? null
            : TuningDevice.fromMap(
                data['tuning_device'] as Map<String, dynamic>),
        interestedIn: data['interested_in'] as String?,
        kilometer: data['kilometer'] as int?,
        customerDetails: data['customer_details'] as String?,
        orderDate: data['order_date'] as String?,
        updatedAt: data['updated_at'] as String?,
        appTime: data['app_time'] as String?,
        firstTimeInfo: data['first_time_info'] as String?,
        lastTimeInfo: data['last_time_info'] as String?,
        totalTimeInfo: data['total_time_info'] as String?,
        orderStatus: data['order_status'] == null
            ? null
            : OrderStatus.fromMap(data['order_status'] as Map<String, dynamic>),
        plateNumber: data['plate_number'] as String?,
        chassisNumber: data['chassis_number'] as String?,
        customerName: data['customer_name'] as String?,
        telephoneNumber: data['telephone_number'] as String?,
        totalCredit: data['total_credit'] as int?,
        readType: data['read_type'] as String?,
        readFrom: data['read_from'] as String?,
        generationId: data['generation_id'] as String?,
        fcmToken: (data['fcm_token'] as List<dynamic>?)
            ?.map((e) => FcmToken.fromMap(e as Map<String, dynamic>))
            .toList(),
        userList: data['user_list'] as List<dynamic>?,
        brand: data['brand'] == null
            ? null
            : Brand.fromMap(data['brand'] as Map<String, dynamic>),
        model: data['model'] == null
            ? null
            : Model.fromMap(data['model'] as Map<String, dynamic>),
        generation: data['generation'] == null
            ? null
            : Generation.fromMap(data['generation'] as Map<String, dynamic>),
        engine: data['engine'] == null
            ? null
            : Engine.fromMap(data['engine'] as Map<String, dynamic>),
        ecu: data['ecu'] == null
            ? null
            : Ecu.fromMap(data['ecu'] as Map<String, dynamic>),
        orderRequests: (data['order_requests'] as List<dynamic>?)
            ?.map((e) => OrderRequest.fromMap(e as Map<String, dynamic>))
            .toList(),
        orderTimedAccess: data['order_timed_access'] as List<dynamic>?,
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        messages: (data['messages'] as List<dynamic>?)
            ?.map((e) => Message.fromMap(e as Map<String, dynamic>))
            .toList(),
        orderStatusLogs: (data['order_status_logs'] as List<dynamic>?)
            ?.map((e) => OrderStatusLog.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'order_id': orderId,
        'vehicle_type': vehicleType?.toMap(),
        'brand_id': brandId,
        'model_id': modelId,
        'engine_id': engineId,
        'ecu_id': ecuId,
        'ecu_hw': ecuHw,
        'ecu_sw': ecuSw,
        'power_hp': powerHp,
        'power_kw': powerKw,
        'torque_nm': torqueNm,
        'year': year,
        'transmission': transmission,
        'engine_type': engineType,
        'tuning_device': tuningDevice?.toMap(),
        'interested_in': interestedIn,
        'kilometer': kilometer,
        'customer_details': customerDetails,
        'order_date': orderDate,
        'updated_at': updatedAt,
        'app_time': appTime,
        'first_time_info': firstTimeInfo,
        'last_time_info': lastTimeInfo,
        'total_time_info': totalTimeInfo,
        'order_status': orderStatus?.toMap(),
        'plate_number': plateNumber,
        'chassis_number': chassisNumber,
        'customer_name': customerName,
        'telephone_number': telephoneNumber,
        'total_credit': totalCredit,
        'read_type': readType,
        'read_from': readFrom,
        'generation_id': generationId,
        'fcm_token': fcmToken?.map((e) => e.toMap()).toList(),
        'user_list': userList,
        'brand': brand?.toMap(),
        'model': model?.toMap(),
        'generation': generation?.toMap(),
        'engine': engine?.toMap(),
        'ecu': ecu?.toMap(),
        'order_requests': orderRequests?.map((e) => e.toMap()).toList(),
        'order_timed_access': orderTimedAccess,
        'user': user?.toMap(),
        'messages': messages?.map((e) => e.toMap()).toList(),
        'order_status_logs': orderStatusLogs?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Order].
  factory Order.fromJson(String data) {
    return Order.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Order] to a JSON string.
  String toJson() => json.encode(toMap());

  Order copyWith({
    int? userId,
    int? orderId,
    VehicleType? vehicleType,
    String? brandId,
    String? modelId,
    String? engineId,
    String? ecuId,
    dynamic ecuHw,
    dynamic ecuSw,
    String? powerHp,
    String? powerKw,
    String? torqueNm,
    int? year,
    String? transmission,
    String? engineType,
    TuningDevice? tuningDevice,
    String? interestedIn,
    int? kilometer,
    String? customerDetails,
    String? orderDate,
    String? updatedAt,
    String? appTime,
    String? firstTimeInfo,
    String? lastTimeInfo,
    String? totalTimeInfo,
    OrderStatus? orderStatus,
    String? plateNumber,
    String? chassisNumber,
    String? customerName,
    String? telephoneNumber,
    int? totalCredit,
    String? readType,
    String? readFrom,
    String? generationId,
    List<FcmToken>? fcmToken,
    List<int>? userList,
    Brand? brand,
    Model? model,
    Generation? generation,
    Engine? engine,
    Ecu? ecu,
    List<OrderRequest>? orderRequests,
    List<dynamic>? orderTimedAccess,
    User? user,
    List<Message>? messages,
    List<OrderStatusLog>? orderStatusLogs,
  }) {
    return Order(
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      vehicleType: vehicleType ?? this.vehicleType,
      brandId: brandId ?? this.brandId,
      modelId: modelId ?? this.modelId,
      engineId: engineId ?? this.engineId,
      ecuId: ecuId ?? this.ecuId,
      ecuHw: ecuHw ?? this.ecuHw,
      ecuSw: ecuSw ?? this.ecuSw,
      powerHp: powerHp ?? this.powerHp,
      powerKw: powerKw ?? this.powerKw,
      torqueNm: torqueNm ?? this.torqueNm,
      year: year ?? this.year,
      transmission: transmission ?? this.transmission,
      engineType: engineType ?? this.engineType,
      tuningDevice: tuningDevice ?? this.tuningDevice,
      interestedIn: interestedIn ?? this.interestedIn,
      kilometer: kilometer ?? this.kilometer,
      customerDetails: customerDetails ?? this.customerDetails,
      orderDate: orderDate ?? this.orderDate,
      updatedAt: updatedAt ?? this.updatedAt,
      appTime: appTime ?? this.appTime,
      firstTimeInfo: firstTimeInfo ?? this.firstTimeInfo,
      lastTimeInfo: lastTimeInfo ?? this.lastTimeInfo,
      totalTimeInfo: totalTimeInfo ?? this.totalTimeInfo,
      orderStatus: orderStatus ?? this.orderStatus,
      plateNumber: plateNumber ?? this.plateNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      customerName: customerName ?? this.customerName,
      telephoneNumber: telephoneNumber ?? this.telephoneNumber,
      totalCredit: totalCredit ?? this.totalCredit,
      readType: readType ?? this.readType,
      readFrom: readFrom ?? this.readFrom,
      generationId: generationId ?? this.generationId,
      fcmToken: fcmToken ?? this.fcmToken,
      userList: userList ?? this.userList,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      generation: generation ?? this.generation,
      engine: engine ?? this.engine,
      ecu: ecu ?? this.ecu,
      orderRequests: orderRequests ?? this.orderRequests,
      orderTimedAccess: orderTimedAccess ?? this.orderTimedAccess,
      user: user ?? this.user,
      messages: messages ?? this.messages,
      orderStatusLogs: orderStatusLogs ?? this.orderStatusLogs,
    );
  }

  String getOrderTitle() {
    return "${user!.store!.city!} / ${(brand != null ? brand!.brandName! : brandId)!} ${model != null ? model!.modelName! : modelId!} ${engine != null ? engine!.engineName! : engineId!} / ${plateNumber!}";
  }

  String getOrderDescription() {
    return "${ecu != null ? ecu!.ecuName! : ecuId!}\n${orderRequests!.fold("", (a, b) => "$a\n${b.request!.description!}").replaceAll(" & ", "\n")}";
  }

  String getOrderDateText() {
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(orderDate!);
    return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String getOrderRequestsText() {
    return orderRequests!
        .fold("", (a, b) => "$a\n${b.request!.description!}")
        .toString()
        .replaceAll(" & ", "\n")
        .trim();
  }

  Future<Order> setStatus({String status = OrderStatus.waiting}) async {
    return OrdersAPI.setStatus(order: this, status: status).then((value) {
      orderStatus = value.order!.orderStatus;
      return this;
    });
  }

  Future<Order> associate() async {
    if (brand == null || model == null || engine == null || ecu == null) {
      return OrdersAPI.setAssociate(order: this).then((value) => value.order!);
    }
    return this;
  }

  Future<Order> save() async {
    return OrdersAPI.save(data: {
      "brand_id": brandId,
      "model_id": modelId,
      "generation_id": generationId,
      "engine_id": engineId,
      "ecu_id": ecuId,
      "power_hp": powerHp,
      "power_kw": powerKw,
      "torque_nm": torqueNm,
      "year": year.toString(),
      "transmission": transmission,
      "engine_type": engineType,
      "tuning_device": tuningDevice!.id.toString(),
      "kilometer": kilometer.toString(),
      "customer_details": customerDetails,
      "plate_number": plateNumber,
      "chassis_number": chassisNumber,
      "customer_name": customerName,
      "telephone_number": telephoneNumber,
      "read_type": readType,
      "read_from": readFrom,
    }).then((value) => value.order!);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Order) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      userId.hashCode ^
      orderId.hashCode ^
      vehicleType.hashCode ^
      brandId.hashCode ^
      modelId.hashCode ^
      engineId.hashCode ^
      ecuId.hashCode ^
      ecuHw.hashCode ^
      ecuSw.hashCode ^
      powerHp.hashCode ^
      powerKw.hashCode ^
      torqueNm.hashCode ^
      year.hashCode ^
      transmission.hashCode ^
      engineType.hashCode ^
      tuningDevice.hashCode ^
      interestedIn.hashCode ^
      kilometer.hashCode ^
      customerDetails.hashCode ^
      orderDate.hashCode ^
      updatedAt.hashCode ^
      orderStatus.hashCode ^
      plateNumber.hashCode ^
      chassisNumber.hashCode ^
      customerName.hashCode ^
      telephoneNumber.hashCode ^
      totalCredit.hashCode ^
      readType.hashCode ^
      readFrom.hashCode ^
      generationId.hashCode ^
      fcmToken.hashCode ^
      userList.hashCode ^
      brand.hashCode ^
      model.hashCode ^
      generation.hashCode ^
      engine.hashCode ^
      ecu.hashCode ^
      orderRequests.hashCode ^
      orderTimedAccess.hashCode ^
      user.hashCode ^
      messages.hashCode ^
      orderStatusLogs.hashCode;
}
