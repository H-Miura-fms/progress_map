import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
// ignore: unused_import
import 'dart:math' as math;

import 'package:progress_map/component/margin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // double per = 1.3;

  double target = 40;
  late double num = 0;
  late String targetTitle = "";
  late SharedPreferences prefs;

  @override
  void initState() {
    futureInit();
    super.initState();
  }

  Future<void> futureInit() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      num = prefs.getDouble("counter") ?? 0;
      targetTitle = prefs.getString("title") ?? "no Title";
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = width;
    double per = num / target;
    final FocusNode targetNode = FocusNode();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MarginVertical(size: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Focus(
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                    controller: TextEditingController(text: targetTitle),
                    decoration: const InputDecoration(
                      hintText: 'Enter a target!',
                    ),
                    focusNode: targetNode,
                    onSubmitted: (_) {
                      setState(() {
                        targetTitle = (_ == "") ? "no Title" : _;
                        prefs.setString("title", targetTitle);
                      });
                    },
                  ),
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      targetNode.unfocus();
                    }
                  },
                ),
              ),
              const MarginVertical(size: 20),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                // width: MediaQuery.of(context).size.width - 120,
                // height: MediaQuery.of(context).size.width - 120,
                decoration: const BoxDecoration(
                    //color: Color.fromARGB(255, 240, 240, 240),
                    ),
                child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                      //  color: Color.fromARGB(255, 240, 240, 240),
                      ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Text(
                        "${(double.parse((double.parse(per.toStringAsFixed(3)) * 100).toStringAsFixed(2)))}%",
                        style: TextStyle(
                            fontSize: 40,
                            color: (per >= 1)
                                ? const Color.fromARGB(255, 255, 111, 0)
                                : Colors.black),
                      ),
                      TweenAnimationBuilder<double>(
                        tween:
                            Tween<double>(begin: 0, end: (per > 1) ? 1 : per),
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 1500),
                        builder: (context, value, _) => SizedBox(
                          width: width,
                          height: height,
                          child: CircularProgressIndicator(
                            value: value,
                            strokeWidth: 20,
                            backgroundColor:
                                const Color.fromARGB(255, 200, 200, 200),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "${num.toStringAsFixed(2)}h / ${target}h",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Picker(
                      adapter: NumberPickerAdapter(data: [
                        const NumberPickerColumn(
                            begin: 0, end: 999, suffix: Text("h")),
                        const NumberPickerColumn(
                            begin: 0, end: 59, suffix: Text("min")),
                      ]),
                      delimiter: [
                        PickerDelimiter(
                            child: Container(
                          width: 30.0,
                          alignment: Alignment.center,
                          child: const Icon(Symbols.go_to_line),
                        ))
                      ],
                      hideHeader: true,
                      title: const Text("Please Select"),
                      onConfirm: (Picker picker, List<int> value) {
                        double selectedHour = value[0].toDouble();
                        double selectedMin = (value[1].toDouble()) / 60;
                        double selectedNum = selectedHour + selectedMin;

                        setState(() {
                          num += selectedNum;
                          prefs.setDouble('counter', num);
                        });
                      }).showDialog(context);
                },
                child: const Text("test"),
              ),
              TextButton(
                onPressed: () {
                  setState(
                    () {
                      num = 0;
                      prefs.setDouble('counter', 0);
                    },
                  );
                },
                child: const Text("reset"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
