part of contact_card;

class CCardFormatter {
  int majorVersion = 3;

  /// Encode string
  /// @param  {String}     value to encode
  /// @return {String}     encoded string
  String e(String? value) {
    if ((value != null) && (value.isNotEmpty)) {
//      if (value is String) {
//        value = '' + value;
//      }
      return value
          .replaceAll(RegExp(r'/\n/g'), '\\n')
          .replaceAll(RegExp(r'/,/g'), '\\,')
          .replaceAll(RegExp(r'/;/g'), '\\;');
    }
    return '';
  }

  /// Return new line characters
  /// @return {String} new line characters
  String nl() {
    return '\r\n';
  }

  /// Get formatted photo
  /// @param  {String} photoType       Photo type (PHOTO, LOGO)
  /// @param  {String} url             URL to attach photo from
  /// @param  {String} mediaType       Media-type of photo (JPEG, PNG, GIF)
  /// @param  {String} isBase64        Whether or not is Base64 format
  /// @return {String}                 Formatted photo
  String getFormattedPhoto(
      String photoType, String url, String mediaType, bool isBase64) {
    String params;

    if (majorVersion >= 4) {
      params = isBase64 ? ';ENCODING=b;MEDIATYPE=image/' : ';MEDIATYPE=image/';
    } else if (majorVersion == 3) {
      params = isBase64 ? ';ENCODING=b;TYPE=' : ';TYPE=';
    } else {
      params = isBase64 ? ';ENCODING=BASE64;' : ';';
    }

    String formattedPhoto =
        photoType + params + mediaType + ':' + e(url) + nl();
    return formattedPhoto;
  }

  /// Get formatted address
  /// @param  {Map<String, String>}         address
  /// @param  {String}         type address type
  /// @param {String}         Encoding prefix encodingPrefix
  /// @return {String}         Formatted address
  String getFormattedAddress(
      {required MailingAddress address, required String encodingPrefix}) {
    var formattedAddress = '';

    if (address.label.isNotEmpty ||
        address.street.isNotEmpty ||
        address.city.isNotEmpty ||
        address.stateProvince.isNotEmpty ||
        address.postalCode.isNotEmpty ||
        address.countryRegion.isNotEmpty) {
      if (majorVersion >= 4) {
        formattedAddress = 'ADR' +
            encodingPrefix +
            ';TYPE=' +
            address.type +
            (address.label.isNotEmpty
                ? ';LABEL="' + e(address.label) + '"'
                : '') +
            ':;;' +
            e(address.street) +
            ';' +
            e(address.city) +
            ';' +
            e(address.stateProvince) +
            ';' +
            e(address.postalCode) +
            ';' +
            e(address.countryRegion) +
            nl();
      } else {
        if (address.label.isNotEmpty) {
          formattedAddress = 'LABEL' +
              encodingPrefix +
              ';TYPE=' +
              address.type +
              ':' +
              e(address.label) +
              nl();
        }
        formattedAddress += 'ADR' +
            encodingPrefix +
            ';TYPE=' +
            address.type +
            ':;;' +
            e(address.street) +
            ';' +
            e(address.city) +
            ';' +
            e(address.stateProvince) +
            ';' +
            e(address.postalCode) +
            ';' +
            e(address.countryRegion) +
            nl();
      }
    }

    return formattedAddress;
  }

  /// Convert date to YYYYMMDD format
  /// @param  {Date}       date to encode
  /// @return {String}     encoded date
  String formatCCardDate(DateTime date) {
    return DateFormat("yyyyMMdd").format(date);
  }

