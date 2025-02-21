class Song {
  final String title;
  final String artist;
  final String imageUrl;

  Song({required this.title, required this.artist, required this.imageUrl});

  // Convert Firestore data to Song object
  factory Song.fromFirestore(Map<String, dynamic> firestoreData) {
    return Song(
      title: firestoreData['title']?? "",
      artist: firestoreData['artist']?? "",
      imageUrl: firestoreData['imageUrl']?? "",
    );
  }
}