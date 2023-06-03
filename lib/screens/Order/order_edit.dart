import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/api/order.dart';
import 'package:servispasaoglu_v3/api/tuning_devices.dart';
import 'package:servispasaoglu_v3/classes/brand.dart';
import 'package:servispasaoglu_v3/classes/ecu.dart';
import 'package:servispasaoglu_v3/classes/engine.dart';
import 'package:servispasaoglu_v3/classes/generation.dart';
import 'package:servispasaoglu_v3/classes/logged_user.dart';
import 'package:servispasaoglu_v3/classes/model.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/classes/requests_with_order_request.dart';
import 'package:servispasaoglu_v3/classes/tuning_device.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';

class OrderEdit extends StatefulWidget {
  final ServisPasaogluUser user;
  final Order order;
  const OrderEdit(this.order, this.user, {Key? key}) : super(key: key);
  @override
  State<OrderEdit> createState() => _OrderEditState();
}

class _OrderEditState extends State<OrderEdit> {
  Map<String, TextEditingController> textControllers = {};
  bool _brandFound = true;
  final List<DropdownMenuItem<Brand>> _brandItems = [];
  bool _modelFound = true;
  final List<DropdownMenuItem<Model>> _modelItems = [];
  bool _generationFound = true;
  final List<DropdownMenuItem<Generation>> _generationItems = [];
  bool _engineFound = true;
  final List<DropdownMenuItem<Engine>> _engineItems = [];
  bool _ecuFound = true;
  final List<DropdownMenuItem<Ecu>> _ecuItems = [];
  final List<DropdownMenuItem<TuningDevice>> _tuningDeviceItems = [];
  final List<RequestsWithOrderRequest> _requestItems = [];
  final Map<int, bool> selectedRequestItems = {};

