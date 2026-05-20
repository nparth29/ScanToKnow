# ScanToKnow — Frontend

> Flutter mobile app for scanning packaged food products, extracting ingredient labels via OCR, and displaying CPHS health scores with smart alternative recommendations.

🏆 **2nd Place — Xzibit 2026** National Level BE Project Competition (KCCEMSR)
🎓 **Aavishkar 2025 Finals** — University of Mumbai Inter-Collegiate Research Convention

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Barcode Scanning | mobile_scanner |
| Camera / OCR | camera plugin + OCR pipeline (backend) |
| HTTP | http package |
| State | setState / local state |

---

## Features

- **Barcode Scanning** — scan any packaged food product barcode for instant health analysis
- **OCR Label Extraction** — photograph ingredient labels; backend extracts and resolves ingredients automatically
- **CPHS Health Score** — proprietary 0–100 health score with Nutri-Score, NOVA group, and ingredient risk breakdown
- **Alternative Recommendations** — category-aware healthier product suggestions
- **Search** — real-time product search powered by MongoDB Atlas Search autocomplete
- **Categories** — browse products by food category
- **Onboarding** — 3-screen intro flow for first-time users

---

## Project Structure

```
lib/
├── core/
│   ├── config/
│   │   └── app_config.dart       # Backend URL config
│   ├── network/
│   │   └── api_service.dart      # HTTP client
│   └── ui/
│       └── app_theme.dart        # Global theme
│
├── features/
│   ├── onboarding/               # Intro screens
│   ├── home/                     # Home page
│   ├── scan/                     # Barcode scanner
│   ├── ocr/                      # OCR scan + results
│   ├── search/                   # Product search
│   ├── products/                 # Product listings
│   ├── variants/                 # Product variant detail
│   └── categories/               # Category browser
│
└── main.dart
```

---

## Setup & Installation

### Prerequisites
- Flutter SDK (3.x+)
- Android Studio or VS Code with Flutter extension
- A running instance of the [ScanToKnow Backend](https://github.com/nparth29/ScanToKnow-Backend)

### Steps

```bash
# 1. Clone the repo
git clone https://github.com/nparth29/ScanToKnow.git
cd ScanToKnow

# 2. Install dependencies
flutter pub get

# 3. Configure backend URL
# Open lib/core/config/app_config.dart
# Replace YOUR_BACKEND_IP with your machine's local IP
# Example: http://192.168.1.100:4000
```

### app_config.dart

```dart
class AppConfig {
  static const String baseUrl = 'http://YOUR_BACKEND_IP:4000';
}
```

```bash
# 4. Run the app
flutter run
```

---

## Camera & OCR Notes

- Camera resolution set to `ResolutionPreset.high` for better OCR accuracy
- Auto-focus and auto-exposure enabled
- OCR viewfinder aspect ratio: `0.92 × 1.05` for optimal label capture
- Image bytes sent directly to backend OCR pipeline

---

## Related

- [ScanToKnow Backend](https://github.com/nparth29/ScanToKnow-Backend) — Node.js/Express API

---

## Team

- **Parth Mishra** 
- **Om Mujumdar** 
- **Prathamesh Rane** 
- **Kaustubh Suryavanshy**

---

## License

MIT License — see [LICENSE](./LICENSE) for details.

> ⚠️ The CPHS (Consumer Product Health Score) algorithm is patent-pending. The code is open source under MIT, but the algorithm methodology is protected intellectual property.
