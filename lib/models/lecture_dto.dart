import 'article_dto.dart';

class LectureDTO {
  final int id;
  final String titleLecture;
  final String lectureVideo;
  final String lectureResource;
  final int lectureOrder;
  final bool completed;
  final int sectionId;
  final List<ArticleDTO> articles;

  LectureDTO({
    required this.id,
    required this.titleLecture,
    required this.lectureVideo,
    required this.lectureResource,
    required this.lectureOrder,
    required this.completed,
    required this.sectionId,
    required this.articles,
  });

  factory LectureDTO.fromJson(Map<String, dynamic> json) {
    return LectureDTO(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      titleLecture: json['titleLecture'] ?? "",
      lectureVideo: json['lectureVideo'] ?? "",
      lectureResource: json['lectureResource'] ?? "",
      lectureOrder: json['lectureOrder'] is int ? json['lectureOrder'] : int.tryParse(json['lectureOrder'].toString()) ?? 0,
      completed: json['completed'] ?? false,
      sectionId: json['sectionId'] is int ? json['sectionId'] : int.tryParse(json['sectionId'].toString()) ?? 0,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((article) => ArticleDTO.fromJson(article))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleLecture': titleLecture,
      'lectureVideo': lectureVideo,
      'lectureResource': lectureResource,
      'lectureOrder': lectureOrder,
      'completed': completed,
      'sectionId': sectionId,
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }
}