# mailing_plugin

Flutter plugin that makes it possible to send emails, SMS and messages by native platform code.

## Installation

### Android: 

Add this line to **manifest.xml** file in android directory: 

    <uses-permission android:name="android.permission.SEND_SMS" />



## Usage

### Send E-mail:


    MailingPlugin.mailto(email);
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
    
### Send message: 
    MailingPlugin.sendMessage(message);
message - is just a string

### Send SMS(require SMS Access!!!)
    MailingPlugin.sendSMS(message);
    
    
    ///Model for [MailingPlugin.smsto]
    class SMS {
      ///Recipients of SMS.
      final List<String> to;
    
      ///Body of sms message
      final String message;
    
      SMS(this.to, this.message);
    }
   
