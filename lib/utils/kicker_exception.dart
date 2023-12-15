class KickerException implements Exception {
  final dynamic message;

  KickerException([this.message]);

  get getMessage => message;
}