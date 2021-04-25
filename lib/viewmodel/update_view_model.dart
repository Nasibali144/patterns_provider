import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:patterns_provider/model/post_model.dart';
import 'package:patterns_provider/services/http_service.dart';

class UpdateViewModel extends ChangeNotifier {
  bool isLoading = false;
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  Post oldPost;

  void getOldPost(Post post) {
    oldPost = post;
    titleController.text = oldPost.title;
    bodyController.text = oldPost.body;
    notifyListeners();
  }

  Future apiUpdatePost(BuildContext context) async{
    isLoading = true;
    notifyListeners();

    String title = titleController.text.trim().toString();
    String body = bodyController.text.trim().toString();
    Post post = Post(title: title, body: body, userId: oldPost.userId, id: oldPost.id);

    var response = await Network.PUT(Network.API_UPDATE + oldPost.id.toString(), Network.paramsUpdate(post));
    isLoading = false;
    if(response != null) {
      Navigator.pop(context, response);
    } else {
      Navigator.pop(context, null);
    }
    notifyListeners();
  }

}