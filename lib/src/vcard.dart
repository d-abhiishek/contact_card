part of vcard_maintained;

/// vCard, Valery Colong, May 2019
class VCard {
  /// Specifies a value that represents a persistent, globally unique identifier associated with the vCard
  String? uid;

  /// Date of birth
  DateTime? birthday;

  /// Anniversary
  DateTime? anniversary;

  /// Cell phone number
  var cellPhone;

  /// Other cell phone number or pager
  var pagerPhone;

  /// The address for private electronic mail communication
  var email;

  /// The address for work-related electronic mail communication
  var workEmail;

  /// Other email address
  var otherEmail;

  /// First name
  String firstName = '';

  /// Middle name
  String middleName = '';

  /// Last name
  String lastName = '';

  /// Formatted name string associated with the vCard object (will automatically populate if not set)
  String? formattedName;

  /// Prefix for individual's name
  String namePrefix = '';

  /// Suffix for individual's name
  String nameSuffix = '';

  /// Nickname of individual
  String? nickname = '';

  /// Gender. Must be M or F for Male or Female
  String? gender;

  /// Home mailing address
  MailingAddress homeAddress = MailingAddress('HOME');

  /// Home phone
  var homePhone;

  /// Home facsimile
  var homeFax;

  /// Individual's photo
  Photo photo = Photo();

  /// Specifies supplemental information or a comment that is associated with the vCard
  String? note;

  /// The name and optionally the unit(s) of the organization associated with the vCard object
  String? organization;

  /// Logo
  Photo logo = Photo();

  /// The role, occupation, or business category of the vCard object within an organization
  String? role;

  /// Social URLs attached to the vCard object (ex: Facebook, Twitter, LinkedIn)
  /// @type {Map<String, String>}
  Map<String, String?>? socialUrls = getSocialUrls();

  /// A URL that can be used to get the latest version of this vCard
  String? source;

  /// Specifies the job title, functional position or function of the individual within an organization
  String? jobTitle;

  /// URL pointing to a website that represents the person in some way
  String? url;

  /// URL pointing to a website that represents the person's work in some way
  String? workUrl;

  /// Work mailing address
  MailingAddress workAddress = MailingAddress('WORK');

  /// Work phone
  var workPhone;

  /// Work facsimile
  var workFax;

  /// Other phone
  var otherPhone;

  /// Whether or not this vCard object represents an organization
  bool isOrganization = false;

  /// vCard version
  String? version = '3.0';

  /// Get major version of the vCard format
  /// @return {integer}
  int getMajorVersion() {
    String majorVersionString =
        (this.version != null) ? this.version!.split('.')[0] : '4';
    if (isNumeric(majorVersionString)) {
      return int.parse(majorVersionString);
    }
    return 4;
  }

  /// Get formatted vCard
  /// @return {String} Formatted vCard in VCF format
  String getFormattedString() => VCardFormatter().getFormattedString(this);

  /// Save formatted vCard to file
  /// @param  {String} filename
  saveToFile(filename) async {
    String contents = getFormattedString();

    final directory = await getApplicationDocumentsDirectory();
    final fs = File('${directory.path}/vCard/exports/$filename');
    fs.writeAsStringSync(contents);
  }

  /// Get social media URLs
  /// @return {Map<String, String>} Social media URL username map
  static Map<String, String> getSocialUrls() {
    return {
      'facebook': '',
      'linkedin': '',
      'twitter': '',
      'flickr': '',
      'instagram': '',
      'youtube': '',
    };
  }
}
