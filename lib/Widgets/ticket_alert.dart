import 'package:flutter/material.dart';

// class InvoiceSummaryScreen extends StatelessWidget {
//
//   static const String routeName = "/nvoiceSummaryScreen";
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             ClipPath(
//               clipper: ScallopClipper(),
//               child: Container(
//                 width: 320,
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(height: 32), // Space for the floating icon
//                     Text(
//                       "ملخص الفاتورة",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       "يرجى مراجعة تفاصيل الفاتورة الخاصة بك",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Divider(),
//                     _buildRow("كود السداد الإلكتروني", "00534567890"),
//                     _buildRow("التاريخ والوقت", "22 مايو 2024 11:30 ص"),
//                     _buildRow("قيمة الخدمة", "35.71 جم"),
//                     _buildRow("مصاريف الخدمة", "2.5 جم"),
//                     const Divider(),
//                     _buildRow("الإجمالي", "38.21 جم", isBold: true),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         // primary: Colors.pink,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         "دفع",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               top: -32,
//               left: 0,
//               right: 0,
//               child: CircleAvatar(
//                 radius: 32,
//                 backgroundColor: Colors.red,
//                 child: Icon(
//                   Icons.receipt_long,
//                   color: Colors.white,
//                   size: 32,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }

class ScallopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);

    for (double i = 0; i < size.width; i += 20) {
      path.arcToPoint(
        Offset(i + 10, size.height),
        radius: Radius.circular(10),
        clockwise: false,
      );
      path.arcToPoint(
        Offset(i + 20, size.height - 20),
        radius: Radius.circular(10),
        clockwise: false,
      );
    }

    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}