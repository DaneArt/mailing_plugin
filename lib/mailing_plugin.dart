import 'dart:async';

import 'package:flutter/services.dart';

///Model for [MailingPlugin.mailto] method
class Email {
  ///List of recipients
  final List<String> to;

  ///Subject of a letter
  final String subject;

  ///Body of a message. Plain text.
  final String message;
  Email(this.to, this.subject, this.message);
}

///Model for [MailingPlugin.smsto]
class SMS {
  ///Recipients of SMS.
  final List<String> to;

  ///Body of sms message
  final String message;

  SMS(this.to, this.message);
}

class MailingPlugin {
  static const MethodChannel _channel = const MethodChannel('mailing_plugin');

  static void mailto(Email mail) {
    _channel.invokeMethod('send_mail', {
      'to': mail.to.join(', '),
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
        'send_sms', {'to': message.to.join(', '), 'message': message.message});
  }
}
