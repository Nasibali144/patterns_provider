import 'package:flutter/material.dart';
import 'package:patterns_provider/viewmodel/home_view_model.dart';
import 'package:patterns_provider/views/item_of_post.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Provider"),
        ),
        body: ChangeNotifierProvider(
          create: (context) => viewModel,
          child: Consumer<HomeViewModel>(
            builder: (context, model, widget) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: viewModel.items.length,
                    itemBuilder: (context, index) {
                      return itemOfPost(context, viewModel, viewModel.items[index]);
                    },
                  ),
                  viewModel.isLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            viewModel.apiCreatePost(context);
          },
          child: Icon(Icons.add),
        ));
  }
}
