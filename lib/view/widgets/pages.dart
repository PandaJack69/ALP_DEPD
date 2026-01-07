import 'package:alp_depd/view/pages/admin/admindashboard.dart';
import 'package:alp_depd/view/pages/admin/organizerdashboard.dart';
import 'package:alp_depd/view/pages/loginpage.dart';
import 'package:alp_depd/view/pages/user/eventpage.dart';
import 'package:alp_depd/view/pages/user/homepage.dart';
import 'package:alp_depd/view/pages/user/my_registrations_page.dart';
import 'package:alp_depd/view/pages/user/profilepage.dart';
import 'package:alp_depd/view/widgets/custom_dialogs.dart';
import 'package:alp_depd/view/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart'; // Import Provider

// Import Model & Provider Baru
import '../../model/custom_models.dart';
import '../../viewmodel/database_provider.dart';
// Diperlukan untuk Timer
import 'package:alp_depd/view/pages/user/eventDetailPage.dart';
import '../pages/admin/registrationpage.dart';

part 'home_header.dart';
part 'navbar.dart';
part 'event_header.dart';
part 'featured_events_section.dart';
part 'upComingEventCard.dart';
part 'recentsEventSection.dart';
part 'lastChanceEventSection.dart';
part 'all_events_section.dart';

