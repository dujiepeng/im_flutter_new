import 'package:flutter/material.dart';

import 'package:im_flutter_sdk/im_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: ListView(
          children: [
            ListTile(onTap: init, title: const Text('init')),
            ListTile(onTap: login, title: const Text('login')),
            ListTile(onTap: logout, title: const Text('logout')),
            ListTile(onTap: init, title: const Text('init')),
            ListTile(onTap: init, title: const Text('init')),
          ],
        )),
      ),
    );
  }

  _addMessageListener() {
    EMClient.getInstance.chatManager.addMessageEvent(
      'identifier',
      ChatMessageEvent(
        onSuccess: (msgId, msg) {
          debugPrint('onSuccess');
        },
        onError: (msgId, msg, e) {
          debugPrint('onError');
        },
        onProgress: (msgId, progress) {},
      ),
    );

    EMClient.getInstance.chatManager.addEventHandler(
      'identifier',
      EMChatEventHandler(
        onMessagesReceived: (messages) {
          debugPrint('onMessagesReceived');
        },
      ),
    );
  }

  init() async {
    await EMClient.getInstance.init(EMOptions.withAppKey('easemob#easeim'));
    _addMessageListener();
  }

  login() async {
    await EMClient.getInstance.loginWithPassword('du001', '1');
  }

  logout() async {
    await EMClient.getInstance.logout(true);
  }

  sendMessage() async {
    EMMessage message = EMMessage.createTxtSendMessage(
      content: 'hello',
      targetId: 'du002',
    );
    await EMClient.getInstance.chatManager.sendMessage(message);
  }
}
