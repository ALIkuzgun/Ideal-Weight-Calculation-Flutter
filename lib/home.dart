import 'package:flutter/material.dart';
import 'package:ideal_weight/color_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  List<ColorModel> colorstatus = [];

  int? weight;
  int? height;
  double? idealWeight;
  double? bmi;
  Color? ideal_bmi_color;
  String? your_weight_status;

  void _getcolorstatus() {
    colorstatus = ColorModel.getColorStatus();
  }

  void _calculate() {
    int? w = int.tryParse(_weightController.text);
    int? h = int.tryParse(_heightController.text);
    String g = _genderController.text.trim().toLowerCase();

    if (w == null || h == null || h == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen geçerli bir sayı girin")),
      );
      return;
    }

    setState(() {
      weight = w;
      height = h;

      if (g == "male") {
        idealWeight = 50 + 2.3 * ((h / 2.54) - 60);
      } else if (g == "female") {
        idealWeight = 45.5 + 2.3 * ((h / 2.54) - 60);
      } else {
        idealWeight = null;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Lütfen cinsiyetinizi 'male' ya da 'female' olarak girin.",
            ),
          ),
        );
        return;
      }

      double heightInMeters = h / 100;
      bmi = w / (heightInMeters * heightInMeters);

      if (bmi != null) {
        if (bmi! < 18.5) {
          ideal_bmi_color = const Color.fromARGB(255, 112, 215, 186);
          your_weight_status = "Weak";
        }
        if (bmi! >= 18.5 && bmi! < 24.9) {
          ideal_bmi_color = const Color.fromARGB(210, 125, 239, 43);
          your_weight_status = "Healthy";
        }
        if (bmi! >= 24.9 && bmi! < 29.9) {
          ideal_bmi_color = const Color.fromARGB(255, 255, 236, 64);
          your_weight_status = "Fat";
        }
        if (bmi! >= 29.9 && bmi! < 39.9) {
          ideal_bmi_color = const Color.fromARGB(255, 255, 153, 64);
          your_weight_status = "Obese";
        }
        if (bmi! >= 39.9) {
          ideal_bmi_color = const Color.fromARGB(255, 255, 86, 64);
          your_weight_status = "Morbidly Obese";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _getcolorstatus();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 238, 229),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 238, 229),
        centerTitle: true,
        title: const Text(
          "Ideal Weight Calculation",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 44),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 4,
              ),
              child: TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your weight (kg)',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 4,
              ),
              child: TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your height (cm)',
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 4,
              ),
              child: TextField(
                controller: _genderController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your gender (male/female)',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 4,
              ),
              child: ElevatedButton(
                onPressed: _calculate,
                child: const Text("Calculate"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 200, 205, 209),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 4,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ideal_bmi_color,
                ),
                child: Column(
                  children: [
                    if (idealWeight != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 4,
                        ),
                        child: Text(
                          "Your ideal weight: ${idealWeight!.toStringAsFixed(2)} kg",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (idealWeight == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 4,
                        ),
                        child: Text(
                          "Your ideal weight: not entered",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (bmi != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 4,
                        ),
                        child: Text(
                          "Your BMI: ${bmi!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (bmi == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 4,
                        ),
                        child: Text(
                          "Your BMI: not entered",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 4,
                      ),
                      child: Text(
                        "Weight Status: ${your_weight_status}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 4,
              ),
              child: SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: 80,
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: colorstatus[index].color,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                colorstatus[index].statusWeight,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 25),
                  itemCount: colorstatus.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
