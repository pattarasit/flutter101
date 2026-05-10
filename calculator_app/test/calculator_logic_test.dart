import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/calculator_logic.dart';

void main() {
  late CalculatorLogic calc;

  setUp(() => calc = CalculatorLogic());

  test('initial display is 0', () {
    expect(calc.display, '0');
  });

  test('addition', () {
    calc.inputDigit('5');
    calc.inputOperator('+');
    calc.inputDigit('3');
    calc.calculate();
    expect(calc.display, '8');
  });

  test('subtraction', () {
    calc.inputDigit('9');
    calc.inputOperator('-');
    calc.inputDigit('4');
    calc.calculate();
    expect(calc.display, '5');
  });

  test('multiplication', () {
    calc.inputDigit('6');
    calc.inputOperator('×');
    calc.inputDigit('7');
    calc.calculate();
    expect(calc.display, '42');
  });

  test('division', () {
    calc.inputDigit('8');
    calc.inputOperator('÷');
    calc.inputDigit('2');
    calc.calculate();
    expect(calc.display, '4');
  });

  test('division by zero returns Error', () {
    calc.inputDigit('5');
    calc.inputOperator('÷');
    calc.inputDigit('0');
    calc.calculate();
    expect(calc.display, 'Error');
  });

  test('percentage', () {
    calc.inputDigit('5');
    calc.inputDigit('0');
    calc.percentage();
    expect(calc.display, '0.5');
  });

  test('toggle sign', () {
    calc.inputDigit('9');
    calc.toggleSign();
    expect(calc.display, '-9');
  });

  test('clear resets to 0', () {
    calc.inputDigit('9');
    calc.inputOperator('+');
    calc.inputDigit('1');
    calc.clear();
    expect(calc.display, '0');
    expect(calc.expression, '');
  });
}
