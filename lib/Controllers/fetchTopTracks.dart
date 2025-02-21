// lib/services/
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Fetches top tracks of a given artist using the Last.fm API
Future<List<dynamic>> fetchTopTracks(String artist) async {
  const apiKey = "812219755c1344d858bf56af8f5b7d4f";
  final artistEncoded = Uri.encodeComponent(artist.trim());

  final url = Uri.parse(
      "http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=$artistEncoded&api_key=$apiKey&format=json"
  );

  final res = await http.get(url);

  if (res.statusCode == 200) {
    final data = json.decode(res.body);
    return data['toptracks']['track'] ?? [];
  } else {
    throw Exception("Failed to fetch tracks for $artist");
  }
}
