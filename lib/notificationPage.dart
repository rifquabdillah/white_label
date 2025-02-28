import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [
    {'message': 'Notifikasi 1: Anda memiliki 3 tugas baru.', 'isNew': true},
    {'message': 'Notifikasi 2: Anda telah mendapatkan voucher diskon.', 'isNew': false},
    {'message': 'Notifikasi 3: Anda telah mendapatkan hadiah menarik.', 'isNew': false},
    {'message': 'Notifikasi 4: Promo terbaru telah hadir!', 'isNew': false},
    {'message': 'Notifikasi 5: Dapatkan Cashback hingga 50%.', 'isNew': false},
  ];

  void _removeNotification(int index) {
    setState(() {
      notifications.removeAt(index); // Hapus notifikasi dari daftar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: const Color(0xFFFDF7E6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xffFDF7E6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(notifications[index]['message']),
              direction: DismissDirection.endToStart, // Geser ke kiri
              onDismissed: (direction) {
                _removeNotification(index);
              },
              background: Container(
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.delete, color: Colors.white, size: 30),
              ),
              child: NotificationCard(
                message: notifications[index]['message'],
                isNew: notifications[index]['isNew'],
              ),
            );
          },
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
    _isNew = widget.isNew;
  }

  void _markAsRead() {
    setState(() {
      _isNew = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _markAsRead,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF9F6),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            if (_isNew) ...[
              const Icon(Icons.circle, color: Colors.red, size: 10),
              const SizedBox(width: 8),
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
