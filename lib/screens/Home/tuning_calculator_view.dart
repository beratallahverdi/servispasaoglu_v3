import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/api/tuning.dart';
import 'package:servispasaoglu_v3/classes/stage.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';
import 'package:servispasaoglu_v3/utils/data.dart';

class TuningCalculatorView extends StatefulWidget {
  const TuningCalculatorView({Key? key}) : super(key: key);

  @override
  State<TuningCalculatorView> createState() => _TuningCalculatorViewState();
}

class _TuningCalculatorViewState extends State<TuningCalculatorView> {
  final Map<String, dynamic> _ctBrands = <String, dynamic>{};
  final Map<String, dynamic> _ctModels = <String, dynamic>{};
  final Map<String, dynamic> _ctYears = <String, dynamic>{};
  final Map<String, dynamic> _ctEngines = <String, dynamic>{};
  final Map<String, dynamic> result = <String, dynamic>{};
  bool _isLoading = true;
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedYear;
  String? _selectedEngine;

  @override
  void initState() {
    ServisPasaogluData.sharedPrefs
        .then((prefs) async {
          if (prefs.getString("chipTuningData") != null) {
            return prefs.getString("chipTuningData")!;
          } else {
            String? json = await TuningAPI.fetchChipTuningData();
            prefs.setString("chipTuningData", json!);
            return json;
          }
        })
        .then((res) => setState(() {
              _ctBrands.addAll(json.decode(res));
              _isLoading = false;
            }))
        .catchError((err) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Error: ${err.toString()}"),
            duration: const Duration(seconds: 3),
          ));
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.maxFinite,
            child: Text(
              S.of(context).chipTuningCalculator,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          (_isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Text(
                                        S.of(context).brands,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  DropdownButton(
                                    value: _selectedBrand,
                                    items: _ctBrands.keys
                                        .map((key) => DropdownMenuItem(
                                              value: key,
                                              child: Text(key),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedBrand = value as String;
                                        _selectedModel = null;
                                        _selectedYear = null;
                                        _selectedEngine = null;
                                        _ctModels.clear();
                                        result.clear();
                                        _ctEngines.clear();
                                        _ctYears.clear();
                                        _ctModels.addAll(_ctBrands[value]);
                                      });
                                    },
                                    menuMaxHeight: 300,
                                    enableFeedback: true,
                                  ),
                                ]),
                          ),
                          (_ctModels.isNotEmpty)
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16),
                                            child: Text(
                                              S.of(context).models,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        DropdownButton(
                                          value: _selectedModel,
                                          items: _ctModels.keys
                                              .map((key) => DropdownMenuItem(
                                                    value: key,
                                                    child: Text(key),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedModel = value as String;
                                              _selectedYear = null;
                                              _selectedEngine = null;
                                              result.clear();
                                              _ctEngines.clear();
                                              _ctYears.clear();
                                              _ctYears.addAll(_ctModels[value]);
                                            });
                                          },
                                          menuMaxHeight: 300,
                                          enableFeedback: true,
                                        )
                                      ]))
                              : Container(),
                          (_ctYears.isNotEmpty)
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16),
                                            child: Text(
                                              S.of(context).years,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        DropdownButton(
                                          value: _selectedYear,
                                          items: _ctYears.keys
                                              .map((key) => DropdownMenuItem(
                                                    value: key,
                                                    child: Text(key),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedYear = value as String;
                                              _selectedEngine = null;
                                              result.clear();
                                              _ctEngines.clear();
                                              _ctEngines
                                                  .addAll(_ctYears[value]);
                                            });
                                          },
                                          menuMaxHeight: 300,
                                          enableFeedback: true,
                                        )
                                      ]))
                              : Container(),
                          (_ctEngines.isNotEmpty)
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16),
                                            child: Text(
                                              S.of(context).engines,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        DropdownButton(
                                          value: _selectedEngine,
                                          items: _ctEngines.keys
                                              .map((key) => DropdownMenuItem(
                                                    value: key,
                                                    child: Text(key),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedEngine = value as String;
                                              result.clear();
                                              result.addAll(_ctEngines[value]);
                                            });
                                          },
                                          menuMaxHeight: 300,
                                          enableFeedback: true,
                                        )
                                      ]))
                              : Container(),
                        ],
                      )),
                ),
          (result.isNotEmpty)
              ? Column(
                  children: result.keys.map((key) {
                    Stage stage = Stage(
                      title: key.replaceAll("Stage", "Stage "),
                      fullname: result[key]["fullname"],
                      ecu: result[key]["ECU"],
                      fuel: result[key]["fuel"],
                      originalPower: result[key]["original_power"],
                      tuningPower: result[key]["tuning_power"],
                      originalTorque: result[key]["original_torque"],
                      tuningTorque: result[key]["tuning_torque"],
                    );
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(children: [
                        Text(
                          "${stage.title}: ${stage.fullname}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              S.of(context).power,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        Card(
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 150,
                                child: Container())),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            S.of(context).torque,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Card(
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 150,
                                child: Container())),
                      ]),
                    );
                  }).toList(),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
