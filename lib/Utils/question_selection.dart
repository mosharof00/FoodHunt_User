import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';
import 'app_text_style.dart';

class QuestionSelection extends StatefulWidget {
  final String questionText;
  final List<String> options;
  final Function(String) onOptionSelected;

  const QuestionSelection({
    super.key,
    required this.questionText,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  _QuestionSelectionState createState() => _QuestionSelectionState();
}

class _QuestionSelectionState extends State<QuestionSelection> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyle(
          text: widget.questionText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 40.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              final option = widget.options[index];
              final isSelected = selectedOption == option;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOption = option;
                  });
                  widget.onOptionSelected(
                      option); // Notify parent about selection
                },
                child: Container(
                  height: 40.h,
                  margin: EdgeInsets.only(bottom: 10.h, right: 14.w),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorName.onPrimary.withOpacity(0.3)
                        : ColorName.gray410.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: AppTextStyle(
                      text: option,
                      fontSize: 15,
                      color: isSelected
                          ? ColorName.onPrimary
                          : ColorName.appTextGrayColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
