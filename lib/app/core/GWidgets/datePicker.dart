import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime?>? onDateChanged;

  const CustomDatePicker({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      if (widget.onDateChanged != null) {
        widget.onDateChanged!(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: Container(
          padding: const EdgeInsets.only(left: 4, top: 2.2),
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: tfColor,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.date_range),
              border: InputBorder.none,
              hintText:
                  _selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                      : 'Select Date',
            ),
            controller: TextEditingController(
              text:
                  _selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                      : '',
            ),
          ),
        ),
      ),
    );
  }
}
