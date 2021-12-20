import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum STPickerColumnType {
  year,
  month,
  day,
}

const _selectTextsHeight = 302.0;
const _selectTitleHeight = 48.0;
const _pickerItemExtent = 44.0;
const _textStyle = TextStyle(
    color: Color(0xFF555555), fontSize: 16, fontWeight: FontWeight.w400);
const _unitTextStyle = TextStyle(
    color: Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.w500);

// TextStyle _themeTextStyle(BuildContext context, {bool isValid = true}) {
//   return isValid
//       ? _textStyle
//       : const TextStyle(color: Color(0x45555555), fontSize: 16);
// }

void _animateColumnControllerToItem(
    FixedExtentScrollController controller, int targetItem) {
  controller.animateToItem(
    targetItem,
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 200),
  );
}

class _STDatePickerLayoutDelegate extends MultiChildLayoutDelegate {
  _STDatePickerLayoutDelegate({
    @required this.columnWidths,
    @required this.textDirectionFactor,
  })  : assert(columnWidths != null),
        assert(textDirectionFactor != null);
  // The list containing widths of all columns.
  final List<double> columnWidths;
  // textDirectionFactor is 1 if text is written left to right, and -1 if right to left.
  final int textDirectionFactor;

  @override
  void performLayout(Size size) {
    double remainingWidth = size.width;

    for (int i = 0; i < columnWidths.length; i++) {
      remainingWidth -= columnWidths[i] + 10 * 2;
    }

    double currentHorizontalOffset = 0.0;

    for (int i = 0; i < columnWidths.length; i++) {
      final int index =
          textDirectionFactor == 1 ? i : columnWidths.length - i - 1;

      double childWidth = columnWidths[index] + 10 * 2;
      if (index == 0 || index == columnWidths.length - 1) {
        childWidth += remainingWidth / 2;
      }

      // We can't actually assert here because it would break things badly for
      // semantics, which will expect that we laid things out here.
      assert(() {
        if (childWidth < 0) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: FlutterError(
                'Insufficient horizontal space to render the '
                'CupertinoDatePicker because the parent is too narrow at '
                '${size.width}px.\n'
                'An additional ${-remainingWidth}px is needed to avoid '
                'overlapping columns.',
              ),
            ),
          );
        }
        return true;
      }());
      layoutChild(index,
          BoxConstraints.tight(Size(math.max(0.0, childWidth), size.height)));
      positionChild(index, Offset(currentHorizontalOffset, 0.0));

      currentHorizontalOffset += childWidth;
    }
  }

  @override
  bool shouldRelayout(_STDatePickerLayoutDelegate oldDelegate) {
    return columnWidths != oldDelegate.columnWidths ||
        textDirectionFactor != oldDelegate.textDirectionFactor;
  }
}

class STCuperDatePicker extends StatefulWidget {
  STCuperDatePicker({
    Key key,
    @required this.onDateTimeChanged,
    DateTime initialDateTime,
    this.minimumDate,
    this.maximumDate,
    this.minimumYear = 1,
    this.maximumYear,
  })  : initialDateTime = initialDateTime ?? DateTime.now(),
        assert(onDateTimeChanged != null),
        super(key: key);

  final DateTime initialDateTime;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final int minimumYear;
  final int maximumYear;
  final ValueChanged<DateTime> onDateTimeChanged;

  @override
  _STCuperDatePickerState createState() => _STCuperDatePickerState();

  static double _getColumnWidth(
    STPickerColumnType columnType,
    BuildContext context,
  ) {
    String longestText = '';
    switch (columnType) {
      case STPickerColumnType.day:
        for (int i = 1; i <= 31; i++) {
          final String dayOfMonth = '$i';
          if (longestText.length < dayOfMonth.length) longestText = dayOfMonth;
        }
        break;
      case STPickerColumnType.month:
        for (int i = 1; i <= 12; i++) {
          final String month = '$i';
          if (longestText.length < month.length) longestText = month;
        }
        break;
      case STPickerColumnType.year:
        longestText = '2021';
        break;
    }

    assert(longestText != '', 'column type is not appropriate');

    final TextPainter painter = TextPainter(
      text: TextSpan(
        style: _textStyle,
        text: longestText,
      ),
      textDirection: Directionality.of(context),
    );

    // This operation is expensive and should be avoided. It is called here only
    // because there's no other way to get the information we want without
    // laying out the text.
    painter.layout();

    return painter.maxIntrinsicWidth;
  }
}

