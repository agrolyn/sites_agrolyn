import 'package:flutter/material.dart';

class ItemNavbar extends StatelessWidget {
  final String name;
  final IconData iconName;
  final Function onClick;
  final bool? isActive;

  const ItemNavbar(
      {super.key,
      required this.name,
      required this.iconName,
      required this.onClick,
      this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick(),
      child: Container(
        decoration: BoxDecoration(
            color: isActive ?? false ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isActive ?? false ? Colors.green : const Color(0xFF46b9a8),
            )),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: isActive ?? false
                            ? Colors.white
                            : const Color(0xFF46b9a8),
                        width: 2)),
                child: Icon(iconName,
                    color: isActive ?? false
                        ? Colors.white
                        : const Color(0xFF46b9a8))),
            const SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(
                  color: isActive ?? false
                      ? Colors.white
                      : const Color(0xFF46b9a8)),
            ),
          ],
        ),
      ),
    );
  }
}
