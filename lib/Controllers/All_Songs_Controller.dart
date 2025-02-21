import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllSongsController extends GetxController {
  var allList = [].obs;

  Future<void> fetchSongs() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('All Songs')
          .get();
      final data = snapshot.docs.map((doc) => doc.data()).toList();
      allList.assignAll(data);
    } catch (e) {
      print("🔥 Error fetching songs: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchSongs(); // Auto-fetch when controller is initialized
  }
}
