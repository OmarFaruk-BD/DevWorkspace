class NotificationModel {
  final String? id;
  final String? comments;
  final String? title;
  final String? content;
  final String? priority;
  final String? createdAt;

  NotificationModel({
    this.id,
    this.comments,
    this.title,
    this.content,
    this.priority,
    this.createdAt,
  });

  NotificationModel copyWith({
    String? id,
    String? comments,
    String? title,
    String? content,
    String? priority,
    String? createdAt,
  }) => NotificationModel(
    id: id ?? this.id,
    comments: comments ?? this.comments,
    title: title ?? this.title,
    content: content ?? this.content,
    priority: priority ?? this.priority,
    createdAt: createdAt ?? this.createdAt,
  );
}
