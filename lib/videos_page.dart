import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'widgets.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final List<Map<String, String>> videos = [
    {
      'title': 'How to Clean Your Sneakers',
      'description': 'Learn the proper way to clean and maintain your sneakers',
      'videoUrl': 'https://example.com/videos/clean-sneakers.mp4',
      'thumbnail': 'https://example.com/thumbnails/clean-sneakers.jpg',
    },
    {
      'title': 'Sneaker Storage Tips',
      'description': 'Best practices for storing your sneaker collection',
      'videoUrl': 'https://example.com/videos/storage-tips.mp4',
      'thumbnail': 'https://example.com/thumbnails/storage-tips.jpg',
    },
    {
      'title': 'Sneaker Authentication Guide',
      'description': 'How to spot fake sneakers and verify authenticity',
      'videoUrl': 'https://example.com/videos/authentication.mp4',
      'thumbnail': 'https://example.com/thumbnails/authentication.jpg',
    },
  ];

  VideoPlayerController? _controller;
  bool _isPlaying = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _initializeVideo(String videoUrl) {
    _controller?.dispose();
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  Widget _buildVideoCard(Map<String, String> video) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Player
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _controller?.value.isInitialized ?? false
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller!),
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPlaying = !_isPlaying;
                            _isPlaying ? _controller?.play() : _controller?.pause();
                          });
                        },
                      ),
                    ],
                  )
                : Image.network(
                    video['thumbnail']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: Icon(Icons.image_not_supported, color: Colors.white),
                      );
                    },
                  ),
          ),
          // Video Info
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video['title']!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  video['description']!,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _initializeVideo(video['videoUrl']!),
                  child: Text('Play Video'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sneaker Care Videos'),
        backgroundColor: Colors.grey[900],
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return _buildVideoCard(videos[index]);
        },
      ),
    );
  }
} 