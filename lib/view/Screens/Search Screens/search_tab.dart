import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List songs = [];
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentUrl = "";

  void searchSongs(String query) async {
    final apiKey = "812219755c1344d858bf56af860f5b7d4f";
    final url = Uri.parse("http://ws.audioscrobbler.com/2.0/?method=track.search&track=${Uri.encodeComponent(query)}&api_key=$apiKey&format=json");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      setState(() {
        songs = data['results']['trackmatches']['track'];
      });
    }
  }

  Future<String?> getJioSaavnPreviewUrl(String songName) async {
    final url = Uri.parse("https://saavn.me/search/songs?query=${Uri.encodeComponent(songName)}");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final results = data['data']['results'];
      if (results != null && results.isNotEmpty) {
        return results[0]['preview'] ?? results[0]['media_preview_url'];
      }
    }
    return null;
  }

  void playPreview(String previewUrl) async {
    if (currentUrl == previewUrl && isPlaying) {
      await _audioPlayer.pause();
      setState(() => isPlaying = false);
    } else {
      await _audioPlayer.play(UrlSource(previewUrl));
      setState(() {
        currentUrl = previewUrl;
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Songs")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Enter song or artist",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => searchSongs(_controller.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                final imageUrl = (song['image'] != null && song['image'].length > 2) ? song['image'][2]['#text'] : "";
                final name = song['name'] ?? 'Unknown';
                final artist = song['artist'] ?? 'Unknown Artist';

                return FutureBuilder<String?>(
                  future: getJioSaavnPreviewUrl(name),
                  builder: (context, snapshot) {
                    final previewUrl = snapshot.data;
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: imageUrl.isNotEmpty
                            ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                            : Icon(Icons.music_note),
                        title: Text(name),
                        subtitle: Text(artist),
                        trailing: previewUrl != null
                            ? IconButton(
                          icon: Icon(currentUrl == previewUrl && isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed: () => playPreview(previewUrl),
                        )
                            : SizedBox.shrink(),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}


