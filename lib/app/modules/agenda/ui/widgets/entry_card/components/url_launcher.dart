import 'package:url_launcher/url_launcher.dart';


void _launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

void maps(String address) {
  final formatedAddress = address.replaceAll(" ", "+");
  final url = 'https://www.google.com/maps/dir/?api=1&destination=$formatedAddress&travelmode=car';
  _launchURL(url);
}

void phone(String phoneNumber) {
  launch("tel://$phoneNumber");
}
