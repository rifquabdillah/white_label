package com.example.whitelabel

import android.Manifest
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.ContactsContract
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class Utils(
    private val mainActivity: MainActivity
) {

    fun checkPermissions(): Boolean {
        // Determine which permissions to request based on Android version
        val permissions = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU) {
            arrayOf(
                Manifest.permission.READ_CONTACTS,
                Manifest.permission.RECORD_AUDIO,
                Manifest.permission.READ_MEDIA_IMAGES
            )
        } else {
            arrayOf(
                Manifest.permission.READ_CONTACTS,
                Manifest.permission.RECORD_AUDIO,
                Manifest.permission.READ_EXTERNAL_STORAGE
            )
        }

        // Filter out any missing permissions
        val missingPermissions = permissions.filter {
            ContextCompat.checkSelfPermission(mainActivity, it) != PackageManager.PERMISSION_GRANTED
        }

        return if (missingPermissions.isEmpty()) {
            true
        } else {
            // Request missing permissions if not already granted
            ActivityCompat.requestPermissions(mainActivity, missingPermissions.toTypedArray(), REQUEST_PERMISSION)
            false
        }
    }

    fun retrievePhoneNumber(contactUri: Uri): String? {
        val contentResolver = mainActivity.contentResolver
        val cursor = contentResolver.query(contactUri, null, null, null, null)

        cursor?.use {
            if (it.moveToFirst()) {
                val id = it.getString(it.getColumnIndexOrThrow(ContactsContract.Contacts._ID))
                val hasPhoneNumber = it.getInt(it.getColumnIndexOrThrow(ContactsContract.Contacts.HAS_PHONE_NUMBER))

                if (hasPhoneNumber > 0) {
                    val phoneCursor = contentResolver.query(
                        ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
                        null,
                        "${ContactsContract.CommonDataKinds.Phone.CONTACT_ID} = ?",
                        arrayOf(id),
                        null
                    )

                    phoneCursor?.use { pc ->
                        if (pc.moveToFirst()) {
                            return pc.getString(pc.getColumnIndexOrThrow(ContactsContract.CommonDataKinds.Phone.NUMBER))
                        }
                    }
                }
            }
        }
        return null
    }

    companion object {
        private const val REQUEST_PERMISSION = 100
    }
}