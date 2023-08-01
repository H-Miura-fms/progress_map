import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:math' as math;

import 'package:progress_map/component/margin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // double per = 1.3;

  double target = 40;
  double num = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = width;
    double per = num / target;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MarginVertical(size: 20),
            const Text(
              "target",
              style: TextStyle(fontSize: 20),
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
                      tween: Tween<double>(begin: 0, end: (per > 1) ? 1 : per),
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
                "${num}h / ${target}h",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(
                  () {
                    num += 1;
                  },
                );
              },
              child: const Text("test"),
            ),
            TextButton(
              onPressed: () {
                setState(
                  () {
                    num = 0;
                  },
                );
              },
              child: const Text("reset"),
            )
          ],
        ),
      ),
    );
  }
}
