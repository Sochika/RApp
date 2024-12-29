import 'package:radius/provider/profileprovider.dart';
import 'package:radius/widget/profile/basicdetail.dart';
import 'package:radius/widget/profile/bankdetail.dart';
import 'package:radius/widget/profile/companydetail.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:radius/widget/profile/heading.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  var initalState = true;

  @override
  void didChangeDependencies() {
    if (initalState) {
      getProfileDetail();
      initalState = false;
    }
    super.didChangeDependencies();
  }

  var isLoading = true;

  Future<String> getProfileDetail() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<ProfileProvider>(context, listen: false).getProfile();
    } catch (e) {
      return "loaded";
    }

    setState(() {
      isLoading = false;
    });
    return "loaded";
  }

  @override
  Widget build(BuildContext context) {
    final userProfile =
        Provider.of<ProfileProvider>(context, listen: false).profile;
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(translate('profile_screen.profile')),
        ),
        resizeToAvoidBottomInset: true,
        body: RefreshIndicator(
          onRefresh: () {
            return getProfileDetail();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const Heading(),
                userProfile.post != ''
                    ? Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 10),
                        width: double.infinity,
                        child: Text(
                          translate('profile_screen.basic_details'),
                          style: const TextStyle(color: Colors.white38, fontSize: 15),
                        ),
                      )
                    : const SizedBox(),
                userProfile.post != '' ? const BasicDetail() : const SizedBox(),
                userProfile.post != ''
                    ? Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 20, bottom: 10),
                  width: double.infinity,
                  child: Text(
                    translate('profile_screen.company_details'),
                    style: const TextStyle(color: Colors.white38, fontSize: 15),
                  ),
                )
                    : const SizedBox(),
                userProfile.post != '' ? const CompanyDetail() : const SizedBox(),
                userProfile.bankName != ''
                    ? Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 10),
                        width: double.infinity,
                        child: Text(
                          translate('profile_screen.bank_details'),
                          style: const TextStyle(color: Colors.white38, fontSize: 15),
                        ),
                      )
                    : const SizedBox(),
                userProfile.bankName != '' ? const BankDetail() : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
