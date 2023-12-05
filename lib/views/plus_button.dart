import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget{
  const PlusButton({
    super.key,
    this.function
  });

  final function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            '+',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }

}