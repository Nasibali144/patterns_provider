import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:patterns_provider/model/post_model.dart';
import 'package:patterns_provider/pages/create_page.dart';
import 'package:patterns_provider/pages/update_page.dart';
import 'package:patterns_provider/services/http_service.dart';

class HomeViewModel extends ChangeNotifier{
  bool isLoading = false;
  List<Post> items = [];

  Future apiPostList() async {
    isLoading = true;
    notifyListeners();

    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostList(response);
    } else {
      items = [];
    }
    isLoading = false;
    notifyListeners();
  }


  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();

    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    isLoading = false;
    notifyListeners();

    return response != null;
  }

  Future<void> apiUpdatePost(BuildContext context, Post post) async{
    String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatePage(post: post,)));
    if(result != null) {
      Post newPost = Network.parsePost(result);
      items[items.indexWhere((element) => element.id == newPost.id)] = newPost;
    }
    notifyListeners();
  }

  Future<void> apiCreatePost(BuildContext context) async{
    String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatePage()));
    if(result != null) items.add(Network.parsePost(result));
    notifyListeners();
  }

}