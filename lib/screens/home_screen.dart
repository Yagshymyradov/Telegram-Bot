import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomState();
}

class _HomState extends State<HomeScreen> {
  final _telegramToken = '7232830325:AAEHp4Wz7ahw6Mni_-Eow0JAJ119Rjhv43c';
  final envVars = Platform.environment;
  TeleDart? _teleDart;
  String? _botName = '';
  int msgId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bot App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _startBot(),
            icon: const Icon(Icons.play_arrow),
          )
        ],
      ),
    );
  }

  Future<void> _startBot() async {
    final username = (await Telegram(_telegramToken).getMe()).username;

    _teleDart = TeleDart(_telegramToken, Event(username!));
    _teleDart?.start();
    _botName = (await _teleDart?.getMyName('en'))?.name;

    _teleDart?.onMessage(entityType: 'bot_command', keyword: 'start').listen((message) {
      msgId = message.chat.id;
      _teleDart?.sendMessage(msgId, 'Hello I am bot');
    });
  }
}
