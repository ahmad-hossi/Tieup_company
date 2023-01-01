import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DynamicWidget extends StatelessWidget {
  DynamicWidget({super.key,required this.labelText, required this.addDynamic});

  final TextEditingController controller = TextEditingController();
  final String labelText;
  void Function() addDynamic;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 10.w,
              width: 10.w,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              width: 200,
              height: 42.h,
              child:  TextFormField(
                controller: controller,
                decoration:  InputDecoration(
                    labelText: labelText,
                    border: const OutlineInputBorder(),
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: addDynamic,
              style: TextButton.styleFrom(
                  side: const BorderSide(color: Colors.blueAccent)),
              child: const Icon(Icons.add,color: Colors.blueAccent,),
            ),
          ],
        ),
        SizedBox(height: 8.h,)
      ],
    );
  }

}