package com.juliaviegas.estudoskotlin.ui.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.ColorScheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

// Color definitions (hex only here as required by RT4: colors come from MaterialTheme.colorScheme)
private val BackgroundColor = Color(0xFFfabeed)
private val DecrementButtonColor = Color(0xFFd40f61)
private val IncrementButtonColor = Color(0xFFa0faa7)
private val CounterTextColor = Color(0xFF000000)

private val LightColors: ColorScheme = lightColorScheme(
    primary = IncrementButtonColor,
    onPrimary = Color.White,
    secondary = DecrementButtonColor,
    onSecondary = Color.White,
    background = BackgroundColor,
    onBackground = CounterTextColor,
    surface = BackgroundColor,
    onSurface = CounterTextColor,
)

private val DarkColors: ColorScheme = darkColorScheme(
    primary = IncrementButtonColor,
    onPrimary = Color.Black,
    secondary = DecrementButtonColor,
    onSecondary = Color.Black,
    background = BackgroundColor,
    onBackground = CounterTextColor,
    surface = BackgroundColor,
    onSurface = CounterTextColor,
)

@Composable
fun EstudosKotlinTheme(
    useDarkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colors = if (useDarkTheme) DarkColors else LightColors

    MaterialTheme(
        colorScheme = colors,
        typography = androidx.compose.material3.Typography(),
        content = content
    )
}
