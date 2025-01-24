import 'package:flutter/material.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text.dart';

class SelectPersonalityTraits extends StatelessWidget {
  const SelectPersonalityTraits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Personality Traits"),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        "assets/images/podLove.png",
                        width: 250,
                        height: 50,
                      ),
                      const SizedBox(height: 25),
                      CustomText(
                        text: "Rate yourself on the",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: "following personality traits",
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(height: 20),
                      _CustomScale(
                        leftLabel: "Introvert",
                        rightLabel: "Extrovert",
                        pillColors: [
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                          Colors.green,
                          Colors.blue,
                          Colors.indigo,
                          Colors.purple,
                        ],
                      ),
                      SizedBox(height: 20),
                      _CustomScale(
                        leftLabel: "Homebody",
                        rightLabel: "Adventurous",
                        pillColors: [
                          Colors.brown,
                          Colors.teal,
                          Colors.amber,
                          Colors.cyan,
                          Colors.lime,
                          Colors.pink,
                          Colors.grey,
                        ],
                      ),
                      SizedBox(height: 20),
                      _CustomScale(
                        leftLabel: "Pragmatist",
                        rightLabel: "Optimist",
                        pillColors: [
                          Colors.deepPurple,
                          Colors.lightBlue,
                          Colors.lightGreen,
                          Colors.orangeAccent,
                          Colors.redAccent,
                          Colors.yellowAccent,
                          Colors.deepOrange,
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                CustomRoundButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LikesAndInterestsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomScale extends StatefulWidget {
  final String leftLabel;
  final String rightLabel;
  final List<Color> pillColors;

  const _CustomScale({
    required this.leftLabel,
    required this.rightLabel,
    required this.pillColors,
  });

  @override
  State<_CustomScale> createState() => _CustomScaleState();
}

class _CustomScaleState extends State<_CustomScale> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top labels (left and right)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.leftLabel,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              widget.rightLabel,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Pills row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = isSelected ? null : index;
                  print(_selectedIndex);
                });
              },
              child: Container(
                width: 40,
                height: 15,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: widget.pillColors[index],
                  border: Border.all(
                    color: isSelected ? Colors.black : widget.pillColors[index],
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
