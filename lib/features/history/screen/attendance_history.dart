import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workspace/core/utils/app_colors.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:workspace/features/history/widget/date_item.dart';
import 'package:workspace/features/history/cubit/attendance_cubit.dart';

class AttendanceHistoryPage extends StatefulWidget {
  const AttendanceHistoryPage({super.key});

  @override
  State<AttendanceHistoryPage> createState() => _AttendanceHistoryPageState();
}

class _AttendanceHistoryPageState extends State<AttendanceHistoryPage> {
  final List<Color> _colorList = [
    AppColors.green,
    AppColors.yellow,
    AppColors.red,
  ];

  @override
  void initState() {
    super.initState();
    _initDateList();
  }

  void _initDateList() {
    context.read<AttendanceCubit>().updateAttendanceHistory(
      startDate: DateTime.now().subtract(const Duration(days: 6)),
      endDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Attendance History',
        onBackTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SfDateRangePicker(
              view: DateRangePickerView.month,
              backgroundColor: AppColors.white,
              todayHighlightColor: AppColors.red,
              endRangeSelectionColor: AppColors.red,
              startRangeSelectionColor: AppColors.red,
              selectionMode: DateRangePickerSelectionMode.range,
              rangeSelectionColor: AppColors.red.withAlpha(40),
              headerStyle: DateRangePickerHeaderStyle(
                backgroundColor: AppColors.white,
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                showTrailingAndLeadingDates: true,
              ),
              initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 6)),
                DateTime.now(),
              ),
              onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                if (dateRangePickerSelectionChangedArgs.value
                    is PickerDateRange) {
                  final PickerDateRange range =
                      dateRangePickerSelectionChangedArgs.value;
                  setState(() {
                    if (range.startDate != null && range.endDate != null) {
                      context.read<AttendanceCubit>().updateAttendanceHistory(
                        startDate: range.startDate,
                        endDate: range.endDate,
                      );
                    }
                  });
                }
              },
            ),
            BlocBuilder<AttendanceCubit, AttendanceState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(height: 25),
                    if (state.isLoading) CircularProgressIndicator(),
                    ...List.generate(state.attendanceHistoryList.length, (
                      index,
                    ) {
                      final data = state.attendanceHistoryList[index];
                      return DateItem(
                        punchIn: data.punchIn ?? '',
                        punchOut: data.punchOut ?? '',
                        totalTime: data.totalHours ?? '',
                        day: data.day?.toString() ?? '',
                        dayName: data.dayName ?? '',
                        color: _colorList[index % 3],
                      );
                    }),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
