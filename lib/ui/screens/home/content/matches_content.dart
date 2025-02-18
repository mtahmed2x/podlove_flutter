import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/providers/home_provider.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class MatchesContent extends ConsumerWidget {
  const MatchesContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Consumer(builder: (context, ref, child) {
        final homeData = ref.watch(homeProvider);
        return homeData.when(
          data: (data) {
            final userData = ref.watch(userProvider);
            final participants = data.podcast?.participants ?? [];

            return Scaffold(
              appBar: CustomAppBar(title: "Matches"),
              backgroundColor: const Color.fromARGB(255, 248, 248, 248),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: List.generate(
                          participants.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: GestureDetector(
                              onTap: () {
                                if (userData?.user.subscription.plan ==
                                    "Seeker: Connection Builder") {
                                  context.push(
                                    RouterPath.matchedProfile,
                                    extra: index,
                                  );
                                }
                              },
                              child: ImageTextCard(
                                imageUrl: data.podcast?.status != "Done"
                                    ? "assets/images/hidden-match.png"
                                    : "assets/images/revealed-match.png",
                                text: "Match-${index + 1}",
                                textBackgroundColor:
                                    data.podcast?.status != "Done"
                                        ? AppColors.accent
                                        : AppColors.background,
                                isNetworkImage: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) {
            print(error);
            print(stack.toString());
            return Center(child: Text("Error: ${error.toString()}"));
          },
        );
      }),
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
