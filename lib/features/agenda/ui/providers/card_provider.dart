import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:zione_app/features/agenda/models/entry_model.dart';

class CardProvider extends ChangeNotifier {
  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void launchPhone(String phoneNumber) {
    _launchURL("tel://$phoneNumber");
  }

  void launchMap(String address) {
    final formatedAddress = address.replaceAll(" ", "+");
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$formatedAddress&travelmode=car';
    _launchURL(url);
  }
}
