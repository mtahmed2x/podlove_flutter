import 'package:flutter/material.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';

class SelectInterests extends StatefulWidget {
  const SelectInterests({super.key});

  @override
  State<SelectInterests> createState() => _LikesAndInterestsPageState();
}

class _LikesAndInterestsPageState extends State<SelectInterests> {
  final List<String> interests = [
    "Photography",
    "Cooking",
    "Fitness",
    "Music",
    "Shopping",
    "Travelling",
    "Drinking",
    "Video Games",
    "Art & Crafts",
    "Swimming",
    "Extreme Sports",
    "Speeches",
  ];

  final Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          "Likes & Interests",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tell us what you enjoy",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Please select at least 3",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3.5,
                ),
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  final interest = interests[index];
                  final isSelected = selectedInterests.contains(interest);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedInterests.remove(interest);
                        } else {
                          selectedInterests.add(interest);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange[100] : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          interest,
                          style: TextStyle(
                            color: isSelected ? Colors.orange : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomRoundButton(
              text: "Continue",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FindingMatchesScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
