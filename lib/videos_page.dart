import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  // use firestore to get these
  final List<Map<String, String>> videos = [
    {
      'title': 'Top 5 Sneaker Cleaning Tips Everyone Should Know!',
      'description': 'Learn the best way to clean your sneakers',
      'youtubeId': 'U9s5cYTCOvA',
    },
    {
      'title': 'Modern Sneakers Explained in 15 minutess',
      'description': 'explanation of modern sneakers!',
      'youtubeId': 'FFDYIGhiIk8',
    },
    {
      'title': 'The Full History Of Air Jordan Sneakers',
      'description': 'learn the history of the most iconic shoes ever!',
      'youtubeId': 'CsNTX6vVcLc',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Sneaker Care Videos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return _buildVideoCard(video);
          },
        ),
      ),
    );
  }

  Widget _buildVideoCard(Map<String, String> video) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          _playVideo(video['youtubeId']!);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  'https://img.youtube.com/vi/${video['youtubeId']}/maxresdefault.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[800],
                      child: Icon(Icons.error, color: Colors.white),
                    );
                  },
                ),
                Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: 50,
                ),
              ],
            ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _playVideo(String videoId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerPage(videoId: videoId),
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoId;

  const VideoPlayerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Video Player',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.yellow,
          progressColors: ProgressBarColors(
            playedColor: Colors.yellow,
            handleColor: Colors.yellow,
          ),
        ),
      ),
    );
  }
} 