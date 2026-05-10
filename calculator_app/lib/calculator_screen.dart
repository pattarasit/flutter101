import 'package:flutter/material.dart';
import 'calculator_logic.dart';
import 'calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _logic = CalculatorLogic();

  void _handleButton(String label) {
    setState(() {
      switch (label) {
        case 'AC':
          _logic.clear();
        case '+/-':
          _logic.toggleSign();
        case '%':
          _logic.percentage();
        case '=':
          _logic.calculate();
        case '.':
          _logic.inputDecimal();
        case '+':
        case '-':
        case '×':
        case '÷':
          _logic.inputOperator(label);
        default:
          _logic.inputDigit(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildPortrait()
                : _buildLandscape();
          },
        ),
      ),
    );
  }

  Widget _buildDisplay({bool compact = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: compact ? 8 : 20,
      ),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_logic.expression.isNotEmpty)
            Text(
              _logic.expression,
              style: TextStyle(
                color: Colors.white54,
                fontSize: compact ? 16 : 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _logic.display,
              style: TextStyle(
                color: Colors.white,
                fontSize: compact ? 56 : 80,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortrait() {
    return Column(
      children: [
        Expanded(child: _buildDisplay()),
        _buildPortraitButtons(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLandscape() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildDisplay(compact: true),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: _buildLandscapeButtons(),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitButtons() {
    const rows = [
      ['AC', '+/-', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '='],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final spacing = 12.0;
          final buttonSize = (constraints.maxWidth - spacing * 3) / 4;

          return Column(
            children: rows.map((row) {
              return Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: Row(
                  children: row.map((label) {
                    final isWide = label == '0';
                    return Padding(
                      padding: EdgeInsets.only(
                        right: row.last == label ? 0 : spacing,
                      ),
                      child: SizedBox(
                        width: isWide ? buttonSize * 2 + spacing : buttonSize,
                        height: buttonSize,
                        child: CalculatorButton(
                          label: label,
                          type: _buttonType(label),
                          isWide: isWide,
                          onTap: () => _handleButton(label),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildLandscapeButtons() {
    const rows = [
      ['AC', '+/-', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '='],
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = 10.0;
        final buttonSize = (constraints.maxWidth - spacing * 3) / 4;
        final rowHeight = (constraints.maxHeight - spacing * 4) / 5;

        return Column(
          children: rows.map((row) {
            return Padding(
              padding: EdgeInsets.only(bottom: spacing),
              child: Row(
                children: row.map((label) {
                  final isWide = label == '0';
                  return Padding(
                    padding: EdgeInsets.only(
                      right: row.last == label ? 0 : spacing,
                    ),
                    child: SizedBox(
                      width: isWide ? buttonSize * 2 + spacing : buttonSize,
                      height: rowHeight,
                      child: CalculatorButton(
                        label: label,
                        type: _buttonType(label),
                        isWide: isWide,
                        onTap: () => _handleButton(label),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  ButtonType _buttonType(String label) {
    if (label == '=') return ButtonType.equals;
    if (['+', '-', '×', '÷'].contains(label)) return ButtonType.operator;
    if (['AC', '+/-', '%'].contains(label)) return ButtonType.function;
    return ButtonType.number;
  }
}
