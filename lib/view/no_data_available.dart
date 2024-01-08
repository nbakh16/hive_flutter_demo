import 'package:flutter/material.dart';

class NoDataAvailable extends StatelessWidget {
  const NoDataAvailable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_outlined,
            color: Colors.amber.shade400,
            size: 55,
          ),
          const SizedBox(height: 12),
          Text(
            'No data available!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
