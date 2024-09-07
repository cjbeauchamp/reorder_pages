import 'package:flutter/material.dart';
import 'package:flutter_reoder_pages/pj_multi_photo_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PJMultiPhotoCard(
        allowReorder: true,
        images: [
          'https://placehold.co/600x400/png',
          'https://placehold.co/400/png',
          'https://placehold.co/300x400/png',
          'https://placehold.co/500/png',
          'https://placehold.co/200x500/png',
        ],
      ),
    );
  }
}
