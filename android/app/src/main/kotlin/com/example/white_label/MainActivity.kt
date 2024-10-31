package com.example.white_label

import android.util.Log
import com.example.white_label.HttpRequest
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val PULSA_PAKET_PRODUK_CHANNEL = "com.example.white_label/pulsa_paket_produk_channel"

    private val httpRequest = HttpRequest(this)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PULSA_PAKET_PRODUK_CHANNEL)
            .setMethodCallHandler { call, result ->
                val provider = call.argument<String>("prefix")
                when (call.method) {
                    "_buildPulsaTabContent" -> {
                        httpRequest.getProducts(
                            provider!!,
                            "pulsa") { response ->
                            result.success(response)
                        }
                    }
                    "_buildSmsTelponTabContent" -> {
                        httpRequest.getProducts(
                            provider!!,
                            "nelpsms") { response ->
                            result.success(response)
                        }

                    }
                    "_buildInternetTabContent" -> {
                        httpRequest.getProducts(
                            provider!!,
                            "internet") { response ->
                            result.success(response)
                        }

                    }
                    else -> {
                        result.notImplemented() // Method not implemented
                    }
                }
            }
    }
}
