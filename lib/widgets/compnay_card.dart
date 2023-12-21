import 'package:flutter/material.dart';

import '../functions/extract_initial.dart';

class CompanyCardWidget extends StatelessWidget {
  const CompanyCardWidget({
    super.key,
    required this.companyName,
    required this.subtitleText,
    required this.color,
  });

  final Color color;
  final String companyName;
  final String subtitleText;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 3,
      child: ListTile(
        horizontalTitleGap: 2.0,
        contentPadding: const EdgeInsets.only(
          left: 5,
          right: 20,
          top: 5,
          bottom: 5,
        ),
        leading: Container(
          width: 65,
          height: 65,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.40),
            border: Border.all(
              color: color.withOpacity(.60),
            ),
          ),
          child: Center(
            child: Text(
              extractInitials(companyName),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
        title: Text(
          companyName,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        subtitle: Text(
          subtitleText,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }
}
