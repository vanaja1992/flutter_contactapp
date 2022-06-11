import 'package:url_launcher/url_launcher.dart';

class LauncherUtility {

  static Future<void> makeCall(String phoneNo) async {
    await launchUrl(Uri.parse("tel:$phoneNo"));
  }

  static Future<void> sendSms(String phoneNo) async {
    await launchUrl(Uri.parse("sms:$phoneNo"));
  }

  static Future<void> openUrl(String website) async {
    final Uri _url = Uri.parse(website);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  static Future<void> sendEmail(String emailid) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: emailid,
      query: 'subject=This is a test mail = Hello Ms/Mr.', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      throw 'Could not launch $url';
    }

  }
}