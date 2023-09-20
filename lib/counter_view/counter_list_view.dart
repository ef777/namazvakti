import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namazvakti/counter_view/databases.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'counter_model.dart';

class CounterListView extends StatefulWidget {
  const CounterListView({key});

  @override
  State<CounterListView> createState() => _CounterListViewState();
}

class _CounterListViewState extends State<CounterListView> {
  @override
  List<CounterModel> _people = [];
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
    _queryPeople();

    super.initState();
    // AdMob hesap kimliğinizi buraya ekleyin.
  }

  Future<void> _queryPeople() async {
    final people = await DatabaseHelper.instance.queryAllRows();
    setState(() {
      _people = people;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: _people.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 10,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListWidget(
                      finish: _people[index].finish,
                      title: _people[index].title,
                      start: _people[index].start,
                      counterModel: _people[index],
                      onPressed: () => setState(() {
                        DatabaseHelper.instance.delete(_people[index].id ?? 0);
                        _queryPeople();
                      }),
                    );
                  },
                ),
              ),
          
            ],
          ),
        ));
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
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
      title: Text(
        'main.my_list_dhikrmatic'.tr(),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
      ),
    );
  }
}

class ListWidget extends StatefulWidget {
  const ListWidget({
    Key? key,
    required this.title,
    required this.finish,
    required this.start,
    required this.counterModel,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final String finish;
  final String start;
  final void Function()? onPressed;
  final CounterModel counterModel;

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    var deger = (
        // ignore: unnecessary_null_comparison
        (int.parse(widget.start != null ? widget.start : '0') * 100) /
            int.parse(widget.finish != null ? widget.finish : '0'));
    return TextButton(
      onPressed: () => 
      
        {},
      /* Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BottomBarView(
                    counterModel: widget.counterModel,
                    selected: 2,
                  ))), */
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: 105,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 14, 31, 216).withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
            color: Color.fromRGBO(27, 41, 86, 1),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'main.target'.tr() + " : " + widget.finish,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Color.fromARGB(255, 203, 200, 200), fontSize: 16),
                )
              ],
            ),
            Row(
              children: [
                Center(
                  child: CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 5.0,
                    percent: 0.240,
                    center: new Text(
                      // ignore: unnecessary_null_comparison
                      (
                              // ignore: unnecessary_null_comparison
                              (int.parse(widget.start != null
                                          ? widget.start
                                          : '0') *
                                      100) /
                                  int.parse(widget.finish != null
                                      ? widget.finish
                                      : '0'))
                          .toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    progressColor: Color.fromARGB(255, 249, 249, 249),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 175, 39, 39),
                  ),
                  child: Center(
                    child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.xmark,
                          color: Colors.white,
                        ),
                        onPressed: widget.onPressed),
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
