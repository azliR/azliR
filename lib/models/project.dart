class Project {
  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.technologies,
    required this.images,
    required this.vertical,
    this.platforms,
    this.documents,
    this.sourceCode,
    this.visits,
  });
  final String id;
  final String name;
  final String description;
  final String shortDescription;
  final String? sourceCode;
  final List<String>? visits;
  final List<String> technologies;
  final List<String>? platforms;
  final Map<String, String>? documents;
  final List<String> images;
  final bool vertical;
}
