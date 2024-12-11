
import 'package:flutter/material.dart';
import 'package:project_flutter_football/constaints.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/dashboard_view_model/scaffold_dashbaord_vm.dart';
import 'package:provider/provider.dart';

import 'homeComponents/JoinedMatchComponent.dart';
import 'homeComponents/OwnMatchComponent.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {

    final user = context.watch<DashboardScaffoldViewModel>().user;
    return  DefaultTabController(
        length: 2,
        child:  Scaffold(
          appBar: AppBar(title: RichText(text: TextSpan(
            children: [
              TextSpan(text: user?.name.capitalize() ?? "", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary )),
              TextSpan(text:  "'s", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary )),
              TextSpan(text: "Board", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary )),
            ]
          ))),
          body:  Column(
          children: [
            Row(
              children: [
                Padding(padding: const EdgeInsets.only(left: 16, right: 16),
                  child:
                  Text("My Own matches", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold), textAlign: TextAlign.left, ),
                )
              ],
            ),
            const SizedBox(height: 16,),
            const TabBar(tabs: [
              Text("Own Matches"),
              Text("Jointed")
            ]),
            const Expanded(
               child: Padding(
                 padding: EdgeInsets.only(left: 16, right: 16),
                 child: TabBarView(children: [
                   OwnMatchComponent(),
                   JoinedMatchComponent()
                  ]),
               ),
              )
            ],
          ),
        )
    );
  }
}
