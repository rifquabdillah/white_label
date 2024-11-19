package com.example.whitelabel

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.provider.ContactsContract
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import android.speech.RecognitionListener
import android.speech.RecognizerIntent
import android.speech.SpeechRecognizer
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val PULSA_PAKET_PRODUK_CHANNEL = "com.example.whitelabel/pulsa_paket_produk_channel"
    private val UTILS_CHANNEL = "com.example.whitelabel/utils"
    private val PRODUK_CHANNEL = "com.example.whitelabel/produk"
    private val TAGIHAN_CHANNEL = "com.example.whitelabel/tagihan"
    private val IMAGES_CHANNEL = "com.example.whitelabel/images"

    private val PICK_CONTACT_REQUEST_CODE = 1
    private val SPEECH_REQUEST_CODE = 2
    private val IMAGE_PICKER_REQUEST_CODE = 3

    private lateinit var speechRecognizer: SpeechRecognizer

    private val httpRequest = HttpRequest(this)
    private val utils = Utils(this)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Channel untuk UTILS
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, UTILS_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "checkPermission" -> {
                        val isGranted = utils.checkPermissions()
                        result.success(isGranted)
                    }
                    "getContact" -> {
                        if (utils.checkPermissions()) {
                            launchContactPicker() // Launch contact picker
                        } else {
                            result.error("PERMISSION_DENIED", "Read Contacts permission is required.", null)
                        }
                    }
                    "startSpeechRecognition" -> {
                        if (utils.checkPermissions()) {
                            startSpeechRecognition(result)
                        } else {
                            result.error("PERMISSION_DENIED", "Record Audio permission is required.", null)
                        }
                    }
                    "pickImageFromGallery" -> {
                        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED) {
                            launchImagePicker(result)
                        } else {
                            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE), IMAGE_PICKER_REQUEST_CODE)
                            result.error("PERMISSION_DENIED", "Read External Storage permission is required.", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PRODUK_CHANNEL)
            .setMethodCallHandler { call, result ->

                val prefix = call.argument<String?>("prefix")
                val tipe = call.argument<String>("tipe")
                val catatan = call.argument<String?>("catatan")

                when (call.method) {
                    "fetchProduk" -> {
                        if (tipe != null) {
                            httpRequest.getProducts(prefix ?: "", tipe, catatan ?: "") { response ->
                                result.success(response)
                            }
                        } else {
                            result.error("500", "Tipe Produk Kosong", "Fucked Up")
                        }
                    }
                    else -> result.notImplemented()
                }
            }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, TAGIHAN_CHANNEL)
            .setMethodCallHandler { call, result ->

                val kodeProduk = call.argument<String>("kodeProduk")
                val data = call.argument<String>("data")

                Log.e("TAGIHAN_CHANNEL", "Received kodeProduk: $kodeProduk, data: $data")

                when (call.method) {
                    "fetchTagihan" -> {
                        httpRequest.getTagihan(kodeProduk!!, data!!) { response ->
                            result.success(response)
                        }
                    } else -> result.notImplemented()
                }
            }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, IMAGES_CHANNEL)
            .setMethodCallHandler { call, result ->
                val key = call.argument<String>("key")
                Log.e("IMAGES_CHANNEL", "Received key: $key")

                when (call.method) {
                    "fetchIcon" -> {
                        httpRequest.fetchAndSaveImage(key!!) { response ->
                            result.success(response)
                        }
                    } else -> result.notImplemented()
                }
            }
    }

    // Fungsi untuk memulai pengenalan suara
    private fun startSpeechRecognition(result: MethodChannel.Result) {
        speechRecognizer = SpeechRecognizer.createSpeechRecognizer(this)
        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            putExtra(RecognizerIntent.EXTRA_LANGUAGE, "id-ID") // Set language to Indonesian
        }

        speechRecognizer.setRecognitionListener(object : RecognitionListener {
            override fun onReadyForSpeech(params: Bundle?) {}
            override fun onBeginningOfSpeech() {}
            override fun onRmsChanged(rmsdB: Float) {}
            override fun onBufferReceived(buffer: ByteArray?) {}
            override fun onEndOfSpeech() {}

            override fun onError(error: Int) {
                result.error("SPEECH_RECOGNITION_ERROR", "Error code: $error", null)
            }

            override fun onResults(results: Bundle) {
                val matches = results.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)
                if (!matches.isNullOrEmpty()) {
                    result.success(matches[0]) // Return the first result
                } else {
                    result.error("NO_SPEECH_RECOGNIZED", "No speech recognized", null)
                }
            }

            override fun onPartialResults(partialResults: Bundle?) {}
            override fun onEvent(eventType: Int, params: Bundle?) {}
        })

        speechRecognizer.startListening(intent)
    }

    // Launch contact picker
    private fun launchContactPicker() {
        val intent = Intent(Intent.ACTION_PICK, ContactsContract.Contacts.CONTENT_URI)
        startActivityForResult(intent, PICK_CONTACT_REQUEST_CODE)
    }

    // Launch image picker
    private fun launchImagePicker(result: MethodChannel.Result) {
        val intent = Intent(Intent.ACTION_PICK).apply {
            type = "image/*"
        }
        startActivityForResult(intent, IMAGE_PICKER_REQUEST_CODE)
    }

    // Gabungan onActivityResult untuk menangani berbagai request
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == IMAGE_PICKER_REQUEST_CODE && resultCode == RESULT_OK) {
            val imageUri: Uri? = data?.data
            if (imageUri != null) {
                flutterEngine?.dartExecutor?.binaryMessenger?.let {
                    MethodChannel(it, UTILS_CHANNEL).invokeMethod("imagePicked", imageUri.toString())
                }
            }
        } else if (requestCode == PICK_CONTACT_REQUEST_CODE && resultCode == RESULT_OK) {
            val contactUri: Uri? = data?.data
            contactUri?.let {
                val phoneNumber = utils.retrievePhoneNumber(it)
                flutterEngine?.dartExecutor?.binaryMessenger?.let { it1 ->
                    MethodChannel(it1, UTILS_CHANNEL).invokeMethod("contactPicked", phoneNumber)
                }
            }
        }
    }
}
