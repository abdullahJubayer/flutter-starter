import 'package:flutter/material.dart';
import 'package:flutter_template/core/widget/custom_card.dart';
import 'package:flutter_template/core/widget/date/custom_date_picker_field.dart';

class CustomDateFilter extends StatefulWidget {
  const CustomDateFilter({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.onDateSelected,
    required this.maxRange,
    this.isSelectFutureDate = false,
    this.margin,
  });

  final DateTime fromDate;
  final DateTime toDate;
  final Function(DateTime fromDate, DateTime toDate) onDateSelected;
  final int maxRange;
  final bool isSelectFutureDate;
  final EdgeInsetsGeometry? margin;

  @override
  State<CustomDateFilter> createState() => _CustomDateFilterState();
}

class _CustomDateFilterState extends State<CustomDateFilter> {
  late DateTime _fromDate;
  late DateTime _toDate;

  @override
  void initState() {
    _toDate = widget.toDate;
    _fromDate = widget.fromDate;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomDateFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fromDate != _fromDate || widget.toDate != _toDate) {
      setState(() {
        _fromDate = widget.fromDate;
        _toDate = widget.toDate;
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? _fromDate : _toDate,
      firstDate: DateTime(2000),
      lastDate: widget.isSelectFutureDate
          ? DateTime(DateTime.now().year + 1, 12)
          : DateTime.now(),
    );

    if (picked == null) return;

    final bool isMonthRange = widget.maxRange > 30;

    setState(() {
      if (isFromDate) {
        _fromDate = picked;

        if (isMonthRange) {
          final newTo = DateTime(
            _fromDate.year,
            _fromDate.month + (widget.maxRange ~/ 30),
            _fromDate.day,
          );
          final safeTo = newTo.isAfter(DateTime.now()) ? DateTime.now() : newTo;

          if (_toDate.isBefore(_fromDate) || _toDate.isAfter(safeTo)) {
            _toDate = safeTo;
          }
        } else {
          final latestAllowedTo = _fromDate.add(
            Duration(days: widget.maxRange),
          );
          final safeTo = latestAllowedTo.isAfter(DateTime.now())
              ? DateTime.now()
              : latestAllowedTo;

          if (_toDate.isBefore(_fromDate) || _toDate.isAfter(safeTo)) {
            _toDate = safeTo;
          }
        }
      } else {
        _toDate = picked;

        if (isMonthRange) {
          final newFrom = DateTime(
            _toDate.year,
            _toDate.month - (widget.maxRange ~/ 30),
            _toDate.day,
          );

          if (_fromDate.isAfter(_toDate) || _fromDate.isBefore(newFrom)) {
            _fromDate = newFrom;
          }
        } else {
          final earliestAllowedFrom = _toDate.subtract(
            Duration(days: widget.maxRange),
          );

          if (_fromDate.isAfter(_toDate) ||
              _fromDate.isBefore(earliestAllowedFrom)) {
            _fromDate = earliestAllowedFrom;
          }
        }
      }

      widget.onDateSelected(_fromDate, _toDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      borderWidth: 1,
      margin: widget.margin ?? EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: CustomDatePickerField(
                label: 'From',
                date: _fromDate,
                onTap: () => _selectDate(context, true),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomDatePickerField(
                label: 'To',
                date: _toDate,
                onTap: () => _selectDate(context, false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
