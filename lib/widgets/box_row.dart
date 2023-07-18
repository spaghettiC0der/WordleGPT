import 'package:flutter/material.dart';
import 'package:proj3/models/row_data.dart';
import 'package:proj3/widgets/box.dart';

class BoxRow extends StatelessWidget {
  final int len;
  final RowData rowData;
  BoxRow({required this.len, required this.rowData});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        len,
        (index) => Box(
          txt: rowData.text[index],
          state: rowData.states[index],
        ),
      ),
    );
  }
}
