package com.example.white_label

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.white_label/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "_buildInternetTabContent" -> {
                    val httpRequest = HttpRequest(this)
                    httpRequest.getProducts { productList ->
                        // Send the product list back to Flutter
                        result.success(productList) // Send the product list to Flutter
                    }
                }
                else -> {
                    result.notImplemented() // Method not implemented
                }
            }
        }
    }
}
