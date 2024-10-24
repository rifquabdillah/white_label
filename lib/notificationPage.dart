import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: const Color(0xFFFDF7E6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black), // Custom back arrow icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      backgroundColor: const Color(0xffFDF7E6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            NotificationCard(
              message: 'Notifikasi 1: Anda memiliki 3 tugas baru.',
              isNew: true, // Mark as new
            ),
            SizedBox(height: 8),
            NotificationCard(
              message: 'Notifikasi 2: Anda telah mendapatkan voucher diskon.',
              isNew: false, // Mark as read
            ),
            SizedBox(height: 8),
            NotificationCard(
              message: 'Notifikasi 3: Anda telah mendapatkan voucher diskon.',
              isNew: false, // Mark as read
            ),
            SizedBox(height: 8),
            NotificationCard(
              message: 'Notifikasi 4: Dapatkan Hadiah Menarik.',
              isNew: false, // Mark as read
            ),
            SizedBox(height: 8),
            NotificationCard(
              message: 'Notifikasi 5: Anda telah mendapatkan voucher Promo.',
              isNew: false, // Mark as read
            ),
            // Add more notifications as needed
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final String message;
  final bool isNew;

  const NotificationCard({Key? key, required this.message, required this.isNew}) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  late bool _isNew;

  @override
  void initState() {
    super.initState();
    _isNew = widget.isNew; // Initialize read status
  }

  void _markAsRead() {
    setState(() {
      _isNew = false; // Mark as read
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _markAsRead, // Mark notification as read on tap
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF9F6),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            if (_isNew) ...[
              const Icon(Icons.circle_sharp, color: Colors.red, size: 10), // Red star icon for new notifications
              const SizedBox(width: 8), // Space between icon and text
            ],
            Expanded(
              child: Text(
                widget.message,
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
