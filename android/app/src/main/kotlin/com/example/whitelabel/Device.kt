package com.example.whitelabel

import android.content.Context
import android.os.Build
import java.net.InetAddress
import java.net.NetworkInterface

class Device(
    private val context: Context
) {

    private fun getDevicesInfo(): MutableMap<String, String> {
        val devicesInfo: MutableMap<String, String> = mutableMapOf()

        devicesInfo["Brand"] = Build.BRAND
        devicesInfo["Model"] = Build.MODEL
        devicesInfo["Manufacturer"] = Build.MANUFACTURER
        devicesInfo["Device"] = Build.DEVICE
        devicesInfo["ID"] = Build.ID
        devicesInfo["Product"] = Build.PRODUCT
        devicesInfo["SDK"] = Build.VERSION.SDK_INT.toString()
        devicesInfo["Version Release"] = Build.VERSION.RELEASE

        return devicesInfo
    }

    private fun getIpAddress(): String? {
        try {
            val networkInterfaces = NetworkInterface.getNetworkInterfaces()
            while (networkInterfaces.hasMoreElements()) {
                val networkInterface = networkInterfaces.nextElement()
                val inetAddresses = networkInterface.inetAddresses
                while (inetAddresses.hasMoreElements()) {
                    val inetAddress = inetAddresses.nextElement()
                    if (!inetAddress.isLoopbackAddress && inetAddress is InetAddress) {
                        return inetAddress.hostAddress
                    }
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return null
    }

    fun fetchDevicesInfo(): MutableMap<String, String> {
        return getDevicesInfo()
    }

    fun fetchIpAddress(): String? {
        return getIpAddress()
    }
}