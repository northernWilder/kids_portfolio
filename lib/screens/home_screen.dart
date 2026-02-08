import 'package:flutter/material.dart';
import '../widgets/artist_card.dart';
import 'artist_portfolio_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creative Artists Portfolio'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade50,
              Colors.pink.shade50,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Our Creative World!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Explore the amazing creative work of two talented young artists',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Responsive layout
                      if (constraints.maxWidth > 800) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: ArtistCard(
                                name: 'Joanna Ooms',
                                description: 'Stories, Art & Writing',
                                color: Colors.purple,
                                onTap: () => _navigateToPortfolio(context, 'Joanna Ooms'),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Flexible(
                              child: ArtistCard(
                                name: 'Eleanor Ooms',
                                description: 'Stories, Art & Writing',
                                color: Colors.pink,
                                onTap: () => _navigateToPortfolio(context, 'Eleanor Ooms'),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: ArtistCard(
                                name: 'Joanna Ooms',
                                description: 'Stories, Art & Writing',
                                color: Colors.purple,
                                onTap: () => _navigateToPortfolio(context, 'Joanna Ooms'),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Flexible(
                              child: ArtistCard(
                                name: 'Eleanor Ooms',
                                description: 'Stories, Art & Writing',
                                color: Colors.pink,
                                onTap: () => _navigateToPortfolio(context, 'Eleanor Ooms'),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPortfolio(BuildContext context, String artistName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArtistPortfolioScreen(artistName: artistName),
      ),
    );
  }
}
