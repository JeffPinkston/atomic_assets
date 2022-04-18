import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:atomic_assets/provider/videos_provider.dart';

class VideoList extends StatelessWidget {
  const VideoList();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: context.watch<VideosProvider>().videos.isNotEmpty
            ? ListView.builder(
                itemCount: context.watch<VideosProvider>().videos.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.read<VideosProvider>().updateSelectedData(index);
                      Navigator.pushNamed(context, '/video');
                    },
                    child: Card(
                      key: UniqueKey(),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(context
                              .watch<VideosProvider>()
                              .videos[index]
                              .data
                              .name)),
                    ),
                  );
                })
            : const CircularProgressIndicator(
                strokeWidth: 5,
              ));
  }
}
