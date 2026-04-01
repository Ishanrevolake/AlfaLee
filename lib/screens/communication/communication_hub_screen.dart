import 'package:flutter/material.dart';

class CommunicationHubScreen extends StatelessWidget {
  const CommunicationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Broadcast', style: TextStyle(color: Color(0xFFDC143C))),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildChatTile(index);
        },
      ),
    );
  }

  Widget _buildChatTile(int index) {
    final names = ['John Doe', 'Jane Smith', 'Mike Ross', 'Sarah Connor', 'Harvey Specter'];
    final messages = [
      'Hey, my knee is feeling a bit tight today...',
      'Check out my PR on deadlifts today! 🚀',
      'The new meal plan is great, which protein powder...',
      'Can we reschedule tomorrow session?',
      'Thanks for the feedback on my form.'
    ];

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(names[index % names.length][0], style: const TextStyle(color: Color(0xFFDC143C))),
      ),
      title: Text(names[index % names.length], style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(messages[index % messages.length], 
        maxLines: 1, 
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black54, fontSize: 13),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('12:45', style: TextStyle(color: Colors.black38, fontSize: 10)),
          if (index == 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFFDC143C), borderRadius: BorderRadius.circular(10)),
              child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
      onTap: () {},
    );
  }
}
