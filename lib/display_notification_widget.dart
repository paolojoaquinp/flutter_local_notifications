import 'package:flutter/material.dart';

class DisplayNotification extends StatefulWidget {
  final String? payloadData;
  const DisplayNotification({super.key, this.payloadData});

  @override
  State<DisplayNotification> createState() => _DisplayNotificationState();
}

class _DisplayNotificationState extends State<DisplayNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.payloadData ?? "Data no disponible"),
      ),
    );
  }
}