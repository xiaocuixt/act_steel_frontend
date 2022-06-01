class Memo {
  final String id;
  final String content;
  final String createdAt;

  Memo({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
        id: json['id'], content: json['content'], createdAt: json['createdAt']);
  }
}
