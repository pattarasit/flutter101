class CalculatorLogic {
  String _display = '0';
  String _expression = '';
  double _firstOperand = 0;
  String _operator = '';
  bool _shouldResetDisplay = false;

  String get display => _display;
  String get expression => _expression;

  void inputDigit(String digit) {
    if (_shouldResetDisplay) {
      _display = digit;
      _shouldResetDisplay = false;
    } else {
      _display = _display == '0' ? digit : _display + digit;
    }
  }

  void inputDecimal() {
    if (_shouldResetDisplay) {
      _display = '0.';
      _shouldResetDisplay = false;
      return;
    }
    if (!_display.contains('.')) {
      _display += '.';
    }
  }

  void inputOperator(String op) {
    final current = double.tryParse(_display) ?? 0;

    if (_operator.isNotEmpty && !_shouldResetDisplay) {
      _calculate(current);
      _expression = '${_formatNumber(_firstOperand)} $op';
    } else {
      _firstOperand = current;
      _expression = '${_formatNumber(current)} $op';
    }

    _operator = op;
    _shouldResetDisplay = true;
  }

  void calculate() {
    if (_operator.isEmpty) return;
    final second = double.tryParse(_display) ?? 0;
    _expression = '${_expression} ${_formatNumber(second)} =';
    _calculate(second);
    _operator = '';
    _shouldResetDisplay = true;
  }

  void _calculate(double second) {
    switch (_operator) {
      case '+':
        _firstOperand += second;
      case '-':
        _firstOperand -= second;
      case '×':
        _firstOperand *= second;
      case '÷':
        _firstOperand = second != 0 ? _firstOperand / second : double.nan;
    }
    _display = _formatNumber(_firstOperand);
  }

  void toggleSign() {
    final value = double.tryParse(_display) ?? 0;
    _display = _formatNumber(-value);
  }

  void percentage() {
    final value = double.tryParse(_display) ?? 0;
    _display = _formatNumber(value / 100);
  }

  void clear() {
    _display = '0';
    _expression = '';
    _firstOperand = 0;
    _operator = '';
    _shouldResetDisplay = false;
  }

  String _formatNumber(double value) {
    if (value.isNaN) return 'Error';
    if (value == value.truncateToDouble()) {
      final intVal = value.toInt();
      return intVal.toString();
    }
    // Limit decimal places to avoid floating-point noise
    final formatted = value.toStringAsFixed(10);
    return formatted.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}
