import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'bouncing.dart';
import 'next_page.dart';
import 'view_model.dart';

class MyHomePage extends ConsumerWidget {
  Text membersText(List<String> members) {
    String membersString = "";
    for (String member in members) {
      membersString += ("$member, ");
    }
    return Text(
      membersString,
      style: TextStyle(color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _viewModel = ref.watch(viewModelProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text("班分け"),
          toolbarHeight: 44,
          actions: <Widget>[
            CupertinoButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: Icon(Icons.people),
              padding: EdgeInsets.fromLTRB(0, 4, 12, 0),
            ),
            // ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _viewModel.newPlaceNameController,
                onChanged: (value) => _viewModel.newPlaceName = value,
                decoration: InputDecoration(
                  suffixIcon: CupertinoButton(
                    onPressed: _viewModel.addPlace,
                    child: Icon(
                      FluentSystemIcons.ic_fluent_add_filled,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _viewModel.places.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: <Widget>[
                    ListTile(
                      title: Text(_viewModel.places[index].name),
                      //indexは0から始まり、繰り返される度に+1される変数
                      subtitle: membersText(_viewModel.places[index].members),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CupertinoButton(
                              onPressed: () {
                                _viewModel.decrementPlaceCapacity(index);
                              },
                              child: const Icon(
                                  Icons.remove_circle_outline)),
                          Text(_viewModel.places[index].capacity.toString()),
                          CupertinoButton(
                              onPressed: () {
                                _viewModel.incrementPlaceCapacity(index);
                              },
                              child: const Icon(
                                Icons .add_circle_outline)),
                          CupertinoButton(
                              onPressed: () {
                                _viewModel.removePlace(index);
                              },
                              child: const Icon(
                                  FluentSystemIcons.ic_fluent_delete_filled)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(),
                    ),
                  ]); //
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Bouncing(
          onPress: () {
            _viewModel.set();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)), // 調節
                child:
                    Container(width: 60, height: 60, color: Colors.cyan[100]),
              ),
              Icon(
                FluentSystemIcons.ic_fluent_arrow_clockwise_filled,
                size: 24,
                color: Colors.cyan[900],
              ),
            ],
          ),
        ));
  }
}
