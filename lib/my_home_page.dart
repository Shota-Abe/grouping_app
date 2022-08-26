import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dictionary/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'squishable_button.dart';
import 'next_page.dart';
import 'view_model.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(viewModelProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("班分け"),
          toolbarHeight: 44,
          actions: <Widget>[
            CupertinoButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              padding: const EdgeInsets.fromLTRB(0, 4, 12, 0),
              child: const Icon(Icons.people),
            ),
            // ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: viewModel.newPlaceNameController,
                onChanged: (value) => viewModel.newPlaceName = value,
                decoration: InputDecoration(
                  suffixIcon: CupertinoButton(
                    onPressed: viewModel.addPlace,
                    child: const Icon(
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
                itemCount: viewModel.places.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: <Widget>[
                    ListTile(
                      title: Text(viewModel.places[index].name),
                      subtitle: Helpers().membersText(viewModel.places[index].members),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CupertinoButton(
                              onPressed: () {
                                viewModel.decrementPlaceCapacity(index);
                              },
                              child: const Icon(Icons.remove_circle_outline)),
                          Text(viewModel.places[index].capacity.toString()),
                          CupertinoButton(
                              onPressed: () {
                                viewModel.incrementPlaceCapacity(index);
                              },
                              child: const Icon(Icons.add_circle_outline)),
                          CupertinoButton(
                              onPressed: () {
                                viewModel.removePlace(index);
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
        floatingActionButton: SquishableButton(
          onPress: () {
            viewModel.set();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)), // 調節
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