typedef _ColumnBuilder = Widget Function(
    TransitionBuilder itemPositioningBuilder, Widget selectionOverlay);

class _STCuperDatePickerState extends State<STCuperDatePicker> {
  int textDirectionFactor;
  // The currently selected values of the picker.
  int selectedDay;
  int selectedMonth;
  int selectedYear;
  // The controller of the day picker. There are cases where the selected value
  // of the picker is invalid (e.g. February 30th 2018), and this dayController
  // is responsible for jumping to a valid value.
  FixedExtentScrollController dayController;
  FixedExtentScrollController monthController;
  FixedExtentScrollController yearController;

  bool isDayPickerScrolling = false;
  bool isMonthPickerScrolling = false;
  bool isYearPickerScrolling = false;

  bool get isScrolling =>
      isDayPickerScrolling || isMonthPickerScrolling || isYearPickerScrolling;

  // Estimated width of columns.
  Map<int, double> estimatedColumnWidths = <int, double>{};

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialDateTime.day;
    selectedMonth = widget.initialDateTime.month;
    selectedYear = widget.initialDateTime.year;

    dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
    monthController =
        FixedExtentScrollController(initialItem: selectedMonth - 1);
    yearController = FixedExtentScrollController(initialItem: selectedYear);

    PaintingBinding.instance.systemFonts.addListener(_handleSystemFontsChange);
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();

