import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReceiptAlert extends StatelessWidget {
  const ReceiptAlert({super.key});
  @override
  Widget build(BuildContext context) {
    return   Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: ScallopedClipper(),
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 32),
                  Text("ملخص الفاتورة",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 8),
                  Text(
                    "يرجى مراجعة تفاصيل الفاتورة الخاصة بك",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Divider(),
                  _buildRow("كود السداد الإلكتروني", "00534567890"),
                  _buildRow("التاريخ والوقت", "22 مايو 2024 11:30 ص"),
                  _buildRow("قيمة الخدمة", "35.71 جم"),
                  _buildRow("مصاريف الخدمة", "2.5 جم"),
                  Divider(),
                  _buildRow("الإجمالي", "38.21 جم", isBold: true),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("دفع"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -32,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.receipt_long,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class ScallopedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from the top left corner
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 30);

    // Add scalloped effect
    for (double i = 0; i < size.width; i += 20) {
      path.arcToPoint(
        Offset(i + 10, size.height - 30),
        radius: Radius.circular(10),
        clockwise: false,
      );
      path.arcToPoint(
        Offset(i + 20, size.height - 30),
        radius: Radius.circular(10),
        clockwise: true,
      );
    }

    // Complete the path
    path.lineTo(size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}