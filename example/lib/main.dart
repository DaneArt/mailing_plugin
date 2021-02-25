import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mailing_plugin/mailing_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                child: Text('mailto'),
                onPressed: () {
                  MailingPlugin.mailto(Email(
                      ['public.centaurus@gmail.com', 'testmail@gmail.com'],
                      'Send mails',
                      'Hi join me at bunder.io!'));
                },
              ),
              RaisedButton(
                child: Text('messageto'),
                onPressed: () {
                  MailingPlugin.sendMessage('Hi, join me at bunder.io!');
                },
              ),
              RaisedButton(
                child: Text('smsto'),
                onPressed: () {
                  MailingPlugin.sendSMS(SMS(
                      ['+79964519366, +79964519362'], "Hi meet me at bunder!"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
