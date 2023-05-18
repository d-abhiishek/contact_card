part of vcard_maintained;

class MailingAddress {
  /// Represents the actual text that should be put on the mailing label when delivering a physical package
  String label = '';

  /// Street address
  String street = '';

  /// City
  String city = '';

  /// State or province
  String stateProvince = '';

  /// Postal code
  String postalCode = '';

  /// Country or region
  String countryRegion = '';

  final String type;

  MailingAddress(this.type);
}
