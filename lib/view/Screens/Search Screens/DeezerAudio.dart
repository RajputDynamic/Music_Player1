import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:audioplayers/audioplayers.dart';

class DeezerMusicPage extends StatefulWidget {
  @override
  _DeezerMusicPageState createState() => _DeezerMusicPageState();
}

class _DeezerMusicPageState extends State<DeezerMusicPage> {
  List<dynamic> tracks = [];
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _player = AudioPlayer();
  bool isLoading = false;

  Future<void> _search(String query) async {
    setState(() => isLoading = true);
    try {
      final encodedQuery = Uri.encodeComponent(query);
      final url = Uri.parse('https://api.deezer.com/search?q=$encodedQuery');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['data'].isEmpty && data['next'] != null) {
          final nextUrl = Uri.parse(data['next']);
          final nextResponse = await http.get(nextUrl);
          if (nextResponse.statusCode == 200) {
            final nextData = json.decode(nextResponse.body);
            setState(() => tracks = nextData['data']);
          } else {
            setState(() => tracks = []);
          }
        } else {
          setState(() => tracks = data['data']);
        }
      } else {
        setState(() => tracks = []);
      }
    } catch (e) {
      print("Error fetching Deezer tracks: $e");
      setState(() => tracks = []);
    }
    setState(() => isLoading = false);
  }

  void _playPreview(String url) async {
    await _player.stop();
    await _player.play(UrlSource(url));
  }

  @override
  void dispose() {
    _player.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deezer Search')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: _search,
              decoration: InputDecoration(
                hintText: 'Search Deezer...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _search(_controller.text),
                ),
              ),
            ),
            SizedBox(height: 10),
            if (isLoading)
              CircularProgressIndicator()
            else if (tracks.isEmpty)
              Expanded(
                child: Center(
                  child: Text('No results found. Try another search.'),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    final track = tracks[index];
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: track['album']['cover_big'] ?? track['album']['cover'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(Icons.music_note),
                      ),
                      title: Text(track['title'] ?? 'Unknown Title'),
                      subtitle: Text(track['artist']?['name'] ?? 'Unknown Artist'),
                      trailing: IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () => _playPreview(track['preview']),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
