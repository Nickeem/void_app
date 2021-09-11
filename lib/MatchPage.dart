import 'constraints.dart';
import 'package:flutter/material.dart';
import 'package:void_app/MatchViewer.dart';
import 'package:void_app/MatchMisc.dart';
import 'package:flutter/services.dart';


class MatchPage extends StatelessWidget {
  const MatchPage(this.match, {Key? key}) : super(key: key);

  final Match match;


  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(

            child: Column(
              children: [
                MatchViewer(match),
                MatchViewer(match, DB: true,),
                Padding(
                    padding: kAllSectionPadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: MatchTitle(match, type: MatchStyle.page,)),
                        const SizedBox(width: kPadding),
                      ],

                    )
                ),
                //LinkButtons(test_map)
              ],
            ),
          ),
        )
    );
  }
}