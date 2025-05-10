import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ikus_app/model/event.dart';
import 'package:ikus_app/screens/event_screen.dart';

class DateEventsScreen extends StatelessWidget {
  final DateTime date;
  final List<Event> events;
  final void Function()? onEventPop;

  const DateEventsScreen({required this.date, required this.events, this.onEventPop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('dd.MM.yyyy').format(date)),
      ),
      body: events.isEmpty
          ? Center(child: Text("There are no events on this day."))
          : ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event.name),
            subtitle: Text(event.channel?.name ?? ''),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EventScreen(event)),
              );
              if (onEventPop != null) onEventPop!();
            },
          );
        },
      ),
    );
  }
}
