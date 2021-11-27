
class Quotes{
  final int id;
  final String text;
  final String name;

  Quotes({
    required this.id,
    required this.name,
    required this.text
  });

  Quotes.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        text = json['text'] ?? '',
        name = json ['name'] ?? '' ;
}