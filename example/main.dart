import 'package:contact_card_flutter/contact_card_flutter.dart';
import 'package:flutter/material.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  ///Create a new cCard
  var cCard = CCard();

  ///Set properties
  cCard.firstName = 'FirstName';
  cCard.middleName = 'MiddleName';
  cCard.lastName = 'LastName';
  cCard.organization = 'ActivSpaces Labs';
  cCard.photo.attachFromUrl(
      'https://www.activspaces.com/wp-content/uploads/2019/01/ActivSpaces-Logo_Dark.png',
      'PNG');
  cCard.workPhone = 'Work Phone Number';
  cCard.birthday = DateTime.now();
  cCard.jobTitle = 'Software Developer';
  cCard.url = 'https://github.com/valerycolong';
  cCard.note = 'Notes on contact';

  /// Save to file
  cCard.saveToFile('./contact.vcf');

  /// Get as formatted string
  print(cCard.getFormattedString());
}