  @override
  void initState() {
    textControllers['brand'] = TextEditingController(
        text: widget.order.brand != null
            ? widget.order.brand!.brandName
            : widget.order.brandId);
    textControllers['model'] = TextEditingController(
        text: widget.order.model != null
            ? widget.order.model!.modelName
            : widget.order.modelId);
    textControllers['generation'] = TextEditingController(
        text: widget.order.generation != null
            ? widget.order.generation!.generationName
            : widget.order.generationId);
    textControllers['engine'] = TextEditingController(
        text: widget.order.engine != null
            ? widget.order.engine!.engineName
            : widget.order.engineId);
    textControllers['ecu'] = TextEditingController(
        text: widget.order.ecu != null
            ? widget.order.ecu!.ecuName
            : widget.order.ecuId);
    textControllers['powerHp'] =
        TextEditingController(text: "${widget.order.powerHp}");

    textControllers['powerKw'] =
        TextEditingController(text: "${widget.order.powerKw}");
    textControllers['torqueNm'] =
        TextEditingController(text: "${widget.order.torqueNm}");
    textControllers['torqueNm']!.addListener(torqueInputCheck);
    textControllers['year'] =
        TextEditingController(text: "${widget.order.year}");
    textControllers['year']!.addListener(yearInputCheck);
    textControllers['engineType'] =
        TextEditingController(text: widget.order.engineType ?? "");
    textControllers['engineType']!.addListener(() {
      if (textControllers['engineType']!.text.isNotEmpty) {
        setState(() {
          widget.order.setFuelType = textControllers['engineType']!.text;
        });
      }
    });

    textControllers['plateNumber'] =
        TextEditingController(text: "${widget.order.plateNumber}");
    textControllers['plateNumber']!.addListener(() {
      if (textControllers['plateNumber']!.text.isNotEmpty) {
        setState(() {
          widget.order.plateNumber = textControllers['plateNumber']!.text;
        });
      }
    });
    textControllers['kilometer'] =
        TextEditingController(text: "${widget.order.kilometer}");
    textControllers['kilometer']!.addListener(() {
      if (textControllers['kilometer']!.text.isNotEmpty) {
        setState(() {
          widget.order.kilometer =
              int.tryParse(textControllers['kilometer']!.text) ?? 0;
        });
      }
    });
    textControllers['chassisNumber'] =
        TextEditingController(text: "${widget.order.chassisNumber}");
    textControllers['chassisNumber']!.addListener(() {
      if (textControllers['chassisNumber']!.text.isNotEmpty) {
        setState(() {
          widget.order.chassisNumber = textControllers['chassisNumber']!.text;
        });
      }
    });
    textControllers['customerName'] =
        TextEditingController(text: "${widget.order.customerName}");
    textControllers['customerName']!.addListener(() {
      if (textControllers['customerName']!.text.isNotEmpty) {
        setState(() {
          widget.order.customerName = textControllers['customerName']!.text;
        });
      }
    });
    textControllers['telephoneNumber'] =
        TextEditingController(text: "${widget.order.telephoneNumber}");
    textControllers['telephoneNumber']!.addListener(() {
      if (textControllers['telephoneNumber']!.text.isNotEmpty) {
        setState(() {
          widget.order.telephoneNumber =
              textControllers['telephoneNumber']!.text;
        });
      }
    });

    OrdersAPI.typesGetFromOrder(widget.order).then((typesResponse) {
      setState(() {
        for (var element in typesResponse.data!.brand!) {
          _brandItems.add(DropdownMenuItem(
              value: element, child: Text(element.brandName!)));
        }
        for (var element in typesResponse.data!.model!) {
          _modelItems.add(DropdownMenuItem(
              value: element, child: Text(element.modelName!)));
        }
        for (var element in typesResponse.data!.generation!) {
          _generationItems.add(DropdownMenuItem(
              value: element, child: Text(element.generationName!)));
        }
        for (var element in typesResponse.data!.engine!) {
          _engineItems.add(DropdownMenuItem(
              value: element, child: Text(element.engineName!)));
        }
        for (var element in typesResponse.data!.ecu!) {
          _ecuItems.add(
              DropdownMenuItem(value: element, child: Text(element.ecuName!)));
        }
      });
    });
    TuningDevicesAPI.getTuningDevices().then((tuningDevices) {
      setState(() {
        for (var element in tuningDevices) {
          _tuningDeviceItems.add(DropdownMenuItem(
              value: element,
              child: Text("${element.group} ${element.description}")));
        }
      });
    });
    OrdersAPI.getRequestsWithOrder(widget.order).then((requests) {
      setState(() {
        for (var element in requests) {
          _requestItems.add(element);
          selectedRequestItems[element.id!] =
              ((element.selected! == 1) ? false : true);
        }
      });
    });
    super.initState();
  }

  void yearInputCheck() {
    if (textControllers['year']!.text.isNotEmpty) {
      int year = int.parse(textControllers['year']!.text);
      if (year > (DateTime.now().year) + 1) {
        textControllers['year']!.text = "${(DateTime.now().year + 1)}";
      } else if (year < 1950) {
        textControllers['year']!.text = "1950";
      } else {
        textControllers['year']!.text = "$year";
      }
    }
  }

  void torqueInputCheck() {
    if (textControllers['torqueNm']!.text.isNotEmpty) {
      setState(() {
        widget.order.torqueNm = textControllers['torqueNm']!.text;
      });
    }
  }

  void kwInputCheck() {
    if (textControllers['powerKw']!.text.isNotEmpty) {
      setState(() {
        int pKw = int.tryParse(textControllers['powerKw']!.text) ?? 0;
        int pHp = (pKw * 1.343436).toInt();
        widget.order.setPowerHp = pHp.toString();
        widget.order.setPowerKw = pKw.toString();
        textControllers['powerHp']!.text = pHp.toString();
      });
    }
  }

