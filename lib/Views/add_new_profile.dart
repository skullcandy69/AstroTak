import 'package:flutter/material.dart';

class AddNewProfile extends StatefulWidget {
  const AddNewProfile({Key? key}) : super(key: key);

  @override
  State<AddNewProfile> createState() => _AddNewProfileState();
}

class _AddNewProfileState extends State<AddNewProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
            const Text("Add New Profile")
          ],
        )
      ],
    );
  }
}
