import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel/model/booking_model.dart';
import 'package:travel/view/user/booking/conform_payment.dart';
import 'package:travel/view/user/home/detail_booking_page.dart';

class DatePage extends StatefulWidget {
  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  CalendarFormat calendarFormat = CalendarFormat.month;

  DateTime? rangeStart;
  DateTime? rangeEnd;

  @override
  void initState() {
    super.initState();
    selectedDay = focusedDay;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      setState(() {
        this.selectedDay = selectedDay;
        this.focusedDay = focusedDay;
      });
    }
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      selectedDay = null;
      this.focusedDay = focusedDay;
      rangeStart = start;
      rangeEnd = end;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Available date'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Choose Your Booking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                onDaySelected(selectedDay, focusedDay);
                showBookingBottomSheet(context, selectedDay);
              },
              rangeStartDay: rangeStart,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              onRangeSelected: onRangeSelected,
              rangeEndDay: rangeEnd,
              calendarFormat: calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  this.focusedDay = focusedDay;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      backgroundColor: Color.fromARGB(255, 244, 240, 240),
                    ),
                    child: const Text('Back',
                        style: TextStyle(
                            color: Color.fromARGB(255, 133, 133, 133),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBooking(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showBookingBottomSheet(BuildContext context, DateTime selectedDay) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Booking for ${selectedDay.toLocal()}'.split(' ')[0],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Do you want to book this date?'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmPayment(
                            bookingData: BookingModel(
                              name: 'Guest Name', // Replace with actual data
                              email:
                                  'guest@example.com', // Replace with actual data
                              gestNo: '2', // Replace with actual data
                              phoneNumber:
                                  '1234567890', // Replace with actual data
                              date:
                                  selectedDay.toString(), // Pass selected date
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
