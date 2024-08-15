bool isImageUrlFormatValid({
  String? urlStr,
}) {
  bool isValidUrl = false;
  urlStr ??= '';
  List<String> urlSchemeList = ['http://', 'https://'];
  List<String> imageExtList = ['.jpg', '.jpeg', '.png', '.gif'];
  if (urlStr.isNotEmpty) {
    isValidUrl = urlSchemeList
            .any((urlScheme) => urlStr!.toLowerCase().startsWith(urlScheme)) &&
        imageExtList
            .any((imageExt) => urlStr!.toLowerCase().contains(imageExt)) &&
        isUrlFormatValid(urlStr: urlStr);
  }
  return isValidUrl;
}

bool isUrlFormatValid({
  String? urlStr,
}) {
  urlStr ??= '';
  if (urlStr.isNotEmpty) {
    // Regular expression to check if the URL is in a valid format
    final RegExp urlRegExp = RegExp(
      r'^(?:http|ftp)s?://' // Scheme (http, https, ftp)
      r'(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+(?:[A-Z]{2,6}\.?|[A-Z0-9-]{2,}\.?)|' // Domain
      r'localhost|' // localhost
      r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}|' // IPv4
      r'\[?[A-F0-9]*:[A-F0-9:]+\]?)' // IPv6
      r'(?::\d+)?' // Port
      r'(?:/?|[/?]\S+)$', // Path
      caseSensitive: false,
    );
    return urlRegExp.hasMatch(urlStr);
  } else {
    return false;
  }
}
