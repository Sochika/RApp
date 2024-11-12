import 'package:radius/provider/companyrulesprovider.dart';
import 'package:radius/widget/companyrulesscreen/rulescardview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RulesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rulesList = Provider.of<CompanyRulesProvider>(context).contentList;
    return ListView.builder(
        itemCount: rulesList.length,
        itemBuilder: (ctx, i) {
          return RulesCardView(rulesList[i].title, rulesList[i].description);
        });
  }
}
