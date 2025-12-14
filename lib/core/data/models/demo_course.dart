class DemoCourse {
  final String image;
  final String tag;
  final String title;
  final int modules;

  DemoCourse({
    required this.image,
    required this.tag,
    required this.title,
    required this.modules,
  });
}

final List<DemoCourse> demoCourses = [
  DemoCourse(
    image: 'https://images.unsplash.com/photo-1531119674201-6ffb74ff9b5a?w=800',
    tag: 'Frontend',
    title: 'Разработка интерактивных интерфейсов с использованием React',
    modules: 5,
  ),
  DemoCourse(
    image: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800',
    tag: 'Mobile',
    title: 'Создание Android-приложений на Kotlin: от идеи до публикации',
    modules: 5,
  ),
  DemoCourse(
    image: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800',
    tag: 'Backend',
    title: 'REST и GraphQL API: проектирование и интеграция серверной логики',
    modules: 5,
  ),
  DemoCourse(
    image: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800',
    tag: 'UI/UX Design',
    title: 'Основы UX/UI-дизайна: принципы, композиция и пользовательский опыт',
    modules: 5,
  ),
  DemoCourse(
    image: 'https://images.unsplash.com/photo-1581093448792-5a3a1f5b4a1d?w=800',
    tag: 'Backend',
    title: 'Работа с базами данных и SQL: проектирование и запросы на практике',
    modules: 5,
  ),
];
