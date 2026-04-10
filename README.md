# 🛡️ DevSec Scanner

> **The Ultimate All-in-One Developer Security Scanner** built with Flutter to ensure enterprise-grade security across web endpoints, mobile applications, and native desktop binaries. 

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![Riverpod](https://img.shields.io/badge/Riverpod-State_Management-blue?style=for-the-badge) ![Open Source](https://img.shields.io/badge/Open%20Source-❤️-green?style=for-the-badge) ![License](https://img.shields.io/badge/License-MIT-purple?style=for-the-badge)

---

## ✨ Features

- **🌐 Deep API Vulnerability Scanner**
  Actively monitors target URLs mapping typical web configurations, probing for missing HSTS headers, X-Frame-Options, Exposed Server stacks, and CSP inadequacies.

- **📦 Binary App Static Analyzer**
  Direct drag-and-drop support for `.apk`, `.exe`, or `.ipa` analysis. Extracts insecure compiler flags, validates Authenticode / APK signatures, and audits app execution settings (like ASLR, DEP).

- **🧑‍💻 Integrated Developer Feedback Portal**
  Submit instantaneous UI/UX or feature bugs mapped across dynamically loaded project sections directly back to the infrastructure engineers.

## 🏗️ Architecture

Engineered meticulously utilizing a **Clean Architecture (MVC-inspired)** standard separating all distinct concerns:
- **`lib/views/`**: Robust declarative UIs rendering fluid 60FPS animations.
- **`lib/services/`**: Simulated API connectivity layers wrapping discrete analysis modules.
- **`lib/controllers/`**: Isolated deterministic State handling bridged via lightweight **Riverpod Providers**.

## 📸 Screenshots

| Dashboard Home | App Analyzer Module | API Threat Scanner |
|:---:|:---:|:---:|
| ![Dashboard](assets/screenshots/dashboard.png) | ![App Analyzer](assets/screenshots/app_analyzer.png) | ![API Scanner](assets/screenshots/api_scanner.png) |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.24)
- Android Studio / Xcode / VS Build Tools depending on target Platform.

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/dev_sec_scanner.git
   cd dev_sec_scanner
   ```

2. **Fetch all required dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the local debug build**
   ```bash
   flutter run
   ```

## 🤝 Contributing

We actively welcome contributions spanning entirely new binary analyzers, deep UI structural optimizations, and security engine patches! 
Please review our contributing flow:
1. `Fork` the overarching repository.
2. Branch specifically describing your feature (`git checkout -b feature/AmazingRefactor`).
3. Push localized commits (`git push origin feature/AmazingRefactor`).
4. Generate a generalized Pull Request targeting the primary `main`/`master` layer.

---

<p align="center"><i>Made with strictly uncompromising premium code standards.</i></p>
