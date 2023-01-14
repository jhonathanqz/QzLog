//Model class to map database fields.
class QzLogModel {
  final int? id;
  final String? createdAt;
  final String? log;
  final String? exception;

  QzLogModel({
    this.id,
    this.createdAt,
    this.log,
    this.exception,
  });

  QzLogModel copyWith({
    int? id,
    String? createdAt,
    String? log,
    String? exception,
  }) =>
      QzLogModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        log: log ?? this.log,
        exception: exception ?? this.exception,
      );

  factory QzLogModel.fromJson(Map<String, dynamic> json) {
    return QzLogModel(
      id: json["id"] ?? 0,
      createdAt: json['createdAt'] ?? '',
      log: json['log'] ?? '',
      exception: json['exception'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['log'] = log;
    data['exception'] = exception;
    return data;
  }
}
