import 'package:flutter/material.dart';

class AppLocalizations {

  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(
      BuildContext context) {

    return Localizations.of<
        AppLocalizations>(
      context,
      AppLocalizations,
    )!;
  }

  static const LocalizationsDelegate<
      AppLocalizations> delegate =

      _AppLocalizationsDelegate();

  static Map<String,
      Map<String, String>> localizedValues = {

    /// ENGLISH
    'en': {

      'home': 'Home',
      'tasks': 'Tasks',
      'calendar': 'Calendar',
      'subjects': 'Subjects',
      'analytics': 'Analytics',
      'study_timer': 'Study Timer',
      'submissions': 'Submissions',
      'settings': 'Settings',
      'dark_mode': 'Dark Mode',
      'logout': 'Logout',
      'hello': 'Hello',

      'add': 'Add',
      'delete': 'Delete',
      'pick_date': 'Pick Date',
      'select_subject': 'Select Subject',
      'task_title': 'Task Title',
      'submission_title': 'Submission Title',

      'no_tasks': 'No tasks added',
      'no_subjects': 'No subjects added',
      'no_submissions': 'No submissions added',

      'start': 'Start',
      'pause': 'Pause',
      'reset': 'Reset',

      'fill_fields': 'Fill all fields',

      'subject_exists':
          'Subject already exists',

      'date': 'Date',

      'select_language':
          'Select Language',

      'edit_name': 'Edit Name',

      'enter_name':
          'Enter Name',

      'save': 'Save',

      'cancel': 'Cancel',

      'take_photo':
          'Take Photo',

      'choose_photo':
          'Choose Photo',

      'remove_photo':
          'Remove Photo',

      'weekly_analytics':
          'Weekly Study Analytics',

      'upcoming_tasks':
          'Upcoming Tasks',

      'upcoming_submissions':
          'Upcoming Submissions',

      'no_upcoming_tasks':
          'No upcoming tasks',

      'no_upcoming_submissions':
          'No upcoming submissions',

      'submission_type':
          'Submission Type',

      'assignment':
          'Assignment',

      'project':
          'Project',

      'exam':
          'Exam',

      'lab':
          'Lab',

      'seminar':
          'Seminar',

      'maths': 'Maths',
      'physics': 'Physics',
      'chemistry': 'Chemistry',
      'biology': 'Biology',
      'english': 'English',
      'computer': 'Computer',
    },

    /// TELUGU
    'te': {

      'home': 'హోమ్',
      'tasks': 'టాస్క్స్',
      'calendar': 'క్యాలెండర్',
      'subjects': 'సబ్జెక్ట్స్',
      'analytics': 'అనలిటిక్స్',
      'study_timer': 'స్టడీ టైమర్',
      'submissions': 'సబ్మిషన్స్',
      'settings': 'సెట్టింగ్స్',
      'dark_mode': 'డార్క్ మోడ్',
      'logout': 'లాగౌట్',
      'hello': 'హలో',

      'add': 'జోడించు',
      'delete': 'తొలగించు',
      'pick_date': 'తేదీ ఎంచుకోండి',
      'select_subject':
          'సబ్జెక్ట్ ఎంచుకోండి',

      'task_title':
          'టాస్క్ టైటిల్',

      'submission_title':
          'సబ్మిషన్ టైటిల్',

      'no_tasks':
          'టాస్క్స్ లేవు',

      'no_subjects':
          'సబ్జెక్ట్స్ లేవు',

      'no_submissions':
          'సబ్మిషన్స్ లేవు',

      'start': 'ప్రారంభించు',
      'pause': 'ఆపు',
      'reset': 'రీసెట్',

      'fill_fields':
          'అన్ని వివరాలు ఇవ్వండి',

      'subject_exists':
          'సబ్జెక్ట్ ఇప్పటికే ఉంది',

      'date': 'తేదీ',

      'select_language':
          'భాష ఎంచుకోండి',

      'edit_name':
          'పేరు మార్చండి',

      'enter_name':
          'పేరు నమోదు చేయండి',

      'save': 'సేవ్',

      'cancel': 'రద్దు',

      'take_photo':
          'ఫోటో తీయండి',

      'choose_photo':
          'ఫోటో ఎంచుకోండి',

      'remove_photo':
          'ఫోటో తొలగించండి',

      'weekly_analytics':
          'వారపు విశ్లేషణ',

      'upcoming_tasks':
          'రాబోయే టాస్క్స్',

      'upcoming_submissions':
          'రాబోయే సబ్మిషన్స్',

      'no_upcoming_tasks':
          'టాస్క్స్ లేవు',

      'no_upcoming_submissions':
          'సబ్మిషన్స్ లేవు',

      'submission_type':
          'సబ్మిషన్ రకం',

      'assignment':
          'అసైన్‌మెంట్',

      'project':
          'ప్రాజెక్ట్',

      'exam':
          'పరీక్ష',

      'lab':
          'ల్యాబ్',

      'seminar':
          'సెమినార్',

      'maths': 'గణితం',
      'physics': 'భౌతిక శాస్త్రం',
      'chemistry': 'రసాయన శాస్త్రం',
      'biology': 'జీవశాస్త్రం',
      'english': 'ఇంగ్లీష్',
      'computer': 'కంప్యూటర్',
    },

    /// HINDI
    'hi': {

      'home': 'होम',
      'tasks': 'कार्य',
      'calendar': 'कैलेंडर',
      'subjects': 'विषय',
      'analytics': 'विश्लेषण',
      'study_timer': 'अध्ययन टाइमर',
      'submissions': 'सबमिशन',
      'settings': 'सेटिंग्स',
      'dark_mode': 'डार्क मोड',
      'logout': 'लॉगआउट',
      'hello': 'नमस्ते',

      'add': 'जोड़ें',
      'delete': 'हटाएं',
      'pick_date': 'तारीख चुनें',
      'select_subject': 'विषय चुनें',
      'task_title': 'कार्य शीर्षक',
      'submission_title': 'सबमिशन शीर्षक',

      'no_tasks': 'कोई कार्य नहीं',
      'no_subjects': 'कोई विषय नहीं',
      'no_submissions': 'कोई सबमिशन नहीं',

      'start': 'शुरू करें',
      'pause': 'रोकें',
      'reset': 'रीसेट',

      'fill_fields':
          'सभी विवरण भरें',

      'subject_exists':
          'विषय पहले से मौजूद है',

      'date': 'तारीख',

      'select_language':
          'भाषा चुनें',

      'edit_name':
          'नाम बदलें',

      'enter_name':
          'नाम दर्ज करें',

      'save': 'सेव करें',

      'cancel': 'रद्द करें',

      'take_photo':
          'फोटो लें',

      'choose_photo':
          'फोटो चुनें',

      'remove_photo':
          'फोटो हटाएं',

      'weekly_analytics':
          'साप्ताहिक विश्लेषण',

      'upcoming_tasks':
          'आगामी कार्य',

      'upcoming_submissions':
          'आगामी सबमिशन',

      'no_upcoming_tasks':
          'कोई आगामी कार्य नहीं',

      'no_upcoming_submissions':
          'कोई आगामी सबमिशन नहीं',

      'submission_type':
          'सबमिशन प्रकार',

      'assignment':
          'असाइनमेंट',

      'project':
          'प्रोजेक्ट',

      'exam':
          'परीक्षा',

      'lab':
          'लैब',

      'seminar':
          'सेमिनार',

      'maths': 'गणित',
      'physics': 'भौतिकी',
      'chemistry': 'रसायन विज्ञान',
      'biology': 'जीव विज्ञान',
      'english': 'अंग्रेज़ी',
      'computer': 'कंप्यूटर',
    },

    /// TAMIL
    'ta': {

      'home': 'முகப்பு',
      'tasks': 'பணிகள்',
      'calendar': 'காலண்டர்',
      'subjects': 'பாடங்கள்',
      'analytics': 'பகுப்பாய்வு',
      'study_timer': 'படிப்பு டைமர்',
      'submissions': 'சமர்ப்பிப்புகள்',
      'settings': 'அமைப்புகள்',
      'dark_mode': 'டார்க் மோடு',
      'logout': 'வெளியேறு',
      'hello': 'வணக்கம்',

      'add': 'சேர்',
      'delete': 'நீக்கு',
      'pick_date': 'தேதி தேர்வு செய்',
      'select_subject': 'பாடம் தேர்வு செய்',
      'task_title': 'பணி தலைப்பு',
      'submission_title':
          'சமர்ப்பிப்பு தலைப்பு',

      'no_tasks':
          'பணிகள் இல்லை',

      'no_subjects':
          'பாடங்கள் இல்லை',

      'no_submissions':
          'சமர்ப்பிப்புகள் இல்லை',

      'start': 'தொடங்கு',
      'pause': 'இடைநிறுத்து',
      'reset': 'ரீசெட்',

      'fill_fields':
          'அனைத்து விவரங்களையும் நிரப்பவும்',

      'subject_exists':
          'பாடம் ஏற்கனவே உள்ளது',

      'date': 'தேதி',

      'select_language':
          'மொழியை தேர்வு செய்',

      'edit_name':
          'பெயரை மாற்று',

      'enter_name':
          'பெயரை உள்ளிடவும்',

      'save': 'சேமி',

      'cancel': 'ரத்து',

      'take_photo':
          'புகைப்படம் எடு',

      'choose_photo':
          'புகைப்படத்தை தேர்வு செய்',

      'remove_photo':
          'புகைப்படத்தை நீக்கு',

      'weekly_analytics':
          'வாராந்திர பகுப்பாய்வு',

      'upcoming_tasks':
          'வரவிருக்கும் பணிகள்',

      'upcoming_submissions':
          'வரவிருக்கும் சமர்ப்பிப்புகள்',

      'no_upcoming_tasks':
          'பணிகள் இல்லை',

      'no_upcoming_submissions':
          'சமர்ப்பிப்புகள் இல்லை',

      'submission_type':
          'சமர்ப்பிப்பு வகை',

      'assignment':
          'ஒப்படைப்பு',

      'project':
          'திட்டம்',

      'exam':
          'தேர்வு',

      'lab':
          'லேப்',

      'seminar':
          'கருத்தரங்கு',

      'maths': 'கணிதம்',
      'physics': 'இயற்பியல்',
      'chemistry': 'வேதியியல்',
      'biology': 'உயிரியல்',
      'english': 'ஆங்கிலம்',
      'computer': 'கணினி',
    },

    /// KANNADA
    'kn': {

      'home': 'ಮುಖಪುಟ',
      'tasks': 'ಕಾರ್ಯಗಳು',
      'calendar': 'ಕ್ಯಾಲೆಂಡರ್',
      'subjects': 'ವಿಷಯಗಳು',
      'analytics': 'ವಿಶ್ಲೇಷಣೆ',
      'study_timer': 'ಅಧ್ಯಯನ ಟೈಮರ್',
      'submissions': 'ಸಲ್ಲಿಕೆಗಳು',
      'settings': 'ಸೆಟ್ಟಿಂಗ್ಸ್',
      'dark_mode': 'ಡಾರ್ಕ್ ಮೋಡ್',
      'logout': 'ಲಾಗೌಟ್',
      'hello': 'ನಮಸ್ಕಾರ',

      'add': 'ಸೇರಿಸಿ',
      'delete': 'ಅಳಿಸಿ',
      'pick_date': 'ದಿನಾಂಕ ಆಯ್ಕೆಮಾಡಿ',
      'select_subject':
          'ವಿಷಯ ಆಯ್ಕೆಮಾಡಿ',

      'task_title':
          'ಕಾರ್ಯದ ಶೀರ್ಷಿಕೆ',

      'submission_title':
          'ಸಲ್ಲಿಕೆಯ ಶೀರ್ಷಿಕೆ',

      'no_tasks':
          'ಯಾವುದೇ ಕಾರ್ಯಗಳಿಲ್ಲ',

      'no_subjects':
          'ಯಾವುದೇ ವಿಷಯಗಳಿಲ್ಲ',

      'no_submissions':
          'ಯಾವುದೇ ಸಲ್ಲಿಕೆಗಳಿಲ್ಲ',

      'start': 'ಪ್ರಾರಂಭಿಸಿ',
      'pause': 'ನಿಲ್ಲಿಸಿ',
      'reset': 'ಮರುಹೊಂದಿಸಿ',

      'fill_fields':
          'ಎಲ್ಲಾ ವಿವರಗಳನ್ನು ಭರ್ತಿ ಮಾಡಿ',

      'subject_exists':
          'ವಿಷಯ ಈಗಾಗಲೇ ಇದೆ',

      'date': 'ದಿನಾಂಕ',

      'select_language':
          'ಭಾಷೆ ಆಯ್ಕೆಮಾಡಿ',

      'edit_name':
          'ಹೆಸರು ಬದಲಾಯಿಸಿ',

      'enter_name':
          'ಹೆಸರು ನಮೂದಿಸಿ',

      'save': 'ಉಳಿಸಿ',

      'cancel': 'ರದ್ದುಮಾಡಿ',

      'take_photo':
          'ಫೋಟೋ ತೆಗೆದುಕೊಳ್ಳಿ',

      'choose_photo':
          'ಫೋಟೋ ಆಯ್ಕೆಮಾಡಿ',

      'remove_photo':
          'ಫೋಟೋ ತೆಗೆದುಹಾಕಿ',

      'weekly_analytics':
          'ವಾರದ ವಿಶ್ಲೇಷಣೆ',

      'upcoming_tasks':
          'ಬರುವ ಕಾರ್ಯಗಳು',

      'upcoming_submissions':
          'ಬರುವ ಸಲ್ಲಿಕೆಗಳು',

      'no_upcoming_tasks':
          'ಯಾವುದೇ ಬರುವ ಕಾರ್ಯಗಳಿಲ್ಲ',

      'no_upcoming_submissions':
          'ಯಾವುದೇ ಬರುವ ಸಲ್ಲಿಕೆಗಳಿಲ್ಲ',

      'submission_type':
          'ಸಲ್ಲಿಕೆಯ ವಿಧ',

      'assignment':
          'ಅಸೈನ್‌ಮೆಂಟ್',

      'project':
          'ಪ್ರಾಜೆಕ್ಟ್',

      'exam':
          'ಪರೀಕ್ಷೆ',

      'lab':
          'ಲ್ಯಾಬ್',

      'seminar':
          'ಸೆಮಿನಾರ್',

      'maths': 'ಗಣಿತ',
      'physics': 'ಭೌತಶಾಸ್ತ್ರ',
      'chemistry': 'ರಸಾಯನಶಾಸ್ತ್ರ',
      'biology': 'ಜೀವಶಾಸ್ತ್ರ',
      'english': 'ಇಂಗ್ಲಿಷ್',
      'computer': 'ಕಂಪ್ಯೂಟರ್',
    },

    /// SWEDISH
    'sv': {

      'home': 'Hem',
      'tasks': 'Uppgifter',
      'calendar': 'Kalender',
      'subjects': 'Ämnen',
      'analytics': 'Analys',
      'study_timer': 'Studietimer',
      'submissions': 'Inlämningar',
      'settings': 'Inställningar',
      'dark_mode': 'Mörkt läge',
      'logout': 'Logga ut',
      'hello': 'Hej',

      'add': 'Lägg till',
      'delete': 'Ta bort',
      'pick_date': 'Välj datum',

      'select_subject':
          'Välj ämne',

      'task_title':
          'Uppgiftstitel',

      'submission_title':
          'Inlämningstitel',

      'no_tasks':
          'Inga uppgifter',

      'no_subjects':
          'Inga ämnen',

      'no_submissions':
          'Inga inlämningar',

      'start': 'Starta',
      'pause': 'Pausa',
      'reset': 'Återställ',

      'fill_fields':
          'Fyll i alla fält',

      'subject_exists':
          'Ämnet finns redan',

      'date': 'Datum',

      'select_language':
          'Välj språk',

      'edit_name':
          'Redigera namn',

      'enter_name':
          'Ange namn',

      'save': 'Spara',

      'cancel': 'Avbryt',

      'take_photo':
          'Ta foto',

      'choose_photo':
          'Välj foto',

      'remove_photo':
          'Ta bort foto',

      'weekly_analytics':
          'Veckoanalys',

      'upcoming_tasks':
          'Kommande uppgifter',

      'upcoming_submissions':
          'Kommande inlämningar',

      'no_upcoming_tasks':
          'Inga kommande uppgifter',

      'no_upcoming_submissions':
          'Inga kommande inlämningar',

      'submission_type':
          'Typ av inlämning',

      'assignment':
          'Uppgift',

      'project':
          'Projekt',

      'exam':
          'Prov',

      'lab':
          'Laboration',

      'seminar':
          'Seminarium',

      'maths': 'Matematik',
      'physics': 'Fysik',
      'chemistry': 'Kemi',
      'biology': 'Biologi',
      'english': 'Engelska',
      'computer': 'Dator',
    },
  };

  String translate(String key) {

    return localizedValues[
            locale.languageCode]?[key]

        ??

        localizedValues['en']![key]

        ??

        key;
  }
}

class _AppLocalizationsDelegate

    extends LocalizationsDelegate<
        AppLocalizations> {

  const _AppLocalizationsDelegate();

  @override
  bool isSupported(
      Locale locale) {

    return [

      'en',
      'te',
      'hi',
      'ta',
      'kn',
      'sv',

    ].contains(
        locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(
      Locale locale) async {

    return AppLocalizations(
        locale);
  }

  @override
  bool shouldReload(

      covariant LocalizationsDelegate<
              AppLocalizations>
          old) {

    return false;
  }
}