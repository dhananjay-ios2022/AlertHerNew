# Keep javax.annotation
-keep class javax.annotation.** { *; }
-dontwarn javax.annotation.**

# Keep Error Prone annotations
-keep class com.google.errorprone.annotations.** { *; }
-dontwarn com.google.errorprone.annotations.**

# Keep Tink library classes
-keep class com.google.crypto.tink.** { *; }
-dontwarn com.google.crypto.tink.**
