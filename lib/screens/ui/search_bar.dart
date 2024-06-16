import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../style/styled_body_text.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(String) onSubmitted;
  final VoidCallback onSelectDateRange;
  final String? error;

  const SearchBarWidget({
    required this.controller,
    required this.startDate,
    required this.endDate,
    required this.onSubmitted,
    required this.onSelectDateRange,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Choisir une ville",
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
            onSubmitted: onSubmitted,
          ),
          const SizedBox(height: 5.0),
          ElevatedButton(
            onPressed: onSelectDateRange,
            child: const Text("Choisir une date"),
          ),
          if (startDate != null && endDate != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: StyledBodyText(
                "Dates choisit: ${DateFormat('dd/MM/yyyy').format(startDate!)} - ${DateFormat('dd/MM/yyyy').format(endDate!)}",
                false,
                15.0,
              ),
            ),
          if (error != null)
            Text(
              error!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}