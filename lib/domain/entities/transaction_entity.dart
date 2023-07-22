import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? note;
  final double? total;
  final String? type;

  const TransactionEntity({
    this.id,
    this.userId,
    this.note,
    this.total,
    this.type,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        note,
        total,
        type,
      ];
}
