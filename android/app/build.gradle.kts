plugins {

    id("com.android.application")

    /// FIREBASE
    id("com.google.gms.google-services")

    id("kotlin-android")

    /// FLUTTER
    id("dev.flutter.flutter-gradle-plugin")
}

android {

    namespace =
        "com.example.study_planner_app"

    compileSdk =
        flutter.compileSdkVersion

    ndkVersion =
        flutter.ndkVersion


    compileOptions {

        /// JAVA VERSION
        sourceCompatibility =
            JavaVersion.VERSION_17

        targetCompatibility =
            JavaVersion.VERSION_17

        /// REQUIRED FOR NOTIFICATIONS
        isCoreLibraryDesugaringEnabled =
            true
    }


    kotlinOptions {

        jvmTarget = "17"
    }


    defaultConfig {

        applicationId =
            "com.example.study_planner_app"

        minSdk = flutter.minSdkVersion

        targetSdk =
            flutter.targetSdkVersion

        versionCode =
            flutter.versionCode

        versionName =
            flutter.versionName
    }


    buildTypes {

        release {

            signingConfig =
                signingConfigs.getByName(
                    "debug"
                )
        }
    }
}


dependencies {

    /// DESUGARING SUPPORT
    coreLibraryDesugaring(

        "com.android.tools:desugar_jdk_libs:2.0.4"
    )
}


flutter {

    source = "../.."
}
