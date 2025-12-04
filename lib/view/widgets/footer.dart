import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600; // Kembali ke 600px

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF2D1B4E), 
            Color(0xFF1E3A5F), 
            Color(0xFF1A4D5C), 
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 20 : 40,
        vertical: 30,
      ),
      child: Column(
        children: [
          isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTheEventSection(),
                    const SizedBox(height: 30),
                    _buildContactSection(),
                    const SizedBox(height: 30),
                    _buildSubscribeSection(),
                  ],
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final availableWidth = constraints.maxWidth;
                    final totalContentWidth = 250 + 280 + 280; 
                    final remainingSpace = availableWidth - totalContentWidth;
                    final spacing = (remainingSpace / 2).clamp(20.0, 450.0); 

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 250),
                            child: _buildTheEventSection(),
                          ),
                        ),

                        SizedBox(width: spacing),

                        Flexible(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 280),
                            child: _buildContactSection(),
                          ),
                        ),

                        SizedBox(width: spacing),

                        Flexible(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 280),
                            child: _buildSubscribeSection(),
                          ),
                        ),
                      ],
                    );
                  },
                ),

          const SizedBox(height: 30),

          Container(
            height: 1,
            color: Colors.white.withOpacity(0.2),
          ),

          const SizedBox(height: 20),

          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: isSmallScreen ? 0 : 0),
              child: Text(
                '© 2025 The Event. All rights reserved',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTheEventSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Event',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          children: [
            _buildSocialIcon(Icons.camera_alt), // Instagram
            _buildSocialIcon(Icons.facebook),
            _buildSocialIconCustom('X'), // Twitter/X
          ],
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactItem('theevent@gmail.com'),
        const SizedBox(height: 8),
        _buildContactItem('Universitas Ciputra Citraland'),
        const SizedBox(height: 8),
        _buildContactItem('081133111234577889Q'),
      ],
    );
  }

  Widget _buildSubscribeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subscribe',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your email to get notified\nabout newest event',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          constraints: BoxConstraints(maxWidth: 280),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(36),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.grey[700],
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Color(0xFF2D1B4E),
        size: 24,
      ),
    );
  }

  Widget _buildSocialIconCustom(String text) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF2D1B4E),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 14,
        height: 1.4,
      ),
    );
  }
}