import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courses = List.generate(5, (i) => demoCourse[i]);
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Добро пожаловать',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 12),
            // big hero course card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: HeroCourseCard(),
            ),
            SizedBox(height: 18),
            // Popular courses header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Популярные курсы',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Посмотреть все'),
                    style: TextButton.styleFrom(foregroundColor: Color(0xFF1E73FF)),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            // courses list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: courses.map((c) => CourseListItem(course: c)).toList(),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class HeroCourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // card with background image, progress bar, button
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1525182008055-f88b95ff7980?w=1200'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF1E73FF).withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('Прохожу', style: TextStyle(color: Colors.white)),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 68,
            right: 16,
            child: Text(
              'Основы программирования\nна Python',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 48,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.4,
                    minHeight: 6,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2DD974)),
                  ),
                ),
                SizedBox(width: 12),
                Text('4/10 Уроков', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Positioned(
            left: 16,
            bottom: 8,
            right: 16,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E73FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Продолжить курс'),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseListItem extends StatelessWidget {
  final Course course;
  CourseListItem({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Row(
        children: [
          // thumbnail
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
            child: Container(
              width: 94,
              height: 94,
              child: Image.network(course.image, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // tag
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF1E73FF).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        course.tag,
                        style: TextStyle(color: Color(0xFF1E73FF), fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(course.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  SizedBox(height: 8),
                  Text('Количество модулей: ${course.modules}', style: TextStyle(color: Colors.grey[600], fontSize: 13))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Color blue = Color(0xFF1E73FF);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12),
              Text('Личный кабинет', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [blue, Color(0xFF2A6DF4)]),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,3))],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500'),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Кушмурат Ержан', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                            SizedBox(height: 6),
                            Text('iamerzhan@gmail.com', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // sections
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SectionCard(
                      title: 'Аккаунт',
                      children: [
                        SectionItem(icon: Icons.list_alt, title: 'Ваши курсы', subtitle: 'История ваших пройденных курсов'),
                      ],
                    ),
                    SizedBox(height: 12),
                    SectionCard(
                      title: 'Общие настройки',
                      children: [
                        SectionItem(icon: Icons.person_outline, title: 'Настройки профиля', subtitle: 'Изменить данные аккаунта'),
                        SectionItem(icon: Icons.language, title: 'Язык приложения', subtitle: 'Русский'),
                        SectionItem(icon: Icons.lock_outline, title: 'Безопасность', subtitle: 'Изменить настройки безопасности'),
                      ],
                    ),
                    SizedBox(height: 12),
                    SectionCard(
                      title: 'Разное',
                      children: [
                        SectionItem(icon: Icons.help_outline, title: 'Помощь', subtitle: 'Получить поддержку'),
                        SectionItem(icon: Icons.info_outline, title: 'О приложении', subtitle: 'Условиями использования'),
                        SectionItem(icon: Icons.privacy_tip_outlined, title: 'Политика конфиденциальности', subtitle: 'Наша политика конфиденциальности'),
                      ],
                    ),
                    SizedBox(height: 18),
                    // logout button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF6B61),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text('Выйти', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          SizedBox(height: 8),
          ...children
        ],
      ),
    );
  }
}

class SectionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  SectionItem({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Icon(icon, color: Colors.grey.shade700),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text;
  PlaceholderWidget(this.text);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: Text(text, style: TextStyle(fontSize: 18))),
    );
  }
}

// Demo data model
class Course {
  final String image;
  final String tag;
  final String title;
  final int modules;
  Course({required this.image, required this.tag, required this.title, required this.modules});
}

final List<Course> demoCourse = [
  Course(
      image: 'https://images.unsplash.com/photo-1531119674201-6ffb74ff9b5a?w=800',
      tag: 'Frontend',
      title: 'Разработка интерактивных интерфейсов с использованием React',
      modules: 5),
  Course(
      image: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800',
      tag: 'Mobile',
      title: 'Создание Android-приложений на Kotlin: от идеи до публикации',
      modules: 5),
  Course(
      image: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800',
      tag: 'Backend',
      title: 'REST и GraphQL API: проектирование и интеграция серверной логики',
      modules: 5),
  Course(
      image: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800',
      tag: 'UI/UX Design',
      title: 'Основы UX/UI-дизайна: принципы, композиция и пользовательский опыт',
      modules: 5),
  Course(
      image: 'https://images.unsplash.com/photo-1581093448792-5a3a1f5b4a1d?w=800',
      tag: 'Backend',
      title: 'Работа с базами данных и SQL: проектирование и запросы на практике',
      modules: 5),
];