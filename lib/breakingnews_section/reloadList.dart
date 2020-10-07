import 'package:flutter/material.dart';
import 'package:flutter_pagination/breakingnews_section/pokimonItem.dart';

import 'model_class.dart';
import 'notifire.dart';

class ReloadListView extends StatefulWidget {
  const ReloadListView({Key key}) : super(key: key);

  @override
  _ReloadListViewState createState() => _ReloadListViewState();
}

class _ReloadListViewState extends State<ReloadListView> {
  PokemonNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = PokemonNotifier();
    notifier.getMore();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Flutter Pagination"),),
      body: ValueListenableBuilder<List<Pokemon>>(
          valueListenable: notifier,
          builder: (BuildContext context, List<Pokemon> value, Widget child) {
            return value != null
                ? RefreshIndicator(
              onRefresh: () async {
                return await notifier.reload();
              },
              child: value.isEmpty
                  ? ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return const Center(child: Text('No Pokemon!'));
                  })
                  : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo is ScrollEndNotification &&
                      scrollInfo.metrics.extentAfter == 0) {
                    notifier.getMore();
                    return true;
                  }
                  return false;
                },
                child: ListView.separated(
                    separatorBuilder: (context, index) => Container(),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: value.length,
                    cacheExtent: 5,
                    itemBuilder: (BuildContext context, int index) {
                      print("length1: ${value.length}");
                      return PokemonItem(pokemon: value[index]);
                    }),
              ),
            )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
