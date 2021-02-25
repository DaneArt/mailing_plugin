package com.dacoder.mailing_plugin

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** MailingPlugin */
class MailingPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mailing_plugin")
    context = flutterPluginBinding.applicationContext
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    if (call.method == "send_mail") {
      val sendTo =  (call.arguments as HashMap<*, *>)["to"].toString()
      val subject = (call.arguments as HashMap<*, *>)["subject"].toString()
      val message = (call.arguments as HashMap<*,*>)["message"].toString()
      val uriText = "mailto:" + Uri.encode(sendTo) +
              "?subject=" + Uri.encode(subject) +
              "&body=" + Uri.encode(message)
      val email = Intent(Intent.ACTION_SENDTO)
      email.type = "message/rfc822";
      email.data = Uri.parse(uriText)

      val chooser = Intent.createChooser( email, "Choose an Email client :")
      chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_MULTIPLE_TASK)

      context.startActivity(chooser)
    } else if(call.method == "send_message"){
      val msg = (call.arguments as HashMap<*,*>)["message"].toString()

      val sendIntent: Intent = Intent().apply {
        action = Intent.ACTION_SEND
        putExtra(Intent.EXTRA_TEXT, msg)
        type = "text/plain"
      }

      val shareIntent = Intent.createChooser(sendIntent, null)

      shareIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_MULTIPLE_TASK)
      context.startActivity(shareIntent)
    }else if(call.method == "send_sms"){    val sendTo =  (call.arguments as HashMap<*, *>)["to"].toString()
      val subject = (call.arguments as HashMap<*, *>)["subject"].toString()
      val message = (call.arguments as HashMap<*,*>)["message"].toString()
      val uriText = "smsto:" + Uri.encode(sendTo)
      val sms = Intent(Intent.ACTION_VIEW)
      sms.data = Uri.parse(uriText)
      sms.putExtra("sms_body", message)
      val chooser = Intent.createChooser( sms, "Choose an SMS client :")
      chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_MULTIPLE_TASK)

      context.startActivity(chooser)
    }else{
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
