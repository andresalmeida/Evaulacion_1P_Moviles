import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PaginaRecursos extends StatefulWidget {
  @override
  _PaginaRecursosState createState() => _PaginaRecursosState();
}

class _PaginaRecursosState extends State<PaginaRecursos> {
  late YoutubePlayerController _controller1;
  late YoutubePlayerController _controller2;
  late YoutubePlayerController _controller3;
  bool _isAnimationComplete = false;

  @override
  void initState() {
    super.initState();
    _controller1 = YoutubePlayerController(
      initialVideoId: 'vXwLqORIgFM', // Reemplaza con el ID del video 1
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    _controller2 = YoutubePlayerController(
      initialVideoId: 'nm9ynfE', // Reemplaza con el ID del video 2
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    _controller3 = YoutubePlayerController(
      initialVideoId: 'eC6-OOfx1tQ', // Reemplaza con el ID del video 3
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
          child: AnimatedSwitcher(
            duration: Duration(seconds: 2),
            child: _isAnimationComplete
                ? Text(
              'Recursos Adicionales',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              key: ValueKey('Title'),
            )
                : AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText(
                  'Recursos Adicionales',
                  textStyle: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
              totalRepeatCount: 1,
              onFinished: () {
                setState(() {
                  _isAnimationComplete = true;
                });
              },
              key: ValueKey('AnimatedTitle'),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue[100]!, Colors.lightBlue[300]!],
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 16.0),
            _buildVideoSection('Título del Video 1', _controller1),
            SizedBox(height: 16.0),
            _buildVideoSection('Título del Video 2', _controller2),
            SizedBox(height: 16.0),
            _buildVideoSection('Título del Video 3', _controller3),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoSection(String title, YoutubePlayerController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
