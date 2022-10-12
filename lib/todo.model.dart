class Todo {
  final String id;
  final String description;
  bool finished;

  Todo({required this.id, required this.description, required this.finished})
      : super();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'finished': finished,
    };
  }

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        finished = json['finished'];

  @override
  String toString() {
    return 'Todo($id, $description, $finished)';
  }

  @override
  List<Object> get props => [id, description, finished];
}
