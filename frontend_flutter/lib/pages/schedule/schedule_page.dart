import 'package:flutter/material.dart';

import '../../backend/backend_service.dart';
import '../../backend/session_manager.dart';
import '../../components/top_nav_bar/top_nav_bar_widget.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() =>
      _SchedulePageState();
}

class _SchedulePageState
    extends State<SchedulePage> {

    int timeToMinutes(String time) {
      final cleaned = time.trim().toUpperCase();

      final isPM = cleaned.endsWith('PM');
      final isAM = cleaned.endsWith('AM');

      final withoutAmPm = cleaned
          .replaceAll('AM', '')
          .replaceAll('PM', '')
          .trim();

      final parts = withoutAmPm.split(':');

      int hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      if (isPM && hour != 12) {
        hour += 12;
      }

      if (isAM && hour == 12) {
        hour = 0;
      }

      return hour * 60 + minute;
    }

    List<Map<String, dynamic>> classes = [];
    String userId = '';

    @override
    void initState() {
      super.initState();
      loadClasses();
    }

    Future<void> loadClasses() async {
      String email = await SessionManager.getEmail();
      if (email == '') return;
      final classesCheck =
          await BackendService.getAllClasses(
        userId: email,
      );

      setState(() {
        classes = classesCheck;
        userId = email;
      });
    }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    const days = ['Su', 'M', 'T', 'W', 'Th', 'F', 'Sa'];
    const startHour = 8;
    const endHour = 18;
    const hourHeight = 72.0;
    

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const TopNavBar(
            currentIndex: 3,
          ),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 760,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 40),
                          for (int hour = startHour; hour <= endHour; hour++)
                            SizedBox(
                              height: hourHeight,
                              width: 56,
                              child: Text(
                                '${hour.toString().padLeft(2, '0')}:00',
                                style: TextStyle(
                                  color: colors.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),

                      for (final day in days)
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(
                                    day,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: (endHour - startHour + 1) * hourHeight,
                                child: Stack(
                                  children: [
                                    for (int hour = startHour;
                                        hour <= endHour;
                                        hour++)
                                      Positioned(
                                        top: (hour - startHour) * hourHeight,
                                        left: 0,
                                        right: 0,
                                        child: Divider(
                                          color: colors.outlineVariant,
                                        ),
                                      ),

                                    for (final course in classes)
                                      if ((course['days'] as List<String>)
                                          .contains(day))
                                        _ClassBlock(
                                          courseCode:
                                              course['code'] as String,
                                          courseName:
                                              course['name'] as String,
                                          top: ((timeToMinutes(
                                                        course['startTime']
                                                            as String,
                                                      ) -
                                                      startHour * 60) /
                                                  60) *
                                              hourHeight,
                                          height: ((timeToMinutes(
                                                        course['endTime']
                                                            as String,
                                                      ) -
                                                      timeToMinutes(
                                                        course['startTime']
                                                            as String,
                                                      )) /
                                                  60) *
                                              hourHeight,
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClassBlock extends StatelessWidget {
  const _ClassBlock({
    required this.courseCode,
    required this.courseName,
    required this.top,
    required this.height,
  });

  final String courseCode;
  final String courseName;
  final double top;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Positioned(
      top: top,
      left: 4,
      right: 4,
      height: height,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colors.primary.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseCode,
              style: TextStyle(
                color: colors.onPrimaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              courseName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.onPrimaryContainer,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}