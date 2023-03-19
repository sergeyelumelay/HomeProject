import 'dart:io';

import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final Function()? onTap;

  const CreateButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(color: const Color.fromARGB(255, 253, 245, 169),
        borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Create New Account",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
        ),
        ),
      ),
    );
  }
}