import 'package:vcard_maintained/vcard_maintained.dart';
import 'package:flutter/material.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  ///Create a new vCard
  var vCard = VCard();

  ///Set properties
  vCard.firstName = 'FirstName';
  vCard.middleName = 'MiddleName';
  vCard.lastName = 'LastName';
  vCard.organization = 'ActivSpaces Labs';
  vCard.photo.attachFromUrl(
      'https://www.activspaces.com/wp-content/uploads/2019/01/ActivSpaces-Logo_Dark.png',
      'PNG');
  vCard.workPhone = 'Work Phone Number';
  vCard.birthday = DateTime.now();
  vCard.jobTitle = 'Software Developer';
  vCard.url = 'https://github.com/valerycolong';
  vCard.note = 'Notes on contact';

  /// Save to file
  vCard.saveToFile('./contact.vcf');

  /// Get as formatted string
  print(vCard.getFormattedString());
}
