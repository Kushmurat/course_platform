class Course {
  final int id;
  final String title;
  final String? image;
  final String? description;
  final List<String> result;
  final String? link;
  final int modulesCount;
  final List<Module> modules;
  final String? category;

  Course({
    required this.id,
    required this.title,
    this.image,
    this.description,
    required this.result,
    this.link,
    required this.modulesCount,
    required this.modules,
    this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      description: json["description"],

      result: json["result"] != null ? List<String>.from(json["result"]) : [],

      link: json["link"],
      modulesCount: json["modulesCount"] ?? 0,
      category: json["category"],

      modules: json["modules"] != null
          ? List<Module>.from(json["modules"].map((m) => Module.fromJson(m)))
          : [],
    );
  }
}

class Module {
  final int id;
  final String title;
  final List<String> children;

  Module({required this.id, required this.title, required this.children});

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json["id"],
      title: json["title"],

      children: json["children"] != null
          ? List<String>.from(json["children"])
          : [],
    );
  }
}
