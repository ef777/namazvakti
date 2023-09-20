import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namazvakti/counter_view/add_counter.dart';
import 'package:namazvakti/counter_view/counter_list_view.dart';
import 'package:namazvakti/counter_view/counter_model.dart';
import 'package:namazvakti/counter_view/databases.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/quickalert.dart';


class CounterView extends StatefulWidget {
  const CounterView({key, this.counterModel});
  final CounterModel? counterModel;
  @override
  State<CounterView> createState() => _CounterViewState();
}

int counterText = 0;

class _CounterViewState extends State<CounterView> {
 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  void initState() {
    counterText = int.parse(widget.counterModel?.start ?? "0");
    endPoint = int.parse(widget.counterModel?.finish ?? "99999");

    super.initState();
  }

 

  @override
  void dispose() {
   
    super.dispose();
  }

  var endPoint;
  void incrementCounter() {
    counterText++; // sayaç değişkenini arttır
    if (counterText == endPoint) {

      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Belirlediğiniz durağa geldiniz',
          confirmBtnText: "Tamam");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CounterListView())),
              ),
            ),
          ),
          leadingWidth: 64,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCounter(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 76),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ListView(
              children: [
                Center(
                  child: Text(
                    widget.counterModel?.title ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 245, 244, 244),
                      ),
                      onPressed: () {
                        QuickAlert.show(
                          title: 'Durak Ekle',
                          context: context,
                          type: QuickAlertType.custom,
                          barrierDismissible: true,
                          confirmBtnText: 'Kaydet',
                          customAsset: 'assets/mosque1.jpg',
                          widget: TextFormField(
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: 'Lütfen bir durak belirleyiniz',
                                hintStyle: Theme.of(context).textTheme.caption,
                                prefixIcon:
                                    Icon(FontAwesomeIcons.penNib, size: 16),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              onChanged: (value) =>
                                  endPoint = int.parse(value)),
                          onConfirmBtnTap: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 300));
                            await QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                title: "Durak Eklendi",
                                confirmBtnText: "Tamam");
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: Text(
                        "Durak Ekle",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                ),
                Container(
                  height: 400,
                  width: 360,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/zikirmatik.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 104,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: 180,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 129, 129, 127),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  counterText.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                          ),
                          ButtonContainer(
                              onPressed: () => setState(() {
                                    if (counterText == 0) return;
                                    counterText--;
                                  }),
                              icon: Icon(
                                Icons.refresh,
                              )),
                          Spacer(),
                          ButtonContainer(
                              onPressed: () => setState(() {
                                    counterText = 0;
                                  }),
                              icon: Icon(
                                Icons.rotate_left_sharp,
                              )),
                          SizedBox(
                            width: 90,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                          onTap: () => setState(() {
                            incrementCounter();
                            DatabaseHelper.instance.update(
                                widget.counterModel?.id ?? 0,
                                counterText.toString());
                          }),
                          child: Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                color: Color.fromARGB(255, 210, 210, 209),
                                shape: BoxShape.circle),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
        
          ],
        ),
      ),
    );
  }
}

class ButtonContainer extends StatefulWidget {
  const ButtonContainer({key, required this.icon, this.onPressed});
  final Icon icon;
  final void Function()? onPressed;
  @override
  State<ButtonContainer> createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 204, 203, 203).withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ], color: Color.fromARGB(255, 226, 224, 222), shape: BoxShape.circle),
      child: IconButton(onPressed: widget.onPressed, icon: widget.icon),
    );
  }
}
