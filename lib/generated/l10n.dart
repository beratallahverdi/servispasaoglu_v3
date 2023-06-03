// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mechanic & Auto Parts`
  String get mechanicViewTitle {
    return Intl.message(
      'Mechanic & Auto Parts',
      name: 'mechanicViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Mechanic`
  String get mechanicViewBottomBarText {
    return Intl.message(
      'Mechanic',
      name: 'mechanicViewBottomBarText',
      desc: '',
      args: [],
    );
  }

  /// `Homepage`
  String get homeViewTitle {
    return Intl.message(
      'Homepage',
      name: 'homeViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Homepage`
  String get homeViewBottomBarText {
    return Intl.message(
      'Homepage',
      name: 'homeViewBottomBarText',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get galleryViewTitle {
    return Intl.message(
      'Gallery',
      name: 'galleryViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get galleryViewBottomBarText {
    return Intl.message(
      'Gallery',
      name: 'galleryViewBottomBarText',
      desc: '',
      args: [],
    );
  }

  /// `Chip Tuning`
  String get tuningViewTitle {
    return Intl.message(
      'Chip Tuning',
      name: 'tuningViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Chip Tuning`
  String get tuningViewBottomBarText {
    return Intl.message(
      'Chip Tuning',
      name: 'tuningViewBottomBarText',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contactViewTitle {
    return Intl.message(
      'Contact',
      name: 'contactViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contactViewBottomBarText {
    return Intl.message(
      'Contact',
      name: 'contactViewBottomBarText',
      desc: '',
      args: [],
    );
  }

  /// `Order Info`
  String get detailsViewTitle {
    return Intl.message(
      'Order Info',
      name: 'detailsViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get detailsViewBottomBarText {
    return Intl.message(
      'Details',
      name: 'detailsViewBottomBarText',
      desc: '',
      args: [],
    );
  }

  /// `Order Chat`
  String get messagesViewTitle {
    return Intl.message(
      'Order Chat',
      name: 'messagesViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messagesViewBottomBarText {
    return Intl.message(
      'Messages',
      name: 'messagesViewBottomBarText',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginPageTitle {
    return Intl.message(
      'Login',
      name: 'loginPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid username`
  String get usernameHint {
    return Intl.message(
      'Enter valid username',
      name: 'usernameHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid password`
  String get passwordHint {
    return Intl.message(
      'Enter valid password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get ordersTitle {
    return Intl.message(
      'Orders',
      name: 'ordersTitle',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Seller Name`
  String get sellerName {
    return Intl.message(
      'Seller Name',
      name: 'sellerName',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get interests {
    return Intl.message(
      'Interests',
      name: 'interests',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `ECU`
  String get ecu {
    return Intl.message(
      'ECU',
      name: 'ecu',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get model {
    return Intl.message(
      'Model',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// `Tuning Device`
  String get tuningDevice {
    return Intl.message(
      'Tuning Device',
      name: 'tuningDevice',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get stats {
    return Intl.message(
      'Stats',
      name: 'stats',
      desc: '',
      args: [],
    );
  }

  /// `Kilometer`
  String get kilometer {
    return Intl.message(
      'Kilometer',
      name: 'kilometer',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Identity`
  String get vehicleIdentity {
    return Intl.message(
      'Vehicle Identity',
      name: 'vehicleIdentity',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Customer Message`
  String get customerMessage {
    return Intl.message(
      'Customer Message',
      name: 'customerMessage',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Voice recording started. Release the button for stop.`
  String get voiceRecordingStarted {
    return Intl.message(
      'Voice recording started. Release the button for stop.',
      name: 'voiceRecordingStarted',
      desc: '',
      args: [],
    );
  }

  /// `Voice recording stoped. Sending voice...`
  String get voiceRecordingStoped {
    return Intl.message(
      'Voice recording stoped. Sending voice...',
      name: 'voiceRecordingStoped',
      desc: '',
      args: [],
    );
  }

  /// `Send a message`
  String get sendAMessage {
    return Intl.message(
      'Send a message',
      name: 'sendAMessage',
      desc: '',
      args: [],
    );
  }

  /// `Brands`
  String get brands {
    return Intl.message(
      'Brands',
      name: 'brands',
      desc: '',
      args: [],
    );
  }

  /// `Choose a brand`
  String get tuningViewBrandsHint {
    return Intl.message(
      'Choose a brand',
      name: 'tuningViewBrandsHint',
      desc: '',
      args: [],
    );
  }

  /// `Models`
  String get models {
    return Intl.message(
      'Models',
      name: 'models',
      desc: '',
      args: [],
    );
  }

  /// `Choose a model`
  String get tuningViewModelsHint {
    return Intl.message(
      'Choose a model',
      name: 'tuningViewModelsHint',
      desc: '',
      args: [],
    );
  }

  /// `Generation`
  String get generation {
    return Intl.message(
      'Generation',
      name: 'generation',
      desc: '',
      args: [],
    );
  }

  /// `Choose a generation`
  String get tuningViewGenerationHint {
    return Intl.message(
      'Choose a generation',
      name: 'tuningViewGenerationHint',
      desc: '',
      args: [],
    );
  }

  /// `Years`
  String get years {
    return Intl.message(
      'Years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Choose a year`
  String get tuningViewYearsHint {
    return Intl.message(
      'Choose a year',
      name: 'tuningViewYearsHint',
      desc: '',
      args: [],
    );
  }

  /// `Engines`
  String get engines {
    return Intl.message(
      'Engines',
      name: 'engines',
      desc: '',
      args: [],
    );
  }

  /// `Choose a engine`
  String get tuningViewEnginesHint {
    return Intl.message(
      'Choose a engine',
      name: 'tuningViewEnginesHint',
      desc: '',
      args: [],
    );
  }

  /// `Original`
  String get original {
    return Intl.message(
      'Original',
      name: 'original',
      desc: '',
      args: [],
    );
  }

  /// `Tuning`
  String get tuning {
    return Intl.message(
      'Tuning',
      name: 'tuning',
      desc: '',
      args: [],
    );
  }

  /// `Difference`
  String get difference {
    return Intl.message(
      'Difference',
      name: 'difference',
      desc: '',
      args: [],
    );
  }

  /// `Power (HP)`
  String get power {
    return Intl.message(
      'Power (HP)',
      name: 'power',
      desc: '',
      args: [],
    );
  }

  /// `Torque (NM)`
  String get torque {
    return Intl.message(
      'Torque (NM)',
      name: 'torque',
      desc: '',
      args: [],
    );
  }

  /// `Sellers to Contact`
  String get contactSellers {
    return Intl.message(
      'Sellers to Contact',
      name: 'contactSellers',
      desc: '',
      args: [],
    );
  }

  /// `Calculate completed`
  String get tuningCalculated {
    return Intl.message(
      'Calculate completed',
      name: 'tuningCalculated',
      desc: '',
      args: [],
    );
  }

  /// `Show Sellers`
  String get showSellersText {
    return Intl.message(
      'Show Sellers',
      name: 'showSellersText',
      desc: '',
      args: [],
    );
  }

  /// `File Not Found`
  String get fileNotFound {
    return Intl.message(
      'File Not Found',
      name: 'fileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsPageTitle {
    return Intl.message(
      'Settings',
      name: 'settingsPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sound`
  String get sound {
    return Intl.message(
      'Sound',
      name: 'sound',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `General Notifications`
  String get notificationsGeneral {
    return Intl.message(
      'General Notifications',
      name: 'notificationsGeneral',
      desc: '',
      args: [],
    );
  }

  /// `Order Notifications`
  String get notificationsCreateOrderTitle {
    return Intl.message(
      'Order Notifications',
      name: 'notificationsCreateOrderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Order Notifications`
  String get notificationsCreateOrderDescription {
    return Intl.message(
      'Order Notifications',
      name: 'notificationsCreateOrderDescription',
      desc: '',
      args: [],
    );
  }

  /// `Message Notifications`
  String get notificationsReceiveMessageTitle {
    return Intl.message(
      'Message Notifications',
      name: 'notificationsReceiveMessageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Message Notifications`
  String get notificationsReceiveMessageDescription {
    return Intl.message(
      'Message Notifications',
      name: 'notificationsReceiveMessageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Status Notifications`
  String get notificationsOrderStatusTitle {
    return Intl.message(
      'Status Notifications',
      name: 'notificationsOrderStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Status Notifications`
  String get notificationsOrderStatusDescription {
    return Intl.message(
      'Status Notifications',
      name: 'notificationsOrderStatusDescription',
      desc: '',
      args: [],
    );
  }

  /// `Credit is Low`
  String get creditIsLow {
    return Intl.message(
      'Credit is Low',
      name: 'creditIsLow',
      desc: '',
      args: [],
    );
  }

  /// `Credit Requests`
  String get creditRequestsViewTitle {
    return Intl.message(
      'Credit Requests',
      name: 'creditRequestsViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Credit Requests`
  String get creditRequestsViewDescription {
    return Intl.message(
      'Credit Requests',
      name: 'creditRequestsViewDescription',
      desc: '',
      args: [],
    );
  }

  /// `Requested amount of Credit: `
  String get requestedCreditDescription {
    return Intl.message(
      'Requested amount of Credit: ',
      name: 'requestedCreditDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get OK {
    return Intl.message(
      'OK',
      name: 'OK',
      desc: '',
      args: [],
    );
  }

  /// `Chip Tuning Calculator`
  String get chipTuningCalculator {
    return Intl.message(
      'Chip Tuning Calculator',
      name: 'chipTuningCalculator',
      desc: '',
      args: [],
    );
  }

  /// `Engine`
  String get engine {
    return Intl.message(
      'Engine',
      name: 'engine',
      desc: '',
      args: [],
    );
  }

  /// `Plate`
  String get plate {
    return Intl.message(
      'Plate',
      name: 'plate',
      desc: '',
      args: [],
    );
  }

  /// `Engine Type`
  String get engineType {
    return Intl.message(
      'Engine Type',
      name: 'engineType',
      desc: '',
      args: [],
    );
  }

  /// `Transmission`
  String get transmission {
    return Intl.message(
      'Transmission',
      name: 'transmission',
      desc: '',
      args: [],
    );
  }

  /// `Horsepower`
  String get horsepower {
    return Intl.message(
      'Horsepower',
      name: 'horsepower',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Chassis`
  String get chassis {
    return Intl.message(
      'Chassis',
      name: 'chassis',
      desc: '',
      args: [],
    );
  }

  /// `Order Details / DTC Codes`
  String get orderDetails {
    return Intl.message(
      'Order Details / DTC Codes',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `check the value`
  String get checkTheValue {
    return Intl.message(
      'check the value',
      name: 'checkTheValue',
      desc: '',
      args: [],
    );
  }

  /// `Unlisted Order`
  String get orderUnlisted {
    return Intl.message(
      'Unlisted Order',
      name: 'orderUnlisted',
      desc: '',
      args: [],
    );
  }

  /// `In Visible`
  String get inVisible {
    return Intl.message(
      'In Visible',
      name: 'inVisible',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Order's car types saving to database Confirm?`
  String get associateOrder {
    return Intl.message(
      'Order\'s car types saving to database Confirm?',
      name: 'associateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Car Types save to database`
  String get associateTooltip {
    return Intl.message(
      'Car Types save to database',
      name: 'associateTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'tr', countryCode: 'TR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
