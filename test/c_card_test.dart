import 'package:flutter_test/flutter_test.dart';
import 'package:contact_card/contact_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('prints formated cCard string', () {
    final cCard = CCard();
    cCard.jobTitle = 'Dr';
    cCard.firstName = 'Colong';
    cCard.middleName = 'Valery';
    cCard.lastName = 'Nyiwung';
    cCard.homeAddress.street = 'Auberge';
    cCard.homeAddress.city = 'Buea';
    cCard.homeAddress.stateProvince = 'SW';
    cCard.homeAddress.countryRegion = 'Cameroon';
    //print(cCard.getFormattedString());
    expect(cCard.getFormattedString() is String, true);
    expect(cCard.getFormattedString().contains(RegExp(r'BEGIN:VCARD')), true);
  });
}
