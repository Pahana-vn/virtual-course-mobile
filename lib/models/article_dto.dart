class ArticleDTO {
  final int id;
  final String content;
  final String fileUrl;
  final int lectureId;

  ArticleDTO({
    required this.id,
    required this.content,
    required this.fileUrl,
    required this.lectureId,
  });

  factory ArticleDTO.fromJson(Map<String, dynamic> json) {
    return ArticleDTO(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      content: json['content'] ?? "",
      fileUrl: json['fileUrl'] ?? "",
      lectureId: json['lectureId'] is int ? json['lectureId'] : int.tryParse(json['lectureId'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'fileUrl': fileUrl,
      'lectureId': lectureId,
    };
  }
}