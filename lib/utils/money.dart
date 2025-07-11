import 'package:intl/intl.dart';

class Money {
  int cents;

  Money({required this.cents});

  @override
  String toString() {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(cents / 100);
  }

  Money operator +(Money other) => Money(cents: cents + other.cents);
  Money operator -(Money other) => Money(cents: cents - other.cents);
  Money operator *(num factor) => Money(cents: (cents * factor).round());
  Money operator /(num divisor) {
    if (divisor == 0) {
      throw ArgumentError('Cannot divide money by zero');
    }
    return Money(cents: (cents / divisor).round());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Money &&
          runtimeType == other.runtimeType &&
          cents == other.cents;

  @override
  int get hashCode => cents.hashCode;
}
