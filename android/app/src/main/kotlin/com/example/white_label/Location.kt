package com.example.white_label

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import androidx.core.app.ActivityCompat
import com.google.android.gms.location.*
import com.google.android.gms.tasks.CancellationTokenSource
import kotlinx.coroutines.tasks.await

class Location(
    private val context: Context
) {
    private suspend fun getCurrentLocation(): Location? {
        // Check for location permissions
        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED &&
            ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            return null // Return null if permissions are not granted
        }

        val locationRequest = CurrentLocationRequest.Builder()
            .setPriority(Priority.PRIORITY_HIGH_ACCURACY)
            .build()

        val cancellationTokenSource = CancellationTokenSource()
        val fusedLocationClient: FusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(context)

        return try {
            // Get the current location
            val location = fusedLocationClient.getCurrentLocation(locationRequest, cancellationTokenSource.token).await()
            location
        } catch (e: Exception) {
            null // Return null in case of an exception
        }
    }

    suspend fun fetchLocation(): Location? {
        return getCurrentLocation()
    }
}
