import 'package:meta/meta.dart';

class Task {
  final String id;
  final String title;
  final String description;
  Task({
    @required this.id,
    @required this.title,
    @required this.description,
  });
}
