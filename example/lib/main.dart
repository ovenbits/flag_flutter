import 'package:example/restart_widget.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const RestartWidget(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? displayFlagPicker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Flag.fromCode(
                FlagsCode.KI,
                height: 100,
              ),
              const Flag.fromCode(
                FlagsCode.AD,
                height: 10,
                width: 100,
                fit: BoxFit.fill,
              ),
              const Flag.fromCode(
                FlagsCode.AD,
                height: 50,
                width: 50,
                fit: BoxFit.fill,
                flagSize: FlagSize.size_1x1,
                borderRadius: 25,
              ),
              Flags.fromCode(
                const [
                  FlagsCode.GB,
                  FlagsCode.CN,
                ],
                height: 100,
                width: 100 * 4 / 3,
              ),
              const Flag.fromString(
                'ACC',
                height: 10,
                width: 100,
                fit: BoxFit.fill,
                replacement: Text('ACC not found'),
              ),
              if (Flag.flagsCode.contains('AF'.toLowerCase()))
                const Flag.fromString(
                  'af',
                  height: 10,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: displayFlagPicker == null
                        ? () => setState(() {
                              displayFlagPicker = false;
                            })
                        : null,
                    child: const Text('no preCache'),
                  ),
                  ElevatedButton(
                    onPressed: displayFlagPicker == null
                        ? () => setState(() {
                              displayFlagPicker = true;
                            })
                        : null,
                    child: const Text('preCache'),
                  ),
                  ElevatedButton(
                    onPressed: () => RestartWidget.restartApp(context),
                    child: const Text('restart'),
                  ),
                ],
              ),
              if (displayFlagPicker != null)
                const FlagPicker(
                  width: 50,
                  height: 300,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlagPicker extends StatefulWidget {
  const FlagPicker({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<FlagPicker> createState() => _FlagPicker();
}

class _FlagPicker extends State<FlagPicker> {
  late FixedExtentScrollController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = FixedExtentScrollController(
      initialItem: _currentIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: CupertinoPicker.builder(
        scrollController: _controller,
        offAxisFraction: 0.0,
        itemExtent: 40,
        childCount: Flag.flagsCode.length,
        useMagnifier: true,
        magnification: 1.0,
        diameterRatio: 0.8,
        onSelectedItemChanged: (value) {
          setState(() {
            if (kDebugMode) {
              print(value);
            }
          });
        },
        itemBuilder: (context, index) => Center(
          child: Flag.fromString(
            Flag.flagsCode[index],
          ),
        ),
      ),
    );
  }
}
