import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_cane/globals.dart';
import 'package:smart_cane/pages/guardian/share_loc.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import '../tempMap.dart';
import 'home_widgets.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  bool mic = false;
  bool on = true;
  late stt.SpeechToText _speech;
  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = '';
  double _confidence = 1.0;
  String _text = 'Press the button and start speaking';
  final List<Widget> widgets_list = [
    Body(
      key: UniqueKey(),
    ),
    TempMap(key: UniqueKey())
  ];
  void swap() {
    setState(() {
      on = !on;
    });
    Fluttertoast.showToast(
        msg: on ? "Device Connected" : "Device Disconnected");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Bottom(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AvatarGlow(
          animate: false,
          endRadius: 75.0,
          repeat: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: AvatarGlow(
              animate: _isListening,
              glowColor: COLOR_THEME['tertiary']!,
              endRadius: 75.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: FloatingActionButton(
                backgroundColor: COLOR_THEME['primary'],
                onPressed: _listen,
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening
                      ? COLOR_THEME['tertiary']
                      : COLOR_THEME['secondary'],
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            on ? "CONNECTED" : "DISCONNECTED",
            style: const TextStyle(
                color: Color.fromRGBO(200, 254, 251, 1), fontSize: 18),
          ),
          leading: Switch(
            value: on,
            onChanged: (value) => swap(),
            activeColor: COLOR_THEME['tertiary'],
            activeTrackColor: Colors.white38,
            inactiveThumbColor: Color.fromRGBO(249, 119, 119, 1.0),
            inactiveTrackColor: Colors.white38,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/profile');
                },
                icon: Icon(
                  size: 35,
                  Icons.settings,
                  color: COLOR_THEME['tertiary'],
                )),
          ],
        ),
        body: Stack(children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.5,
                    image: AssetImage("assets/background-circuit.png"),
                    fit: BoxFit.cover)),
          ),
          widgets_list[pageIndex],
        ]));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(onStatus: (val) {
        print('onStatus: $val');
        print(_text);
        if (val == "done") {
          setState(() => _isListening = false);
          if (_text == "open settings") {
            Navigator.of(context).pushNamed('/profile');
          } else if (_text == "go to navigation") {
            pageIndex = 1;
          } else if (_text == 'disconnect') {
            setState(() {
              on = false;
            });
            Fluttertoast.showToast(msg: "Device Disconnected");
          } else if (_text == 'connect') {
            setState(() {
              on = true;
            });
            Fluttertoast.showToast(msg: " Device Connected");
          } else if (_text == 'go to home') {
            pageIndex = 0;
          } else {
            Fluttertoast.showToast(
                msg: "cannot understand the command...Try Again!");
          }
        }
      }, onError: (val) {
        setState(() => _isListening = false);
        print('onError: $val');
        Fluttertoast.showToast(
            msg: "cannot understand the command...Try Again!");
      });
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
        print(_text);
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Widget Bottom(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pageIndex,
      onTap: (index) {
        setState(() {
          pageIndex = index;
        });
      },
      backgroundColor: COLOR_THEME['primary'],
      selectedItemColor: COLOR_THEME['tertiary'],
      unselectedItemColor: COLOR_THEME['secondary'],
      elevation: 0.2,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            activeIcon: Icon(Icons.home)),
        BottomNavigationBarItem(
            icon: Icon(Icons.navigation_outlined),
            label: "Navigation",
            activeIcon: Icon(Icons.navigation_rounded))
      ],
    );
  }
}
