package com.sawa.app

import android.os.Build
import android.os.Bundle
import androidx.annotation.RequiresApi
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    @RequiresApi(Build.VERSION_CODES.S)
    override fun onCreate(savedInstanceState: Bundle?) {
        val splashScreen = installSplashScreen()

        super.onCreate(savedInstanceState)

        splashScreen.setOnExitAnimationListener { splashScreenViewProvider ->
            splashScreenViewProvider.iconView.let { iconView ->
                SplashAnimator.playExitAnimation(iconView, splashScreenViewProvider)
            }
        }
    }
}