    PaintingBinding.instance.systemFonts
        .removeListener(_handleSystemFontsChange);
    super.dispose();
  }

  void _handleSystemFontsChange() {
    setState(() {
      // System fonts change might cause the text layout width to change.
      _refreshEstimatedColumnWidths();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    textDirectionFactor =
        Directionality.of(context) == TextDirection.ltr ? 1 : -1;

    _refreshEstimatedColumnWidths();
  }

  void _refreshEstimatedColumnWidths() {
    estimatedColumnWidths[STPickerColumnType.day.index] =
        STCuperDatePicker._getColumnWidth(STPickerColumnType.day, context);
    estimatedColumnWidths[STPickerColumnType.month.index] =
        STCuperDatePicker._getColumnWidth(STPickerColumnType.month, context);
    estimatedColumnWidths[STPickerColumnType.year.index] =
        STCuperDatePicker._getColumnWidth(STPickerColumnType.year, context);
  }

  DateTime _lastDayInMonth(int year, int month) => DateTime(year, month + 1, 0);

  Widget _buildDayPicker(
      TransitionBuilder itemPositioningBuilder, Widget selectionOverlay) {
    // final int daysInCurrentMonth =
    //     _lastDayInMonth(selectedYear, selectedMonth).day;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          isDayPickerScrolling = true;
        } else if (notification is ScrollEndNotification) {
          isDayPickerScrolling = false;
          _pickerDidStopScrolling();
        }
        return false;
      },
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            textStyle: _textStyle,
            pickerTextStyle: _unitTextStyle,
          ),
        ),
        child: CupertinoPicker(
          scrollController: dayController,
          itemExtent: _pickerItemExtent,
          useMagnifier: true,
          onSelectedItemChanged: (int index) {
            selectedDay = index + 1;
            if (_isCurrentDateValid) {
              widget.onDateTimeChanged(
                  DateTime(selectedYear, selectedMonth, selectedDay));
            }
          },
          looping: true,
          selectionOverlay: selectionOverlay,
          children: List<Widget>.generate(31, (int index) {
            final int day = index + 1;
            return itemPositioningBuilder(
              context,
              Text(
                '$day',
                // style: _themeTextStyle(context,
                //     isValid: day <= daysInCurrentMonth),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMonthPicker(
      TransitionBuilder itemPositioningBuilder, Widget selectionOverlay) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          isMonthPickerScrolling = true;
        } else if (notification is ScrollEndNotification) {
          isMonthPickerScrolling = false;
          _pickerDidStopScrolling();
        }

        return false;
      },
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            textStyle: _textStyle,
            pickerTextStyle: _unitTextStyle,
          ),
        ),
        child: CupertinoPicker(
          scrollController: monthController,
          itemExtent: _pickerItemExtent,
          useMagnifier: true,
          onSelectedItemChanged: (int index) {
            selectedMonth = index + 1;
            if (_isCurrentDateValid) {
              widget.onDateTimeChanged(
                  DateTime(selectedYear, selectedMonth, selectedDay));
            }
          },
          looping: true,
          selectionOverlay: selectionOverlay,
          children: List<Widget>.generate(12, (int index) {
            final int month = index + 1;
            // final bool isInvalidMonth =
            //     (widget.minimumDate?.year == selectedYear &&
            //             widget.minimumDate.month > month) ||
            //         (widget.maximumDate?.year == selectedYear &&
            //             widget.maximumDate.month < month);
            return itemPositioningBuilder(
              context,
              Text(
                '$month',
                // style: _themeTextStyle(context, isValid: !isInvalidMonth),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildYearPicker(
      TransitionBuilder itemPositioningBuilder, Widget selectionOverlay) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          isYearPickerScrolling = true;
        } else if (notification is ScrollEndNotification) {
          isYearPickerScrolling = false;
          _pickerDidStopScrolling();
        }

        return false;
      },
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            textStyle: _textStyle,
            pickerTextStyle: _unitTextStyle,
          ),
        ),
        child: CupertinoPicker.builder(
          scrollController: yearController,
          itemExtent: _pickerItemExtent,
          useMagnifier: true,
          onSelectedItemChanged: (int index) {
            selectedYear = index;
            if (_isCurrentDateValid) {
              widget.onDateTimeChanged(
                  DateTime(selectedYear, selectedMonth, selectedDay));
            }
          },
          itemBuilder: (BuildContext context, int year) {
            if (year < widget.minimumYear) return null;

            if (widget.maximumYear != null && year > widget.maximumYear) {
              return null;
            }

            // final bool isValidYear = (widget.minimumDate == null ||
            //         widget.minimumDate.year <= year) &&
            //     (widget.maximumDate == null || widget.maximumDate.year >= year);

            return itemPositioningBuilder(
              context,
              Text(
                '$year',
                // style: _themeTextStyle(context, isValid: isValidYear),
              ),
            );
          },
          selectionOverlay: selectionOverlay,
        ),
      ),
    );
  }

  bool get _isCurrentDateValid {
    // The current date selection represents a range [minSelectedData, maxSelectDate].
    final DateTime minSelectedDate =
        DateTime(selectedYear, selectedMonth, selectedDay);
    final DateTime maxSelectedDate =
        DateTime(selectedYear, selectedMonth, selectedDay + 1);

    final bool minCheck = widget.minimumDate?.isBefore(maxSelectedDate) ?? true;
    final bool maxCheck =
        widget.maximumDate?.isBefore(minSelectedDate) ?? false;

    return minCheck && !maxCheck && minSelectedDate.day == selectedDay;
  }

  // One or more pickers have just stopped scrolling.
  void _pickerDidStopScrolling() {
    // Call setState to update the greyed out days/months/years, as the currently
    // selected year/month may have changed.
    setState(() {});

    if (isScrolling) {
      return;
    }

    // Whenever scrolling lands on an invalid entry, the picker
    // automatically scrolls to a valid one.
    final DateTime minSelectDate =
        DateTime(selectedYear, selectedMonth, selectedDay);
    final DateTime maxSelectDate =
        DateTime(selectedYear, selectedMonth, selectedDay + 1);

    final bool minCheck = widget.minimumDate?.isBefore(maxSelectDate) ?? true;
    final bool maxCheck = widget.maximumDate?.isBefore(minSelectDate) ?? false;

    if (!minCheck || maxCheck) {
      // We have minCheck === !maxCheck.
      final DateTime targetDate =
          minCheck ? widget.maximumDate : widget.minimumDate;
      _scrollToDate(targetDate);
      return;
    }

    // Some months have less days (e.g. February). Go to the last day of that month
    // if the selectedDay exceeds the maximum.
    if (minSelectDate.day != selectedDay) {
      final DateTime lastDay = _lastDayInMonth(selectedYear, selectedMonth);
      _scrollToDate(lastDay);
    }
  }

  void _scrollToDate(DateTime newDate) {
    assert(newDate != null);
    SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
      if (selectedYear != newDate.year) {
        _animateColumnControllerToItem(yearController, newDate.year);
      }

      if (selectedMonth != newDate.month) {
        _animateColumnControllerToItem(monthController, newDate.month - 1);
      }

      if (selectedDay != newDate.day) {
        _animateColumnControllerToItem(dayController, newDate.day - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<_ColumnBuilder> pickerBuilders = <_ColumnBuilder>[];
    List<double> columnWidths = <double>[];

    pickerBuilders = <_ColumnBuilder>[
      _buildYearPicker,
      _buildMonthPicker,
      _buildDayPicker
    ];
    columnWidths = <double>[
      estimatedColumnWidths[STPickerColumnType.year.index],
      estimatedColumnWidths[STPickerColumnType.month.index],
      estimatedColumnWidths[STPickerColumnType.day.index],
    ];

    final List<Widget> pickers = <Widget>[];

    for (int i = 0; i < columnWidths.length; i++) {
      EdgeInsets margin = const EdgeInsets.all(0);
      if (i == 0) {
        margin = const EdgeInsets.only(right: _pickerItemExtent);
      } else if (i == columnWidths.length - 1) {
        margin = const EdgeInsets.only(left: _pickerItemExtent);
      }

      pickers.add(LayoutId(
        id: i,
        child: pickerBuilders[i](
          (BuildContext context, Widget child) {
            return Container(
              margin: margin,
              alignment: Alignment.center,
              width: columnWidths[i] + _pickerItemExtent / 2,
              child: child,
            );
          },
          const CupertinoPickerDefaultSelectionOverlay(
            capLeftEdge: false,
            capRightEdge: false,
          ),
        ),
      ));
    }
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: DefaultTextStyle.merge(
        style: _textStyle,
        child: Stack(
          children: [
            CustomMultiChildLayout(
              delegate: _STDatePickerLayoutDelegate(
                columnWidths: columnWidths,
                textDirectionFactor: textDirectionFactor,
              ),
              children: pickers,
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 4,
              top: (_selectTextsHeight -
                      _selectTitleHeight -
                      _pickerItemExtent) /
                  2,
              child: Container(
                padding: const EdgeInsets.only(bottom: 2),
                height: _pickerItemExtent,
                alignment: Alignment.center,
                child: const Text(
                  '年',
                  style: _unitTextStyle,
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2,
              top: (_selectTextsHeight -
                      _selectTitleHeight -
                      _pickerItemExtent) /
                  2,
              child: Container(
                padding: const EdgeInsets.only(
                    bottom: 2, left: _pickerItemExtent / 2),
                height: _pickerItemExtent,
                alignment: Alignment.center,
                child: const Text(
                  '月',
                  style: _unitTextStyle,
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width / 4 -
                  _pickerItemExtent -
                  columnWidths[2] -
                  10,
              top: (_selectTextsHeight -
                      _selectTitleHeight -
                      _pickerItemExtent) /
                  2,
              child: Container(
                padding: const EdgeInsets.only(bottom: 2),
                height: _pickerItemExtent,
                alignment: Alignment.center,
                child: const Text(
                  '日',
                  style: _unitTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
