import 'package:flutter/material.dart';
import 'package:patterns_provider/model/post_model.dart';
import 'package:patterns_provider/viewmodel/update_view_model.dart';

class UpdatePage extends StatefulWidget {

  static final String id = "update_page";
  final Post post;

  UpdatePage({this.post});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  UpdateViewModel updateViewModel = UpdateViewModel();

  @override
  void initState() {
    super.initState();
    updateViewModel.getOldPost(widget.post);
  }

  @override
  void dispose() {
    super.dispose();
    updateViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update post'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: updateViewModel.titleController,
                  decoration: InputDecoration(
                    labelText: "Post Title",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(right: 15, left: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: updateViewModel.bodyController,
                  decoration: InputDecoration(
                    labelText: "Post Body",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(
                        right: 15, top: 15, bottom: 50, left: 15),
                  ),
                  maxLines: 7,
                ),
                SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextButton(
                    child: Text('Update Post', style: TextStyle(color: Colors.white, fontSize: 20),),
                    onPressed: () {
                      updateViewModel.apiUpdatePost(context);
                    },
                  ),
                ),
              ],
            ),
          ),

          updateViewModel.isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink(),
        ],
      ),
    );
  }
}
