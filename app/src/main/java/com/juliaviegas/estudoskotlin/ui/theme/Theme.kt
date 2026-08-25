package com.juliaviegas.estudoskotlin.ui.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable

/**
 * Minimal theme wrapper using default Material3 colors and typography.
 * Kept intentionally simple to resemble an amateur project after only a couple
 * of Kotlin lessons. No custom colors are defined here.
 */
@Composable
fun EstudosKotlinTheme(content: @Composable () -> Unit) {
    MaterialTheme(content = content)
}
