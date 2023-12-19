import 'package:flutter/material.dart';
import '../../../style/AppColors.dart';

class TimeInputGetter extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;

  const TimeInputGetter({Key? key, required this.onTimeSelected}) : super(key: key);

  @override
  _TimeInputGetterState createState() => _TimeInputGetterState();
}

class _TimeInputGetterState extends State<TimeInputGetter> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.onTimeSelected(selectedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary550),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              selectedTime.format(context),
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(Icons.access_time),
          ],
        ),
      ),
    );
  }
}

DateTime combineDateTime(TimeOfDay? timeOfDay, String selectedDay) {
  final now = DateTime.now();
  final date = selectedDay == "Өнөөдөр" ? now : DateTime(now.year, now.month, now.day + 1);
  return DateTime(
    date.year,
    date.month,
    date.day,
    timeOfDay?.hour ?? 0,
    timeOfDay?.minute ?? 0,
  );
}
