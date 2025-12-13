// import 'package:flutter/material.dart';
// import 'intro_page2.dart';
//
// class IntroPage1 extends StatelessWidget {
//   const IntroPage1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.yellow[100],
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               const Spacer(),
//
//               Icon(
//                 Icons.camera_alt_outlined,
//                 size: 100,
//                 color: Colors.orange,
//               ),
//               const SizedBox(height: 40),
//
//               const Text(
//                 "Welcome to Scan to Know!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.orangeAccent,
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               const Text(
//                 "Scan any food product's barcode or ingredients and instantly know its health rating.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.black87,
//                 ),
//               ),
//
//               const Spacer(),
//
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orangeAccent,
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const IntroPage2()),
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
//                   _activeDot(Colors.orangeAccent),
//                   const SizedBox(width: 8),
//                   _inactiveDot(),
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
import 'intro_page2.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SafeArea(
        child: SingleChildScrollView(   // ✅ FIX: Makes entire page scrollable if needed
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(height: 40),

                Icon(
                  Icons.camera_alt_outlined,
                  size: 100,
                  color: Colors.orange,
                ),

                const SizedBox(height: 40),

                const Text(
                  "Welcome to Scan to Know!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Scan any food product's barcode or ingredients and instantly know its health rating.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 50),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
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
                      MaterialPageRoute(builder: (context) => const IntroPage2()),
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
                    _activeDot(Colors.orangeAccent),
                    const SizedBox(width: 8),
                    _inactiveDot(),
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