  void hpInputCheck() {
    if (textControllers['powerHp']!.text.isNotEmpty) {
      setState(() {
        int pHp = int.tryParse(textControllers['powerHp']!.text) ?? 0;
        int pKw = pHp ~/ 1.343436;
        widget.order.setPowerHp = pHp.toString();
        widget.order.setPowerKw = pKw.toString();
        textControllers['powerKw']!.text = pKw.toString();
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    for (var element in textControllers.values) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Car Info',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.maxFinite,
                  child: Column(children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _brandFound && _brandItems.isNotEmpty
                              ? DropdownButton<Brand>(
                                  items: _brandItems,
                                  menuMaxHeight:
                                      MediaQuery.of(context).size.height * 0.33,
                                  onChanged: (Brand? value) {
                                    value!.getModels().then((modelsResponse) {
                                      setState(() {
                                        widget.order.setBrandId =
                                            value.brandId.toString();
                                        widget.order.setBrand = value;
                                        _modelItems.clear();
                                        _modelItems.add(DropdownMenuItem(
                                            value: null,
                                            child: Text(
                                                modelsResponse.isNotEmpty
                                                    ? 'Select a model'
                                                    : 'No models found')));
                                        _generationItems.clear();
                                        _generationItems.add(
                                            const DropdownMenuItem(
                                                value: null,
                                                child: Text(
                                                    'No generations found')));
                                        _engineItems.clear();
                                        _engineItems.add(const DropdownMenuItem(
                                            value: null,
                                            child: Text('No engines found')));
                                        _ecuItems.clear();
                                        _ecuItems.add(const DropdownMenuItem(
                                            value: null,
                                            child: Text('No ecus found')));
                                        for (var element in modelsResponse) {
                                          _modelItems.add(DropdownMenuItem(
                                              value: element,
                                              child: Text(element.modelName!)));
                                        }
                                        widget.order.setEcu = null;
                                        widget.order.setEcuId = null;
                                        widget.order.setEngine = null;
                                        widget.order.setEngineId = null;
                                        widget.order.setGeneration = null;
                                        widget.order.setGenerationId = null;
                                        widget.order.setModel = null;
                                        widget.order.setModelId = null;
                                        _modelFound = modelsResponse.isNotEmpty;
                                        _generationFound =
                                            modelsResponse.isNotEmpty;
                                        _engineFound =
                                            modelsResponse.isNotEmpty;
                                        _ecuFound = modelsResponse.isNotEmpty;
                                      });
                                    });
                                  },
                                  value: widget.order.brand,
                                  isExpanded: true,
                                  hint:
                                      Text(S.of(context).tuningViewBrandsHint),
                                )
                              : TextField(
                                  controller: textControllers['brand'],
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  onChanged: (value) => setState(() {
                                    widget.order.setBrandId = value;
                                  }),
                                  decoration: InputDecoration(
                                    labelText: S.of(context).brands,
                                    border: const OutlineInputBorder(),
                                    hintText: 'Enter a brand name',
                                  ),
                                ),
                        ),
                        Checkbox(
                          value: _brandFound,
                          onChanged: (bool? value) {
                            setState(() {
                              _brandFound = value!;
                            });
                          },
                        ),
                      ],
                    )
                  ]),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _modelFound && _modelItems.isNotEmpty
                          ? DropdownButton<Model>(
                              items: _modelItems,
                              menuMaxHeight:
                                  MediaQuery.of(context).size.height * 0.33,
                              onChanged: (Model? value) {
                                value!.getGenerations().then((modelsResponse) {
                                  setState(() {
                                    widget.order.setModelId =
                                        value.modelId.toString();
                                    widget.order.setModel = value;
                                    _generationItems.clear();
                                    _generationItems.add(DropdownMenuItem(
                                        value: null,
                                        child: Text(modelsResponse.isNotEmpty
                                            ? 'Select a generation'
                                            : 'No generations found')));
                                    _engineItems.clear();
                                    _engineItems.add(const DropdownMenuItem(
                                        value: null,
                                        child: Text('No engines found')));
                                    _ecuItems.clear();
                                    _ecuItems.add(const DropdownMenuItem(
                                        value: null,
                                        child: Text('No ecus found')));
                                    for (var element in modelsResponse) {
                                      _generationItems.add(DropdownMenuItem(
                                          value: element,
                                          child:
                                              Text(element.generationName!)));
                                    }
                                    widget.order.setEcu = null;
                                    widget.order.setEcuId = null;
                                    widget.order.setEngine = null;
                                    widget.order.setEngineId = null;
                                    widget.order.setGeneration = null;
                                    widget.order.setGenerationId = null;
                                    _generationFound =
                                        modelsResponse.isNotEmpty;
                                    _engineFound = modelsResponse.isNotEmpty;
                                    _ecuFound = modelsResponse.isNotEmpty;
                                  });
                                });
                              },
                              value: widget.order.model,
                              isExpanded: true,
                              hint: Text(S.of(context).tuningViewModelsHint),
                            )
                          : TextField(
                              controller: textControllers['model'],
                              textCapitalization: TextCapitalization.characters,
                              onChanged: (value) => setState(() {
                                widget.order.setModelId = value;
                              }),
                              decoration: InputDecoration(
                                labelText: S.of(context).model,
                                border: const OutlineInputBorder(),
                                hintText: 'Enter a model name',
                              ),
                            ),
                    ),
                    Checkbox(
                      value: _modelFound,
                      onChanged: (bool? value) {
                        setState(() {
                          _modelFound = value!;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.maxFinite,
                  child: Column(children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _generationFound && _generationItems.isNotEmpty
                              ? DropdownButton<Generation>(
                                  items: _generationItems,
                                  menuMaxHeight:
                                      MediaQuery.of(context).size.height * 0.33,
                                  onChanged: (Generation? value) {
                                    value!.getEngines().then((modelsResponse) {
                                      setState(() {
                                        widget.order.setGenerationId =
                                            value.generationId.toString();
                                        widget.order.setGeneration = value;
                                        _engineItems.clear();
                                        _engineItems.add(DropdownMenuItem(
                                            value: null,
                                            child: Text(
                                                modelsResponse.isNotEmpty
                                                    ? 'Select a engine'
                                                    : 'No engines found')));
                                        _ecuItems.clear();
                                        _ecuItems.add(const DropdownMenuItem(
                                            value: null,
                                            child: Text('No ecus found')));
                                        for (var element in modelsResponse) {
                                          _engineItems.add(DropdownMenuItem(
                                              value: element,
                                              child:
                                                  Text(element.engineName!)));
                                        }
                                        widget.order.setEcu = null;
                                        widget.order.setEcuId = null;
                                        widget.order.setEngine = null;
                                        widget.order.setEngineId = null;
                                        _engineFound =
                                            modelsResponse.isNotEmpty;
                                        _ecuFound = modelsResponse.isNotEmpty;
                                      });
                                    });
                                  },
                                  value: widget.order.generation,
                                  isExpanded: true,
                                  hint:
                                      Text(S.of(context).tuningViewModelsHint),
                                )
                              : TextField(
                                  controller: textControllers['generation'],
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  onChanged: (value) => setState(() {
                                    widget.order.setGenerationId = value;
                                  }),
                                  decoration: const InputDecoration(
                                    labelText: 'Generation',
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter a generation name',
                                  ),
                                ),
                        ),
                        Checkbox(
                          value: _generationFound,
                          onChanged: (bool? value) {
                            setState(() {
                              _generationFound = value!;
                            });
                          },
                        ),
                      ],
                    )
                  ]),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _engineFound && _engineItems.isNotEmpty
                              ? DropdownButton<Engine>(
                                  items: _engineItems,
                                  menuMaxHeight:
                                      MediaQuery.of(context).size.height * 0.33,
                                  onChanged: (Engine? value) {
                                    value!.getEcus().then((modelsResponse) {
                                      setState(() {
                                        widget.order.setEcu = null;
                                        widget.order.setEcuId = null;
                                        _ecuItems.clear();
                                        _ecuItems.add(DropdownMenuItem(
                                            value: null,
                                            child: Text(
                                                modelsResponse.isNotEmpty
                                                    ? 'Select a ecu'
                                                    : 'No ecus found')));
                                        widget.order.setEngineId =
                                            value.engineId.toString();
                                        widget.order.setEngine = value;
                                        textControllers['powerHp']!.text =
                                            value.power!.standard.toString();
                                        textControllers['powerKw']!.text =
                                            ((value.power!.standard ?? 0) ~/
                                                    1.343436)
                                                .toString();
                                        textControllers['engineType']!.text =
                                            "${value.fuelType}";
                                        textControllers['torqueNm']!.text =
                                            value.torque!.standard.toString();
                                        for (var element in modelsResponse) {
                                          _ecuItems.add(DropdownMenuItem(
                                              value: element,
                                              child: Text(element.ecuName!)));
                                        }
                                        _ecuFound = modelsResponse.isNotEmpty;
                                      });
                                    });
                                  },
                                  value: widget.order.engine,
                                  isExpanded: true,
                                  hint:
                                      Text(S.of(context).tuningViewEnginesHint),
                                )
                              : TextField(
                                  controller: textControllers['engine'],
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  onChanged: (value) => setState(() {
                                    widget.order.setEngineId = value;
                                  }),
                                  decoration: InputDecoration(
                                    labelText: S.of(context).engine,
                                    border: const OutlineInputBorder(),
                                    hintText: 'Enter a engine name',
                                  ),
                                ),
                        ),
                        Checkbox(
                          value: _engineFound,
                          onChanged: (bool? value) {
                            setState(() {
                              _engineFound = value!;
                            });
                          },
                        ),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _ecuFound && _ecuItems.isNotEmpty
                              ? DropdownButton<Ecu>(
                                  items: _ecuItems,
                                  menuMaxHeight:
                                      MediaQuery.of(context).size.height * 0.33,
                                  onChanged: (Ecu? value) {
                                    setState(() {
                                      widget.order.setEcuId =
                                          value!.ecuId.toString();
                                      widget.order.setEcu = value;
                                    });
                                  },
                                  value: widget.order.ecu,
                                  isExpanded: true,
                                  hint:
                                      Text(S.of(context).tuningViewModelsHint),
                                )
                              : TextField(
                                  controller: textControllers['ecu'],
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  onChanged: (value) => setState(() {
                                    widget.order.setEcuId = value;
                                  }),
                                  decoration: InputDecoration(
                                    labelText: S.of(context).ecu,
                                    border: const OutlineInputBorder(),
                                    hintText: 'Enter a Ecu name',
                                  ),
                                ),
                        ),
                        Checkbox(
                          value: _ecuFound,
                          onChanged: (bool? value) {
                            setState(() {
                              _ecuFound = value!;
                            });
                          },
                        ),
                      ],
                    )),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Power Info',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Card(
              child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: TextField(
                      controller: textControllers['powerHp'],
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(() {
                        int pHp =
                            int.tryParse(textControllers['powerHp']!.text) ?? 0;
                        int pKw = pHp ~/ 1.343436;
                        widget.order.setPowerHp = pHp.toString();
                        widget.order.setPowerKw = pKw.toString();
                        textControllers['powerKw']!.text = pKw.toString();
                      }),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: S.of(context).power,
                        hintText: S.of(context).power,
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.maxFinite,
                  child: TextField(
                    controller: textControllers['powerKw'],
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {
                      int pKw =
                          int.tryParse(textControllers['powerKw']!.text) ?? 0;
                      int pHp = (pKw * 1.343436).toInt();
                      widget.order.setPowerHp = pHp.toString();
                      widget.order.setPowerKw = pKw.toString();
                      textControllers['powerHp']!.text = pHp.toString();
                    }),
                    decoration: InputDecoration(
                      labelText: S.of(context).power,
                      border: const OutlineInputBorder(),
                      hintText: S.of(context).power,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.maxFinite,
                  child: TextField(
                    controller: textControllers['torqueNm'],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: S.of(context).torque,
                      border: const OutlineInputBorder(),
                      hintText: S.of(context).torque,
                    ),
                  ),
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Production Info',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Card(
              child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: TextField(
                      controller: textControllers['engineType'],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: S.of(context).engineType,
                        hintText: S.of(context).engineType,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: TextField(
                      controller: textControllers['year'],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: S.of(context).years,
                        hintText: S.of(context).years,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: DropdownButton<String>(
                      items: ["Automatic", "Manual"]
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() {
                        widget.order.setTransmission = value!;
                      }),
                      value:
                          "${widget.order.transmission!.substring(0, 1).toUpperCase()}${widget.order.transmission!.substring(1)}",
                      isExpanded: true,
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.33,
                      hint: Text(S.of(context).transmission),
                    )),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Unique Info',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Card(
              child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: TextField(
                      controller: textControllers['plateNumber'],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: S.of(context).plate,
                        hintText: S.of(context).plate,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: TextField(
                      controller: textControllers['kilometer'],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: S.of(context).kilometer,
                        hintText: S.of(context).kilometer,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: TextField(
                      controller: textControllers['chassisNumber'],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: S.of(context).chassis,
                        hintText: S.of(context).chassis,
                        // suffixIcon: IconButton(
                        //     icon: const Icon(Icons.camera_alt),
                        //     onPressed: () {
                        //       ImagePicker picker = ImagePicker();
                        //       picker
                        //           .pickImage(
                        //               source: ImageSource.camera,
                        //               imageQuality: 100,
                        //               maxWidth: 1000)
                        //           .then((file) {
                        //             return file!.path;
                        //           })
                        //           .then(
                        //               (bytes) => InputImage.fromFilePath(bytes))
                        //           .then((inputImage) =>
                        //               textDetector.processImage(inputImage))
                        //           .then((recognisedText) => recognisedText
                        //                   .blocks
                        //                   .map((e) => e.text)
                        //                   .where((e) {
                        //                 RegExp regex = RegExp(
                        //                     r'[A-Za-z0-9]{8}[A-Za-z0-9][A-Za-z0-9]{2}[0-9]{6}',
                        //                     caseSensitive: false,
                        //                     multiLine: false);
                        //                 return regex
                        //                     .hasMatch(e.replaceAll(' ', ''));
                        //               }).toList())
                        //           .then((value) => showModalBottomSheet<void>(
                        //                 shape: RoundedRectangleBorder(
                        //                     borderRadius:
                        //                         BorderRadius.circular(10)),
                        //                 isDismissible: true,
                        //                 isScrollControlled: true,
                        //                 context: context,
                        //                 builder: (BuildContext context) {
                        //                   return Container(
                        //                       padding: const EdgeInsets.all(16),
                        //                       height: MediaQuery.of(context)
                        //                               .size
                        //                               .height *
                        //                           0.33,
                        //                       child: ListView.builder(
                        //                           itemCount: value.length,
                        //                           itemBuilder:
                        //                               (context, index) {
                        //                             return ListTile(
                        //                               title: Text(value[index]),
                        //                               onTap: () {
                        //                                 Navigator.pop(context);
                        //                                 textControllers[
                        //                                         'chassisNumber']!
                        //                                     .text = value[
                        //                                         index]
                        //                                     .toUpperCase()
                        //                                     .replaceAll(' ', '')
                        //                                     .trim();
                        //                               },
                        //                             );
                        //                           }));
                        //                 },
                        //               ));
                        //     }),
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: TextField(
                      controller: textControllers['customerName'],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: S.of(context).customer,
                        hintText: S.of(context).customer,
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.maxFinite,
                    child: TextField(
                      controller: textControllers['telephoneNumber'],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: S.of(context).phone,
                        hintText: S.of(context).phone,
                      ),
                    )),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Tuning Device',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Card(
              child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(children: <Widget>[
                  Expanded(
                      child: RadioListTile<String>(
                    title: const Text('Slave'),
                    value: 'Slave',
                    groupValue:
                        "${widget.order.readType!.substring(0, 1).toUpperCase()}${widget.order.readType!.substring(1)}",
                    onChanged: (String? value) {
                      setState(() {
                        widget.order.setReadType = value;
                      });
                    },
                  )),
                  Expanded(
                      child: RadioListTile<String>(
                    title: const Text('Master'),
                    value: 'Master',
                    groupValue:
                        "${widget.order.readType!.substring(0, 1).toUpperCase()}${widget.order.readType!.substring(1)}",
                    onChanged: (String? value) {
                      setState(() {
                        widget.order.setReadType = value;
                      });
                    },
                  )),
                ]),
                Row(children: <Widget>[
                  Expanded(
                      child: RadioListTile<String>(
                    title: const Text('Real'),
                    value: 'Real',
                    groupValue:
                        "${widget.order.readFrom!.substring(0, 1).toUpperCase()}${widget.order.readFrom!.substring(1)}",
                    onChanged: (String? value) {
                      setState(() {
                        widget.order.setReadFrom = value;
                      });
                    },
                  )),
                  Expanded(
                      child: RadioListTile<String>(
                    title: const Text('Virtual'),
                    value: 'Virtual',
                    groupValue:
                        "${widget.order.readFrom!.substring(0, 1).toUpperCase()}${widget.order.readFrom!.substring(1)}",
                    onChanged: (String? value) {
                      setState(() {
                        widget.order.setReadFrom = value;
                      });
                    },
                  )),
                ]),
                (_tuningDeviceItems.isNotEmpty)
                    ? DropdownButton<TuningDevice>(
                        menuMaxHeight:
                            MediaQuery.of(context).size.height * 0.33,
                        items: _tuningDeviceItems,
                        isExpanded: true,
                        onChanged: (tuningDevice) => setState(() {
                          widget.order.setTuningDevice = tuningDevice;
                        }),
                        value: widget.order.tuningDevice,
                      )
                    : const CircularProgressIndicator()
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Requests",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _requestItems
                  .where((element) => element.selected == 0 ? false : true)
                  .isNotEmpty
              ? Card(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _requestItems
                            .where((element) =>
                                element.selected == 0 ? false : true)
                            .length,
                        itemBuilder: (context, index) {
                          var item = _requestItems.firstWhere((element) =>
                              element.id ==
                              _requestItems
                                  .where((element) =>
                                      element.selected == 0 ? false : true)
                                  .elementAt(index)
                                  .id);
                          return CheckboxListTile(
                            value: _requestItems
                                        .firstWhere(
                                            (element) => element.id == item.id)
                                        .selected ==
                                    1
                                ? true
                                : false,
                            onChanged: (bool? value) => setState(() {
                              _requestItems
                                  .firstWhere(
                                      (element) => element.id == item.id)
                                  .selected = value == true ? 1 : 0;
                            }),
                            title: Text(item.description!),
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        },
                      )))
              : Container(),
          _requestItems
                  .where((element) => element.selected == 1 ? false : true)
                  .isNotEmpty
              ? Card(
                  child: Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _requestItems
                        .where(
                            (element) => element.selected == 0 ? true : false)
                        .length,
                    itemBuilder: (context, index) {
                      var item = _requestItems
                          .where(
                              (element) => element.selected == 0 ? true : false)
                          .elementAt(index);
                      return CheckboxListTile(
                        value: _requestItems
                                    .firstWhere(
                                        (element) => element.id == item.id)
                                    .selected ==
                                1
                            ? true
                            : false,
                        onChanged: (bool? value) => setState(() {
                          _requestItems
                              .firstWhere((element) => element.id == item.id)
                              .selected = value == true ? 1 : 0;
                        }),
                        title: Text(item.description!),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  ),
                ))
              : Container(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Send'),
                onPressed: () => widget.order.save(),
              )),
        ]));
  }
}
