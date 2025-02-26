part of contact_card_flutter;

class Photo {
  String? url;
  String? mediaType;
  bool? isBase64;

  /// Attach a photo from a URL
  /// @param  {string} url       URL where photo can be found
  /// @param  {string} mediaType Media type of photo (JPEG, PNG, GIF)
  attachFromUrl(url, mediaType) {
    this.url = url;
    this.mediaType = mediaType;
    this.isBase64 = false;
  }

  /// Embed a photo from a file using base-64 encoding
  /// @param  {string} filename
  embedFromFile(String imageFileUri) async {
    this.mediaType = path
        .extension(imageFileUri)
        .trim()
        .toUpperCase()
        .replaceFirst(RegExp(r'\./g'), '');
    final fs = File(imageFileUri);
    this.url = base64.encode(fs.readAsBytesSync());
    this.isBase64 = true;
  }

  /// Embed a photo from a base-64 string
  /// @param  {string} base64String
  embedFromString(base64String, mediaType) {
    this.mediaType = mediaType;
    this.url = base64String;
    this.isBase64 = true;
  }
}
