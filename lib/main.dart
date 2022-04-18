import 'dart:convert';

import 'package:atomic_assets/models/video_results/video_results.dart';
import 'package:atomic_assets/provider/videos_provider.dart';
import 'package:atomic_assets/views/video.dart';
import 'package:atomic_assets/views/video_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'models/video_results/video_results.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => VideosProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atomic Assets Podcast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const VideosHomePage(title: 'Atomic Assets Podcast'),
        '/video': (context) => Video()
      },
    );
  }
}

class VideosHomePage extends StatefulWidget {
  const VideosHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<VideosHomePage> createState() => _VideosHomePageState();
}

class _VideosHomePageState extends State<VideosHomePage> {
  late List videos = [];
  final String _endpoint =
      'https://wax.api.atomicassets.io/atomicassets/v1/assets?collection_name=yoshidrops&owner=';

  @override
  void initState() {
    super.initState();
    loadVideos().then((results) => {handleResults(results)});
  }

  void handleResults(VideoResults res) {
    context.read<VideosProvider>().updateVideos(res.resultData);
    setState(() {
      videos = res.resultData;
    });
  }

  Future<VideoResults> loadVideos() async {
    try {
      final results = await http.get(Uri.parse(_endpoint));
      if (results.statusCode == 200) {
        return VideoResults.fromJson(json.decode(results.body));
      } else {
        throw Exception("Error fetching videos");
      }
    } catch (error, stacktrace) {
      print("Exception occurred:  $error $stacktrace");
      throw Exception("Error occurred fetching videos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const VideoList());
  }
}
