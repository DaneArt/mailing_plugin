import 'dart:async';

import 'package:flutter/services.dart';

class Email {
  final List<String> to;
  final String subject;
  final String message;
  Email(this.to, this.subject, this.message);
}

class SMS {
  final List<String> to;
  final String message;

  SMS(this.to, this.message);
}

class MailingPlugin {
  static const MethodChannel _channel = const MethodChannel('mailing_plugin');

  static void mailto(Email mail) {
    _channel.invokeMethod('send_mail', {
      'to': mail.to,
      'subject': mail.subject,
      'message': mail.message,
    });
  }

  static void sendMessage(String message) {
    _channel.invokeMethod('send_message', {
      'message': message,
    });
  }

  static void sendSMS(SMS message) {
    _channel.invokeMethod(
        'send_sms', {'to': message.to, 'message': message.message});
  }
}
