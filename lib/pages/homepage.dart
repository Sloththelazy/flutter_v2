import 'package:flutter/material.dart';
import 'booking_page.dart';
import 'account_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0; // Track the current page index

  // List of pages for navigation
  final List<Widget> _pages = [
    HomePageContent(), // Home Page content
    BookingPage(),     // Booking Page content
    AccountPage(),     // Account Page content
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(179, 244, 209, 187),
      body: _pages[_currentIndex], // Display the selected page content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected page index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> with SingleTickerProviderStateMixin {
  final List<Map<String, String>> events = [
    {
      'image': '/Users/jeeevantsingh/Documents/event/lib/image/asset_event1.avif',
      'name': 'Meet and Greet',
      'description': 'Network with tech enthusiasts and learn about the latest trends.'
    },
    {
      'image': '/Users/jeeevantsingh/Documents/event/lib/image/asset_event2.webp',
      'name': 'Okland Roars',
      'description': 'Explore the mesmerizing artwork by renowned artists.'
    },
    {
      'image': '/Users/jeeevantsingh/Documents/event/lib/image/asset_event3.jpeg',
      'name': 'Party at Jacobs',
      'description': 'Join us for an unforgettable night of live music and fun.'
    },
    {
      'image': '/Users/jeeevantsingh/Documents/event/lib/image/asset_event1.avif',
      'name': 'Tech Meetup',
      'description': 'A place for developers to learn and collaborate.'
    },
    {
      'image': '/Users/jeeevantsingh/Documents/event/lib/image/asset_event2.webp',
      'name': 'Startup Launch',
      'description': 'Get insights into launching a successful startup.'
    },
    {
      'image': '/Users/jeeevantsingh/Documents/event/lib/image/asset_event3.jpeg',
      'name': 'Annual Gala',
      'description': 'An evening of networking, food, and entertainment.'
    },
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Slide in each card sequentially
    Future.delayed(Duration.zero, () {
      for (int i = 0; i < events.length; i++) {
        Future.delayed(Duration(milliseconds: 100 * i), () {
          _listKey.currentState?.insertItem(i);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      padding: const EdgeInsets.all(16),
      initialItemCount: 0, // Start with no items and animate them in
      itemBuilder: (context, index, animation) {
        final event = events[index];
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).chain(
              CurveTween(curve: Curves.easeInOut),
            ),
          ),
          child: EventCard(
            image: event['image']!,
            name: event['name']!,
            description: event['description']!,
          ),
        );
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;

  const EventCard({
    required this.image,
    required this.name,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Dark text
                  ),
                ),
                const SizedBox(height: 8),
                // Event Description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87, // Darker description text
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}