import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:ngsfer_wishlist/utils/money.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  test('Formata valor para exibição', () {
    expect(Money(cents: 199).toString(), '1,99');
    expect(Money(cents: 0).toString(), '0,00');
    expect(Money(cents: 15).toString(), '0,15');
    expect(Money(cents: 123456).toString(), '1.234,56');
    expect(Money(cents: 123456789).toString(), '1.234.567,89');
  });

  test('Compara dois valores', () {
    expect(Money(cents: 1), Money(cents: 1));
    expect(Money(cents: 0), Money(cents: 0));
  });

  test('Soma dois valores', () {
    expect(Money(cents: 100) + Money(cents: 100), Money(cents: 200));
    expect(Money(cents: 0) + Money(cents: 0), Money(cents: 0));
  });

  test('Subtrai dois valores', () {
    expect(Money(cents: 100) - Money(cents: 50), Money(cents: 50));
    expect(Money(cents: 50) - Money(cents: 100), Money(cents: -50));
  });

  test('Multiplica valor monetário por escalar', () {
    expect(Money(cents: 150) * 2, Money(cents: 300));
    expect(Money(cents: 400) * 2.5, Money(cents: 1000));
    expect(Money(cents: 100) * 2.12345, Money(cents: 212));
  });

  test('Divide valor monetário por escalar', () {
    expect(Money(cents: 500) / 5, Money(cents: 100));
    expect(Money(cents: 100) / 2.5, Money(cents: 40));
    expect(() => Money(cents: 0) / 0, throwsArgumentError);
  });
}
