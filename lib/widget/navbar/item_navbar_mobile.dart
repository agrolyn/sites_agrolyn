import 'package:flutter/material.dart';

class ItemNavbarMobile extends StatelessWidget {
  final String name;
  final IconData iconName;
  final Function onClick;
  final bool? isActive;
  const ItemNavbarMobile(
      {super.key,
      required this.name,
      required this.iconName,
      required this.onClick,
      this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ?? false ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onClick(),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Icon(
                iconName,
                color:
                    isActive ?? false ? Colors.white : const Color(0xFF46b9a8),
              ),
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
      ),
    );
  }
}
