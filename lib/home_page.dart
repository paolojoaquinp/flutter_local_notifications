import 'package:flutter/material.dart';
import 'package:flutter_notifications/services/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSelected = false;

  @override
  void initState() {
    NotificationsService.askForNotificationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notificaciones Locales'),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                NotificationsService.sendInstantNotification(
                  title: "Titulo de ejemplo",
                  body: "Body de ejemplo",
                  payload: "Payload Ejemplo"
                );
              }, child: const Text("Obtener Notificacion Local")
            ),
            Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Text('Obtener Notificaciones por minuto'),
                const Spacer(),
                Switch(
                  value: isSelected,
                  onChanged: (value) {
                    isSelected = !isSelected;
                    if(isSelected) {
                      NotificationsService.sendPeriodicNotification(
                        title: "Notificacion Periodica",
                        body: "Body notificacion periodica",
                        payload: "Payload Notificacion"
                      );
                    } else {
                      NotificationsService.cancelPeriodicNotification();
                    }
                    setState(() {});
                  }
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}