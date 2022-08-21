import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter_dictionary/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'squishable_button.dart';

class NextPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _viewModel = ref.watch(viewModelProvider);

    return Scaffold(
        appBar: AppBar(
            title: Text('生徒一覧'),
            toolbarHeight: 44,
            automaticallyImplyLeading: false,
            leading: CupertinoNavigationBarBackButton()),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _viewModel.newMemberController,
                onChanged: (value) => _viewModel.newMember = value,
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _viewModel.members.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: <Widget>[
                    ListTile(
                      //indexは0から始まり、繰り返される度に+1される変数
                      title: Text(_viewModel.members[index]),
                      trailing: CupertinoButton(
                          onPressed: () {
                            _viewModel.removeMember(index);
                          },
                          child: const Icon(
                              FluentSystemIcons.ic_fluent_delete_filled)),
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
          onPress: _viewModel.addMember,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)), // 調節
                child:
                    Container(width: 60, height: 60, color: Colors.cyan[100]),
              ),
              Icon(
                FluentSystemIcons.ic_fluent_add_filled,
                size: 24,
                color: Colors.cyan[900],
              ),
            ],
          ),
        ));
  }
}
