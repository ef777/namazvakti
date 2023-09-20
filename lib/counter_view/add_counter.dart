import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namazvakti/counter_view/counter_model.dart';
import 'package:namazvakti/counter_view/databases.dart';


class AddCounter extends StatefulWidget {
  const AddCounter({key});

  @override
  State<AddCounter> createState() => _AddCounterState();
}

class _AddCounterState extends State<AddCounter> {
  static const _insets = 16.0;

  late Orientation _currentOrientation;

  double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController titleCont = TextEditingController();
  TextEditingController startCont = TextEditingController();
  TextEditingController finishCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color.fromRGBO(27, 41, 86, 1),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 175, 39, 39),
            ),
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.xmark,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        leadingWidth: 64,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 9, 190, 57),
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final person1 = CounterModel(
                        title: titleCont.text,
                        start: startCont.text,
                        finish: finishCont.text);

                    await DatabaseHelper.instance
                        .insert(person1.toMap())
                        .then((value) => Navigator.pop(context));
                  }),
            ),
          ),
        ],
        title: Text(
          'main.add_dhikr'.tr(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 32,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: titleCont,
                      decoration: InputDecoration(
                          hintText: 'main.please_enter_title'.tr(),
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: startCont,
                        decoration: InputDecoration(
                            hintText: 'main.please_enter_initial_value'.tr(),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: finishCont,
                        decoration: InputDecoration(
                            hintText: 'main.please_enter_target_value'.tr(),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600))),
                  ),
                ],
              )),
          SizedBox(
            height: 64,
          ),
        ],
      ),
    );
  }
}
