import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/providers/home_provider.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class MatchesContent extends ConsumerWidget {
  const MatchesContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeProvider);

    return Scaffold(
      appBar: CustomAppBar(title: "Matches"),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Center(
                child: homeData.when(
              data: (data) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: ImageTextCard(
                        imageUrl: data.podcast!.status != "Done"
                            ? "assets/images/hidden-match.png"
                            : "assets/images/revealed-match.png",
                        text: "Match-1",
                        textBackgroundColor: data.podcast!.status != "Done"
                            ? AppColors.accent
                            : AppColors.background,
                        isNetworkImage: false,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ImageTextCard(
                      imageUrl: "assets/images/hidden-match.png",
                      text: "Match-2",
                      textBackgroundColor: AppColors.accent,
                      isNetworkImage: false,
                    ),
                    const SizedBox(height: 30),
                    ImageTextCard(
                      imageUrl: "assets/images/hidden-match.png",
                      text: "Match-3",
                      textBackgroundColor: AppColors.accent,
                      isNetworkImage: false,
                    ),
                  ],
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Failed to load home data: ${error.toString()}'),
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class ImageTextCard extends StatelessWidget {
  final String imageUrl;
  final String text;
  final Color textBackgroundColor;
  final bool isNetworkImage;

  const ImageTextCard({
    super.key,
    required this.imageUrl,
    required this.text,
    this.textBackgroundColor = Colors.orangeAccent,
    this.isNetworkImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: isNetworkImage
                ? NetworkImage(imageUrl) as ImageProvider
                : AssetImage(imageUrl),
            width: 335,
            height: 240,
            fit: BoxFit.cover,
          ),
          Container(
            width: 335,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: textBackgroundColor,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
