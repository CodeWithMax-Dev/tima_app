import 'package:flutter/material.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';

final errorboarder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(width: 1, color: Colors.red),
);

final boarder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(width: 1, color: colorConst.primarycolor),
);

final focusboarder = OutlineInputBorder(
  borderSide: const BorderSide(width: 1, color: colorConst.primarycolor),
  borderRadius: BorderRadius.circular(15),
);

final disableboarder = OutlineInputBorder(
  borderSide: const BorderSide(width: 1, color: colorConst.primarycolor),
  borderRadius: BorderRadius.circular(15),
);

const boarder1 = UnderlineInputBorder(
  borderSide: BorderSide(width: 2, color: Colors.grey),
);
const focusboarder1 = UnderlineInputBorder(
  borderSide: BorderSide(width: 2, color: colorConst.primarycolor),
);
const errorboarder1 = UnderlineInputBorder(
  borderSide: BorderSide(width: 2, color: Colors.red),
);
