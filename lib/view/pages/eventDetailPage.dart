import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/eventmodel.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('dd MMM yyyy');
    final diff = event.eventDate.difference(DateTime.now());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HERO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 100),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F2A44), Color(0xFF4B145F)],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    event.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _count(diff.inDays, 'Days'),
                      _count(diff.inHours % 24, 'Hours'),
                      _count(diff.inMinutes % 60, 'Minutes'),
                    ],
                  ),
                ],
              ),
            ),

            // CONTENT
            Padding(
              padding: const EdgeInsets.all(60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      event.posterUrl,
                      width: 350,
                      height: 480,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.description),
                        const SizedBox(height: 30),

                        const Text(
                          'Event Detail',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        _info('Organization', event.organization),
                        _info('Open Register', df.format(event.openRegDate)),
                        _info('Close Register', df.format(event.closeRegDate)),
                        _info('Event Day', df.format(event.eventDate)),

                        const SizedBox(height: 30),
                        const Text(
                          'Benefits',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ...event.benefits.map((b) => Text('• $b')),

                        const SizedBox(height: 30),
                        const Text(
                          'Divisions',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Wrap(
                          spacing: 10,
                          children: event.divisions
                              .map((d) => Chip(label: Text(d)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _count(int v, String l) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Text('$v',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            Text(l, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      );

  static Widget _info(String t, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('$t : $v'),
      );
}



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../../viewmodel/eventDetailViewModel.dart';
// import '../widgets/pages.dart';

// class EventDetailPage extends StatelessWidget {
//   final String eventId;
//   const EventDetailPage({super.key, required this.eventId});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => EventDetailViewModel()..fetchEvent(eventId),
//       child: Consumer<EventDetailViewModel>(
//         builder: (context, vm, _) {
//           if (vm.isLoading || vm.event == null) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           final event = vm.event!;
//           final df = DateFormat('dd MMM yyyy');
//           final diff = vm.countdown;

//           return Scaffold(
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // ================= HERO =================
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 100),
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Color(0xFF0F2A44), Color(0xFF4B145F)],
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Text(
//                           event.name,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 40,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             _count(diff.inDays, 'Days'),
//                             _count(diff.inHours % 24, 'Hours'),
//                             _count(diff.inMinutes % 60, 'Minutes'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   // ================= DETAIL =================
//                   Padding(
//                     padding: const EdgeInsets.all(60),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Image.network(event.posterUrl, width: 350),
//                         ),
//                         const SizedBox(width: 60),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 event.name,
//                                 style: const TextStyle(
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//                               Text(event.description),
//                               const SizedBox(height: 30),

//                               const Text(
//                                 'Event Detail',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               _info('Organization', event.organization),
//                               _info('Open Register', df.format(event.openRegDate)),
//                               _info('Close Register', df.format(event.closeRegDate)),
//                               _info('Event Day', df.format(event.eventDate)),

//                               const SizedBox(height: 30),
//                               const Text(
//                                 'Event Benefit',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               ...event.benefits
//                                   .map((b) => Text('• $b')),

//                               const SizedBox(height: 30),
//                               const Text(
//                                 'Divisi Dibuka',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Wrap(
//                                 spacing: 10,
//                                 children: event.divisions
//                                     .map((d) => Chip(label: Text(d)))
//                                     .toList(),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),

//                   const FooterSection(),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   static Widget _count(int v, String l) =>
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           children: [
//             Text('$v',
//                 style: const TextStyle(
//                     color: Colors.white, fontSize: 32)),
//             Text(l,
//                 style: const TextStyle(color: Colors.white70)),
//           ],
//         ),
//       );

//   static Widget _info(String t, String v) =>
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4),
//         child: Text('$t : $v'),
//       );
// }
