class HeaderResponse {
  HeaderResponse({
    required this.body,
    required this.headers,
  });

  Map<String, dynamic> body;
  Map<String, dynamic> headers;
}