import 'package:flutter/material.dart';

class ReusableHeader extends StatelessWidget {
  final String name;
  final String greeting;
  final String url;
  final VoidCallback onMenuTap;

  const ReusableHeader({
    super.key,
    required this.name,
    required this.greeting,
    required this.url,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 30.0, backgroundImage: AssetImage(url)),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 161, 117),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 39, 87, 166),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: onMenuTap,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 246, 234, 228),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.menu,
                color: Color.fromARGB(255, 255, 163, 120),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
