# تطبيق/موقع إسلامي احترافي (SwiftUI + MVVM)

هذا المشروع هو **Starter Architecture** لتطبيق إسلامي احترافي يدعم العربية (RTL) ويغطي المتطلبات التي طلبتها:
- مواقيت الصلاة حسب الموقع.
- آية يومية + حديث يومي.
- قسم القرآن (عرض/بحث/تلاوة).
- قسم الأذكار + سبحة إلكترونية.
- اتجاه القبلة.
- إشعارات الصلاة.
- الوضع الليلي.
- تصميم متجاوب.

---

## 1) مخطط هيكل المشروع (Project Structure)

```text
IslamicAppStarter/
├── App/
│   ├── IslamicApp.swift
│   └── MainTabView.swift
├── Core/
│   ├── Models/
│   │   └── IslamicModels.swift
│   ├── Networking/
│   │   ├── APIError.swift
│   │   └── HTTPClient.swift
│   ├── Services/
│   │   ├── PrayerService.swift
│   │   ├── QuranService.swift
│   │   └── ContentService.swift
│   └── Utilities/
│       ├── LocationManager.swift
│       ├── QiblaCalculator.swift
│       └── NotificationScheduler.swift
├── Features/
│   ├── Home/
│   │   ├── HomeView.swift
│   │   └── HomeViewModel.swift
│   ├── Quran/
│   │   ├── QuranView.swift
│   │   └── QuranViewModel.swift
│   ├── Azkar/
│   │   ├── AzkarView.swift
│   │   └── AzkarViewModel.swift
│   ├── Qibla/
│   │   ├── QiblaView.swift
│   │   └── QiblaViewModel.swift
│   └── Settings/
│       └── SettingsViewModel.swift
└── Resources/
```

### كيف يطبق MVVM هنا؟
- **Model:** الكيانات مثل `PrayerTimes`, `Ayah`, `Hadith`, `Surah`.
- **View:** الواجهات SwiftUI لكل شاشة.
- **ViewModel:** منطق الحالة والتحميل والبحث والتشغيل.
- **Service Layer:** فصل استدعاءات API عن ViewModel.

---

## 2) تصميم الواجهات (UI Layout)

### A) الشاشة الرئيسية (Home)
- Card: مواقيت الصلاة.
- Card: آية اليوم.
- Card: حديث اليوم.
- تصميم Vertical Cards مناسب للموبايل والتابلت.

### B) قسم القرآن
- SearchBar للبحث عن سورة أو نص آية.
- قائمة سور.
- عند فتح السورة: عرض الآيات + زر تشغيل التلاوة.

### C) قسم الأذكار
- تبويبين منطقيين أو Sections:
  - أذكار الصباح.
  - أذكار المساء.
- Card خاص بالسبحة الإلكترونية مع:
  - العدد الحالي.
  - زر زيادة.
  - زر إعادة تعيين.

### D) قسم القبلة
- مؤشر بصري (سهم/بوصلة) يدور حسب الزاوية.
- نص يوضح الدرجة الحالية.
- زر تحديث الاتجاه.

### E) الوضع الليلي + RTL
- `preferredColorScheme` من الإعدادات.
- RTL في iOS يعمل تلقائيًا مع اللغة العربية، ويمكن فرضه عند الحاجة من Environment.

---

## 3) كود مبدئي لكل قسم

تم إنشاء كود ابتدائي منظم ومشروح بالتعليقات داخل الملفات:

- **App Entry + Tabs:**
  - `IslamicAppStarter/App/IslamicApp.swift`
  - `IslamicAppStarter/App/MainTabView.swift`

- **Home (مواقيت + آية + حديث):**
  - `IslamicAppStarter/Features/Home/HomeView.swift`
  - `IslamicAppStarter/Features/Home/HomeViewModel.swift`

- **Quran (عرض + بحث + تلاوة):**
  - `IslamicAppStarter/Features/Quran/QuranView.swift`
  - `IslamicAppStarter/Features/Quran/QuranViewModel.swift`

- **Azkar + Tasbih:**
  - `IslamicAppStarter/Features/Azkar/AzkarView.swift`
  - `IslamicAppStarter/Features/Azkar/AzkarViewModel.swift`

- **Qibla:**
  - `IslamicAppStarter/Features/Qibla/QiblaView.swift`
  - `IslamicAppStarter/Features/Qibla/QiblaViewModel.swift`
  - `IslamicAppStarter/Core/Utilities/QiblaCalculator.swift`

- **Notifications:**
  - `IslamicAppStarter/Core/Utilities/NotificationScheduler.swift`

- **Services / APIs:**
  - `IslamicAppStarter/Core/Services/PrayerService.swift`
  - `IslamicAppStarter/Core/Services/QuranService.swift`
  - `IslamicAppStarter/Core/Services/ContentService.swift`

---

## APIs موثوقة مقترحة

### مواقيت الصلاة
- **AlAdhan API**
  - سهل وموثوق وشائع.

### القرآن الكريم
- **AlQuran Cloud API** (نصوص وسور)
- **Quran.com API** (خيارات غنية جدًا)

### الحديث النبوي
- يمكن استخدام API موثوقة مثل **Sunnah API** أو مصدر موثوق داخلي (JSON محقق).

> ملاحظة: في هذا الـ Starter تم وضع نماذج أولية (Stub) في بعض الأماكن لتسهيل الانطلاق بسرعة، ثم يتم ربطها نهائيًا مع API الحقيقية.

---

## أفضل مكتبات Swift مقترحة

- **Alamofire**: لو فضلت networking متقدم (رغم أن URLSession يكفي لكثير من الحالات).
- **Kingfisher**: تحميل وتخزين الصور (لو أضفت محتوى صور لاحقًا).
- **SwiftLint**: توحيد جودة الكود.
- **Lottie**: أنيميشن احترافي (شاشات onboarding أو transitions).
- **Combine / async-await**: لإدارة التدفقات غير المتزامنة.
- **CoreLocation + CoreMotion**: للموقع والبوصلة والقبلة.
- **UserNotifications**: إشعارات الصلاة.
- **AVFoundation**: تشغيل التلاوات الصوتية.

---

## 4) تحسينات مستقبلية مقترحة

1. **Offline Mode**
   - تخزين السور والأذكار محليًا عبر CoreData/SQLite.
2. **Widget + Live Activities**
   - ويدجت لمواقيت الصلاة والعد التنازلي للصلاة القادمة.
3. **Apple Watch App**
   - تنبيه الصلاة والسبحة من الساعة.
4. **AI Personalization**
   - اقتراح أذكار/آيات بناءً على الوقت أو الاستخدام.
5. **تجربة صوتية متقدمة**
   - اختيار القارئ، سرعة التشغيل، وضع التكرار.
6. **اختبارات آلية**
   - Unit Tests للـ ViewModels.
   - UI Tests للتدفقات الرئيسية.
7. **تحسين الوصول Accessibility**
   - Dynamic Type، VoiceOver Labels، تباين ألوان محسّن.

---

## ملاحظات تنفيذ مهمة

- جميع الملفات مكتوبة بأسلوب **MVVM واضح**.
- يوجد **تعليقات توضيحية** داخل الكود لكل جزء رئيسي.
- يمكن تشغيل هذا الهيكل مباشرة داخل Xcode عبر إنشاء مشروع SwiftUI وربط الملفات داخله.

إذا رغبت، في الخطوة التالية أقدر أبني لك:
1) نسخة **جاهزة للتشغيل** مع APIs حقيقية بالكامل.
2) ثيم بصري احترافي كامل (Design System).
3) خطة نشر على App Store.