  String getFormattedString(CCard cCard) {
    majorVersion = cCard.getMajorVersion();

    String formattedCCardString = '';
    formattedCCardString += 'BEGIN:VCARD' + nl();
    formattedCCardString += 'VERSION:' + cCard.version! + nl();

    String encodingPrefix = majorVersion >= 4 ? '' : ';CHARSET=UTF-8';
    String? formattedName = cCard.formattedName;

    if (formattedName == null) {
      formattedName = '';

      [cCard.firstName, cCard.middleName, cCard.lastName].forEach((name) {
        if ((name.isNotEmpty) && (formattedName!.isNotEmpty)) {
          formattedName = formattedName! + ' ';
        }
        formattedName = formattedName! + name;
      });
    }

    formattedCCardString +=
        'FN' + encodingPrefix + ':' + e(formattedName) + nl();
    formattedCCardString += 'N' +
        encodingPrefix +
        ':' +
        e(cCard.lastName) +
        ';' +
        e(cCard.firstName) +
        ';' +
        e(cCard.middleName) +
        ';' +
        e(cCard.namePrefix) +
        ';' +
        e(cCard.nameSuffix) +
        nl();

    if ((cCard.nickname != null) && (majorVersion >= 3)) {
      formattedCCardString +=
          'NICKNAME' + encodingPrefix + ':' + e(cCard.nickname) + nl();
    }

    if (cCard.gender != null) {
      formattedCCardString += 'GENDER:' + e(cCard.gender) + nl();
    }

    if (cCard.uid != null) {
      formattedCCardString +=
          'UID' + encodingPrefix + ':' + e(cCard.uid) + nl();
    }

    if (cCard.birthday != null) {
      formattedCCardString += 'BDAY:' + formatCCardDate(cCard.birthday!) + nl();
    }

    if ((cCard.anniversary != null) && (majorVersion >= 4)) {
      formattedCCardString +=
          'ANNIVERSARY:' + formatCCardDate(cCard.anniversary!) + nl();
    }

    if (cCard.email != null) {
      if (cCard.email is! List) {
        cCard.email = [cCard.email];
      }
      cCard.email.forEach((address) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'EMAIL' + encodingPrefix + ';type=HOME:' + e(address) + nl();
        } else if (majorVersion >= 3 && majorVersion < 4) {
          formattedCCardString += 'EMAIL' +
              encodingPrefix +
              ';type=HOME,INTERNET:' +
              e(address) +
              nl();
        } else {
          formattedCCardString +=
              'EMAIL' + encodingPrefix + ';HOME;INTERNET:' + e(address) + nl();
        }
      });
    }

    if (cCard.workEmail != null) {
      if (cCard.workEmail is! List) {
        cCard.workEmail = [cCard.workEmail];
      }
      cCard.workEmail.forEach((address) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'EMAIL' + encodingPrefix + ';type=WORK:' + e(address) + nl();
        } else if (majorVersion >= 3 && majorVersion < 4) {
          formattedCCardString += 'EMAIL' +
              encodingPrefix +
              ';type=WORK,INTERNET:' +
              e(address) +
              nl();
        } else {
          formattedCCardString +=
              'EMAIL' + encodingPrefix + ';WORK;INTERNET:' + e(address) + nl();
        }
      });
    }

    if (cCard.otherEmail != null) {
      if (cCard.otherEmail is! List) {
        cCard.otherEmail = [cCard.otherEmail];
      }
      cCard.otherEmail.forEach((address) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'EMAIL' + encodingPrefix + ';type=OTHER:' + e(address) + nl();
        } else if (majorVersion >= 3 && majorVersion < 4) {
          formattedCCardString += 'EMAIL' +
              encodingPrefix +
              ';type=OTHER,INTERNET:' +
              e(address) +
              nl();
        } else {
          formattedCCardString +=
              'EMAIL' + encodingPrefix + ';OTHER;INTERNET:' + e(address) + nl();
        }
      });
    }

    if (cCard.logo.url != null) {
      formattedCCardString += getFormattedPhoto(
          'LOGO', cCard.logo.url!, cCard.logo.mediaType!, cCard.logo.isBase64!);
    }

    if (cCard.photo.url != null) {
      formattedCCardString += getFormattedPhoto('PHOTO', cCard.photo.url!,
          cCard.photo.mediaType!, cCard.photo.isBase64!);
    }

    if (cCard.cellPhone != null) {
      if (cCard.cellPhone is! List) {
        cCard.cellPhone = [cCard.cellPhone];
      }

      cCard.cellPhone.forEach((number) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'TEL;VALUE=uri;TYPE="voice,cell":tel:' + e(number) + nl();
        } else {
          formattedCCardString += 'TEL;TYPE=CELL:' + e(number) + nl();
        }
      });
    }

    if (cCard.pagerPhone != null) {
      if (!cCard.pagerPhone is! List) {
        cCard.pagerPhone = [cCard.pagerPhone];
      }
      cCard.pagerPhone.forEach((number) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'TEL;VALUE=uri;TYPE="pager,cell":tel:' + e(number) + nl();
        } else {
          formattedCCardString += 'TEL;TYPE=PAGER:' + e(number) + nl();
        }
      });
    }

    if (cCard.homePhone != null) {
      if (cCard.homePhone is! List) {
        cCard.homePhone = [cCard.homePhone];
      }
      cCard.homePhone.forEach((number) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'TEL;VALUE=uri;TYPE="voice,home":tel:' + e(number) + nl();
        } else {
          formattedCCardString += 'TEL;TYPE=HOME,VOICE:' + e(number) + nl();
        }
      });
    }

    if (cCard.workPhone != null) {
      if (cCard.workPhone is! List) {
        cCard.workPhone = [cCard.workPhone];
      }
      cCard.workPhone.forEach((number) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'TEL;VALUE=uri;TYPE="voice,work":tel:' + e(number) + nl();
        } else {
          formattedCCardString += 'TEL;TYPE=WORK,VOICE:' + e(number) + nl();
        }
      });
    }

    if (cCard.homeFax != null) {
      if (cCard.homeFax is! List) {
        cCard.homeFax = [cCard.homeFax];
      }
      cCard.homeFax.forEach((number) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'TEL;VALUE=uri;TYPE="fax,home":tel:' + e(number) + nl();
        } else {
          formattedCCardString += 'TEL;TYPE=HOME,FAX:' + e(number) + nl();
        }
      });
    }

    if (cCard.workFax != null) {
      if (cCard.workFax is! List) {
        cCard.workFax = [cCard.workFax];
      }
      cCard.workFax.forEach((number) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'TEL;VALUE=uri;TYPE="fax,work":tel:' + e(number) + nl();
        } else {
          formattedCCardString += 'TEL;TYPE=WORK,FAX:' + e(number) + nl();
        }
      });
    }

    if (cCard.otherPhone != null) {
      if (cCard.otherPhone is! List) {
        cCard.otherPhone = [cCard.otherPhone];
      }
      cCard.otherPhone.forEach((number) {
        if (majorVersion >= 4) {
          formattedCCardString +=
              'TEL;VALUE=uri;TYPE="voice,other":tel:' + e(number) + nl();
        } else {
          formattedCCardString += 'TEL;TYPE=OTHER:' + e(number) + nl();
        }
      });
    }

    // Format Addresses
    formattedCCardString += getFormattedAddress(
        address: cCard.homeAddress, encodingPrefix: encodingPrefix);
    formattedCCardString += getFormattedAddress(
        address: cCard.workAddress, encodingPrefix: encodingPrefix);

    if (cCard.jobTitle != null) {
      formattedCCardString +=
          'TITLE' + encodingPrefix + ':' + e(cCard.jobTitle) + nl();
    }

    if (cCard.role != null) {
      formattedCCardString +=
          'ROLE' + encodingPrefix + ':' + e(cCard.role) + nl();
    }

    if (cCard.organization != null) {
      formattedCCardString +=
          'ORG' + encodingPrefix + ':' + e(cCard.organization) + nl();
    }

    if (cCard.url != null) {
      formattedCCardString +=
          'URL' + encodingPrefix + ':' + e(cCard.url) + nl();
    }

    if (cCard.workUrl != null) {
      formattedCCardString +=
          'URL;type=WORK' + encodingPrefix + ':' + e(cCard.workUrl) + nl();
    }

    if (cCard.note != null) {
      formattedCCardString +=
          'NOTE' + encodingPrefix + ':' + e(cCard.note) + nl();
    }

    if (cCard.socialUrls != null) {
      cCard.socialUrls!.forEach((key, value) {
        if ((value != null) && (value.isNotEmpty)) {
          formattedCCardString += 'X-SOCIALPROFILE' +
              encodingPrefix +
              ';TYPE=' +
              key +
              ':' +
              e(cCard.socialUrls![key]) +
              nl();
        }
      });
    }

    if (cCard.source != null) {
      formattedCCardString +=
          'SOURCE' + encodingPrefix + ':' + e(cCard.source) + nl();
    }

    formattedCCardString += 'REV:' + DateTime.now().toIso8601String() + nl();

    if (cCard.isOrganization) {
      formattedCCardString += 'X-ABShowAs:COMPANY' + nl();
    }

    formattedCCardString += 'END:VCARD' + nl();
    return formattedCCardString;
  }
}
