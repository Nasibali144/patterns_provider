import 'package:flutter/material.dart';
import 'package:patterns_provider/viewmodel/create_view_model.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {

  static final String id = "create_page";

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new post'),
      ),
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (context) => CreateViewModel(),
        child: Consumer<CreateViewModel>(
          builder: (context, createViewModel, child) => Stack(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: createViewModel.titleController,
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
                      controller: createViewModel.bodyController,
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
                        child: Text('Create Post', style: TextStyle(color: Colors.white, fontSize: 20),),
                        onPressed: () {
                          createViewModel.apiCreatePost(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              createViewModel.isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
