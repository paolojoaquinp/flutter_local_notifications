

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../display_notification_widget.dart';

class NotificationsService {
  // Inicializacion
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  // GlobalKey
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  // Detalles (NotificationDetails)
  static NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      "channelId",
      "channelName",
      priority: Priority.high,
      icon: "@mipmap/ic_launcher",
      sound: RawResourceAndroidNotificationSound("mi_sonido")
    ),
    iOS: DarwinNotificationDetails(
      threadIdentifier: "thread_id"
    )
  );


  // LLamadas(Metodos)
  // Metodo init
  static Future<void> init() async {
    AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
    
    DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings 
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      /* Manipular */
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      /* Maniular seg plano */
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse
    );
  }

  // Metodo para solicitar permiso de notificaciones
  static void askForNotificationPermission() {
    Permission.notification.request().then(
      (permissionStatus) {
        if(permissionStatus != PermissionStatus.granted) {
          AppSettings.openAppSettings(type: AppSettingsType.notification);
        }
      }
    );
  }

  // Enviar notificaciones de forma instantanea
  static void sendInstantNotification({
    required String title,
    required String body,
    required String payload
  }) {
    flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
  }

  // Enviar Notificaciones periodicas
static void sendPeriodicNotification({
    required String title,
    required String body,
    required String payload
  }) {
    flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
      payload: payload
    );
  }
  // Cancelar Notificaciones periodicas
  static Future<void> cancelPeriodicNotification() async {
    await flutterLocalNotificationsPlugin.cancel(1);
  }

  // Manipular respuesta de notificacion
  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    debugPrint('metodo para manipular respuesta');
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayNotification(
          payloadData: response.payload
        )
      )
    );
  }

  // Manipular respuesta de notificacion en segundo plano
  static void onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
    debugPrint('metodo para manipular desde segundo plano');
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayNotification(
          payloadData: response.payload
        )
      )
    );
  }
}