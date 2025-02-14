import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:radius/data/source/network/model/projectdashboard/OnDuties.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/source/datastore/preferences.dart';
import '../../data/source/network/model/projectdashboard/Operatives.dart';
import '../../utils/TagWidget.dart';
import '../../utils/constant.dart';
import '../../widget/radialDecoration.dart';

class DetailScreen extends StatefulWidget {
  final int item;
  final String beatName;
  const DetailScreen({super.key, required this.item, required this.beatName});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<OperativesDashboardResponse>? _projectFuture;

  @override
  void initState() {
    super.initState();
    _fetchProjectData(); // Use a separate method to initialize
  }

  void _fetchProjectData() {
    setState(() {
      _projectFuture = getProjectOverview(widget.item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.beatName),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_projectFuture == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<OperativesDashboardResponse>(
      future: _projectFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.data.operatives.isEmpty) {
          return const Center(child: Text('No operatives found'));
        }

        final data = snapshot.data!.data;
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              _fetchProjectData(); // Refreshes the Future
            },
            child: ListView.builder(
              itemCount: data.operatives.length,
              itemBuilder: (context, index) {
                final operative = data.operatives[index];
                final onDuties = data.onDuties;
                return _buildOperativeItem(operative, onDuties);
              },
            ),
          ),
        );
      },
    );
  }
}

// Keep rest of the code unchanged

Widget _buildOperativeItem(OperativeShift shift, Map<int, int> onDuties) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (shift.operative.avatar.isNotEmpty)
                  CircleAvatar(
                    backgroundImage: NetworkImage('${Constant.IMAGE_URL}${shift.operative.avatar}'),
                  ),
                if (shift.operative.avatar.isEmpty)
                  CircleAvatar(
                    backgroundImage: shift.operative.gender == 'male' ? const NetworkImage(Constant.MALE_IMAGE_URL) : const NetworkImage(Constant.FEMALE_IMAGE_URL),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '${shift.operative.firstName} ${shift.operative.lastName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildContactRow('Contact:', shift.operative.phoneNumber),
            // _buildInfoRow('Gender:', shift.operative.gender),
            _buildInfoRow(
                'Shift :', '${shift.shiftType.name} : ${shift.shiftStart} - ${shift.shiftEnd}'),
           if(onDuties[shift.operative.id] == shift.beatBranchId)
             const TagWidget(
                 label: "Active"?? '',
                 backgroundColor: Colors.blueGrey,
                 textColor: Colors.green),

            // if (shift.comment != null)
            //   _buildInfoRow('Comments:', shift.comment!),
          ],
        ),
      ),
    ),
  );
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ],
    ),
  );
}


Widget _buildContactRow(String label, String phoneNumbers) {
  final numbers = phoneNumbers.split(',').map((e) => e.trim()).toList();

  return Row(
    children: [
      // Text('$label ',
      //   style: const TextStyle(
      //     color: Colors.white70,
      //     fontWeight: FontWeight.w500,
      //   ),),
      const Icon(Icons.phone, size: 20, color: Colors.blue),
      const SizedBox(width: 8),
      Wrap(
        spacing: 8,
        children: numbers.map((number) => InkWell(
          onTap: () => _launchPhone(number),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.none,
            ),
          ),
        )).toList(),
      ),
    ],
  );
}

Future<void> _launchPhone(String phoneNumber) async {
  final Uri url = Uri.parse('tel:$phoneNumber');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
Future<OperativesDashboardResponse> getProjectOverview(int id) async {
  final preferences = Preferences();
  try {
    final uri = Uri.parse(
      "${await preferences.getAppUrl()}${Constant.BEAT_DETAILS_URL}?id=$id",
    );

    final token = await preferences.getToken();
    final headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return OperativesDashboardResponse.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception(
        'Failed to load data: ${response.statusCode} - ${response.body}',
      );
    }
  } catch (e) {
    throw Exception('Network error: ${e.toString()}');
  }
}
