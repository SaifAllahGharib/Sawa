package com.sawa.app

import android.animation.Animator
import android.animation.AnimatorListenerAdapter
import android.animation.AnimatorSet
import android.animation.ObjectAnimator
import android.util.Property
import android.view.View
import android.view.animation.AccelerateDecelerateInterpolator
import androidx.core.splashscreen.SplashScreenViewProvider

object SplashAnimator {

    private const val SCALE_FACTOR = 3f
    private const val DURATION = 1000L

    fun playExitAnimation(iconView: View, splashViewProvider: SplashScreenViewProvider) {
        val scaleX = createScaleAnimation(iconView, View.SCALE_X)
        val scaleY = createScaleAnimation(iconView, View.SCALE_Y)
        val fadeOut = createFadeOutAnimation(iconView)

        AnimatorSet().apply {
            playTogether(scaleX, scaleY, fadeOut)
            addListener(object : AnimatorListenerAdapter() {
                override fun onAnimationEnd(animation: Animator) {
                    splashViewProvider.remove()
                }
            })
            
            start()
        }
    }

    private fun createScaleAnimation(
        view: View,
        property: Property<View?, Float?>?,
    ): ObjectAnimator {
        return ObjectAnimator.ofFloat(view, property, 1f, SCALE_FACTOR)
            .apply {
                duration = DURATION
                interpolator = AccelerateDecelerateInterpolator()
            }
    }

    private fun createFadeOutAnimation(view: View): ObjectAnimator {
        return ObjectAnimator.ofFloat(view, View.ALPHA, 1f, 0f).apply {
            duration = DURATION
            interpolator = AccelerateDecelerateInterpolator()
        }
    }
}
