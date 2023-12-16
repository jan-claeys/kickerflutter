
class KickerException implements Exception {
  final String message;
  final String title;

  KickerException({
    required this.message,
    this.title = "Error",
  });
}