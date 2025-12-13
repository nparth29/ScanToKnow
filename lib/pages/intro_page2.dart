// import 'package:flutter/material.dart';
// import 'intro_page3.dart';
//
// class IntroPage2 extends StatelessWidget {
//   const IntroPage2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange[100],
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               const Spacer(),
//
//               Image.asset(
//                 'images/intro_page_images/intro_page2.png',
//                 height: 250,
//               ),
//               const SizedBox(height: 40),
//
//               const Text(
//                 "Know What You Eat",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepOrange,
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               const Text(
//                 "Scan ingredients or barcodes to discover how healthy your food really is.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18, color: Colors.black87),
//               ),
//
//               const Spacer(),
//
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.deepOrangeAccent,
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const IntroPage3()),
//                   );
//                 },
//                 child: const Text(
//                   "Next",
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _inactiveDot(),
//                   const SizedBox(width: 8),
//                   _activeDot(Colors.deepOrangeAccent),
//                   const SizedBox(width: 8),
//                   _inactiveDot(),
//                 ],
//               ),
//
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _activeDot(Color color) => Container(
//     width: 12,
//     height: 12,
//     decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//   );
//
//   Widget _inactiveDot() => Container(
//     width: 12,
//     height: 12,
//     decoration: BoxDecoration(color: Colors.grey[400], shape: BoxShape.circle),
//   );
// }


import 'package:flutter/material.dart';
import 'intro_page3.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SafeArea(
        child: SingleChildScrollView(       // ✅ FIXED
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                const SizedBox(height: 40),

                Image.asset(
                  'images/intro_page_images/intro_page2.png',
                  height: 250,
                ),

                const SizedBox(height: 40),

                const Text(
                  "Know What You Eat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Scan ingredients or barcodes to discover how healthy your food really is.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),

                const SizedBox(height: 50),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const IntroPage3()),
                    );
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _inactiveDot(),
                    const SizedBox(width: 8),
                    _activeDot(Colors.deepOrangeAccent),
                    const SizedBox(width: 8),
                    _inactiveDot(),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _activeDot(Color color) => Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  Widget _inactiveDot() => Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(color: Colors.grey[400], shape: BoxShape.circle),
  );
}
