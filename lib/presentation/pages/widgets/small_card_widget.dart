import 'package:flutter/material.dart';

class SmallCardWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Icon? prefixIcon;
  const SmallCardWidget({
    super.key,
    this.title,
    this.subtitle,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.1,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: prefixIcon,
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                title.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                subtitle.toString(),
                overflow: TextOverflow.clip,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey[700]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
