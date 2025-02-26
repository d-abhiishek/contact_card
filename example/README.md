# cCard Example

Demonstrates how to use the cCard package - a dart port of cCard JS by Eric J Nesser.

## Getting Started

For help getting started with this package from [readme documentation](https://pub.dev/packages/vcard).

## Basic Usage

Below is a simple example of how to create a basic cCard and how to save it to a file, or view its contents from the console.

``` dart
/// Import the package
import 'package:contact_card/contact_card.dart';

///Create a new cCard
var cCard = CCard();

///Set properties
cCard.firstName = 'FirstName';
cCard.middleName = 'MiddleName';
cCard.lastName = 'LastName';
cCard.organization = 'ActivSpaces Labs';
cCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
cCard.workPhone = 'Work Phone Number';
cCard.birthday = DateTime.now();
cCard.title = 'Software Developer';
cCard.url = 'https://github.com/valerycolong';
cCard.note = 'Notes on contact';

/// Save to file
cCard.saveToFile('./contact.vcf');

/// Get as formatted string
print(cCard.getFormattedString());

```

### Embedding Images

You can embed images in the photo or logo field instead of linking to them from a URL using base64 encoding.

```dart
//can be Windows or Linux/Unix path structures, and JPEG, PNG, GIF formats
cCard.photo.embedFromFile('/path/to/file.png');
cCard.logo.embedFromFile('/path/to/file.png');
```

```dart
//can also embed images via base-64 encoded strings
cCard.photo.embedFromString('iVBORw0KGgoAAAANSUhEUgAAA2...', 'image/png');
cCard.logo.embedFromString('iVBORw0KGgoAAAANSUhEUgAAA2...', 'image/png');
```

### Date Reference

MDN reference on how to use the `Date` object for birthday and anniversary can be found at [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date).

### Complete Example

The following shows a cCard with everything filled out.

```dart
///import the package
import 'package:contact_card/contact_card.dart';

//create a new cCard
var cCard = CCard();

///set basic properties shown before
cCard.firstName = 'FirstName';
cCard.middleName = 'MiddleName';
cCard.lastName = 'Last Name';
cCard.uid = '6yuuhuhj-c34d-4a1e-8922-bd38a9476a53';
cCard.organization = 'ActivSpaces Labs';

///link to image
cCard.photo.attachFromUrl('/path/to/image/file.png', 'JPEG');

///or embed image
cCard.photo.attachFromUrl('/path/to/image/file.png');

cCard.workPhone = '312-555-1212';
cCard.birthday = DateTime.now();
cCard.title = 'Software Developer';
cCard.url = 'https://github.com/valerycolong';
cCard.workUrl = 'https://activspaces.com';
cCard.note = 'Notes on contact';

///set other vitals
cCard.nickname = 'Scarface';
cCard.namePrefix = 'Mr.';
cCard.nameSuffix = 'JR';
cCard.gender = 'M';
cCard.anniversary = DateTime.now();
cCard.role = 'Software Development';

///set other phone numbers
cCard.homePhone = 'Home Phone';
cCard.cellPhone = 'Cell Phone';
cCard.pagerPhone = 'Pager Phone';

///set fax/facsimile numbers
cCard.homeFax = 'Home Fax';
cCard.workFax = 'Work Fax';

///set email addresses
cCard.email = 'labs@activspaces.com';
cCard.workEmail = 'hello@activspaces.com';

///set logo of organization or personal logo (also supports embedding, see above)
cCard.logo.attachFromUrl('https://www.activspaces.com/wp-content/uploads/2019/01/ActivSpaces-Logo_Dark.png', 'PNG');

///set URL where the cCard can be found
cCard.source = 'http://example.com/myvcard.vcf';

///set address information
cCard.homeAddress.label = 'Home Address';
cCard.homeAddress.street = 'Great Soppo';
cCard.homeAddress.city = 'Buea';
cCard.homeAddress.stateProvince = 'SW';
cCard.homeAddress.postalCode = '00237';
cCard.homeAddress.countryRegion = 'Cameroon';
cCard.homeAddress.type = 'HOME';

cCard.workAddress.label = 'Work Address';
cCard.workAddress.street = 'Molyko';
cCard.workAddress.city = 'Buea';
cCard.workAddress.stateProvince = 'SW';
cCard.workAddress.postalCode = '00237';
cCard.workAddress.countryRegion = 'Cameroon';
cCard.workAddress.type = 'WORK';

///set social media URLs
cCard.socialUrls['facebook'] = 'https://...';
cCard.socialUrls['linkedIn'] = 'https://...';
cCard.socialUrls['twitter'] = 'https://...';
cCard.socialUrls['flickr'] = 'https://...';
cCard.socialUrls['custom'] = 'https://...';

///you can also embed photos from files instead of attaching via URL
cCard.photo.embedFromFile('photo.jpg');
cCard.logo.embedFromFile('logo.jpg');

cCard.version = '3.0'; //can also support 2.1 and 4.0, certain versions only support certain fields

///save to file
cCard.saveToFile('./contact/file.vcf');

///get as formatted string
print(cCard.getFormattedString());
```

### Multiple Email, Fax, & Phone Examples

`email`, `otherEmail`, `cellPhone`, `pagerPhone`, `homePhone`, `workPhone`, `homeFax`, `workFax`, `otherPhone` all support multiple entries in an array format.

Examples are provided below:

```dart

///import the package
import 'package:contact_card/contact_card.dart';


//create a new cCard
var cCard = CCard();

///multiple email entry
cCard.email = [
    'e.nesser@emailhost.tld',
    'e.nesser@emailhost2.tld',
    'e.nesser@emailhost3.tld'
];

///multiple cellphone
cCard.cellPhone = [
    '312-555-1414',
    '312-555-1415',
    '312-555-1416'
];

```

### Apple AddressBook Extensions

You can mark as a contact as an organization with the following Apple AddressBook extension property:

```dart
    var cCard = CCard();
    cCard.isOrganization = true;
```