import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../view/Screens/Search Screens/songsModel.dart';
class fetchSongs extends StatelessWidget {
  final String collection;
  const fetchSongs({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight*0.25,
      child: StreamBuilder(
        stream:  FirebaseFirestore.instance
            .collection(collection)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No songs found."));
          }
          final songs = snapshot.data!.docs
              .map((doc) => Song.fromFirestore(doc.data() as Map<String, dynamic>))
              .toList();
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return Container(
                width: screenWidth*0.35,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: song.imageUrl, width: screenWidth*0.5, fit: BoxFit.cover,
                        height: screenHeight*0.15,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth*0.03,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            song.artist,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth*0.02,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
