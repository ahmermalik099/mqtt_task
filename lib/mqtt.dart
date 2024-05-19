import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:typed_data/src/typed_buffer.dart';

import 'main.dart';

class MqttApp extends StatefulWidget {
  const MqttApp({Key? key}) : super(key: key);

  @override
  State<MqttApp> createState() => _MqttAppState();
}

class _MqttAppState extends State<MqttApp> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _subController = TextEditingController();
  final MqttClient _client = MqttClient('broker.ahmer.com', '');
  final List<String> _messages = [];

  void _publishMessage() {
    final String message = _messageController.text;
    final String subject = _subController.text;
    _client.connect('ahmer111');
    _client.publishMessage(subject,message as MqttQos, message as Uint8Buffer);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MQTT App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Enter a message',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _subController,
              decoration: InputDecoration(
                hintText: 'Enter a subject',
              ),
            ),
            ElevatedButton(
              onPressed: _publishMessage,
              child: Text('Publish'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_messages[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  }