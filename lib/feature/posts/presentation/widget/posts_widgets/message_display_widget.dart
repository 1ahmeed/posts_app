import 'package:flutter/material.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;

  const MessageDisplayWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height ,
      child: ListView(
        children: [
          const SizedBox(height: 100,),
          Center(
            child: Text(
              message,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
