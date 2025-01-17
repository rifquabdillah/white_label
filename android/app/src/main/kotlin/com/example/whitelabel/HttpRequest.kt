package com.example.whitelabel

import android.content.Context
import android.util.Log
import retrofit2.Call
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import okhttp3.ResponseBody
import retrofit2.Callback
import java.io.File
import java.io.FileOutputStream

class HttpRequest(private val context: Context) {

    private val baseUrl = "http://103.139.244.148:5001/" // replace with your API base URL
    private val retrofit: Retrofit = Retrofit.Builder()
        .baseUrl(baseUrl)
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    private val apiRoutes: ApiRoutes = retrofit.create(ApiRoutes::class.java)

    data class Product(
        val kodeProduk: String,
        val namaProduk: String,
        val detailProduk: String?,
        val masaAktif: String?,
        val status: Int,
        val totalKuota: String?,
        val pembagian: String?,
        val deskripsi: String?,
        val hargaJual: Int?,
        val hargaCoret: Int
    )

    // Update the response model to match the new structure
    data class ProductsResponse(
        val data: Map<String, List<Product>> // Map category names to a list of products
    )

    data class TagihanResponse(
        val data: Map<String, Any>
    )

    data class Banners(
        val penempatan: String,
        val url: String
    )

    data class BannersResponse(
        val banners: List<Banners>
    )

    fun getProducts(
        prefix: String?,
        tipe: String,
        catatan: String?,
        callback: (Map<String, List<Map<String, Any>>>) -> Unit
    ) {
        val call = apiRoutes.getProducts(prefix, tipe, catatan)
        call.enqueue(object : retrofit2.Callback<ProductsResponse> {
            override fun onResponse(
                call: Call<ProductsResponse>,
                response: Response<ProductsResponse>
            ) {
                if (response.isSuccessful) {
                    response.body()?.let { productsResponse ->
                        Log.d("HttpRequest", "Received Products: ${productsResponse.data}")

                        // Convert to a Map<String, List<Map<String, Any>>> structure with null safety for productList
                        val productsMap = productsResponse.data.mapValues { (_, productList) ->
                            productList.orEmpty().map { product ->
                                mapOf(
                                    "kodeProduk" to product.kodeProduk as Any,
                                    "namaProduk" to product.namaProduk as Any,
                                    "detailProduk" to (product.detailProduk ?: "") as Any,
                                    "masaAktif" to (product.masaAktif ?: "") as Any,
                                    "status" to product.status as Any,
                                    "totalKuota" to (product.totalKuota ?: "") as Any,
                                    "pembagian" to (product.pembagian ?: "") as Any,
                                    "deskripsi" to (product.deskripsi ?: "") as Any,
                                    "hargaJual" to product.hargaJual as Any,
                                    "hargaCoret" to product.hargaCoret as Any
                                )
                            }
                        }

                        Log.d("HttpRequest", "Mapped Products by Provider: $productsMap")

                        // Call the callback with the structured map
                        callback(productsMap)
                    } ?: run {
                        Log.w("HttpRequest", "Received empty response.")
                        callback(emptyMap()) // Return empty map if the response is null
                    }
                } else {
                    Log.e("HttpRequest", "Error: ${response.code()} ${response.message()}")
                    callback(emptyMap()) // Return empty map for error response
                }
            }

            override fun onFailure(call: Call<ProductsResponse>, t: Throwable) {
                Log.e("HttpRequest", "Network error: ${t.message}")
                callback(emptyMap()) // Return empty map on failure
            }
        })
    }

    fun fetchAndSaveImage(
        key: String,
        index: String,
        tipe: String,
        callback: (String?) -> Unit
    ) {
        // Make the request to get the product icon image
        val call = apiRoutes.getProductIcon(key)

        // Asynchronous network request to fetch the image
        call.enqueue(object : Callback<ResponseBody> {
            override fun onResponse(call: Call<ResponseBody>, response: Response<ResponseBody>) {
                if (response.isSuccessful) {
                    response.body()?.let { responseBody ->
                        try {
                            var fileName = ""
                            // Define the assets directory inside the app's private storage
                            val assetsDir = File(context.filesDir, "assets")
                            if (!assetsDir.exists()) assetsDir.mkdirs()  // Create the directory if it doesn't exist

                            // Define the file path and name
                            if (tipe == "game") {
                                fileName = "$index-game.jpg"
                            } else {
                                fileName = "$index-emoney.jpg"
                            }

                            val file = File(assetsDir, fileName)

                            // Save the image to the file
                            val outputStream = FileOutputStream(file)
                            responseBody.byteStream().use { inputStream ->
                                inputStream.copyTo(outputStream)  // Save the image data
                            }
                            outputStream.close()

                            Log.d("FETCH_IMAGE", "Image saved to: ${file.absolutePath}")

                            // Return the file path to Flutter (callback with file path)
                            callback(file.absolutePath)
                        } catch (e: Exception) {
                            // Handle any exceptions during the save process
                            Log.e("FETCH_IMAGE", "Failed to save image", e)
                            callback(null)  // Return null if there is an error
                        }
                    } ?: run {
                        Log.e("FETCH_IMAGE", "Response body is null")
                        callback(null)  // Return null if the response body is null
                    }
                } else {
                    // Log the error code and response body for debugging
                    Log.e("FETCH_IMAGE", "Failed to download image: ${response.code()}")
                    try {
                        val errorBody = response.errorBody()?.string() // Log the error body content
                        Log.e("FETCH_IMAGE", "Error Body: $errorBody")
                    } catch (e: Exception) {
                        Log.e("FETCH_IMAGE", "Failed to read error body", e)
                    }
                    callback(null)  // Return null if the download failed
                }
            }

            override fun onFailure(call: Call<ResponseBody>, t: Throwable) {
                // Handle network failures or other exceptions
                Log.e("FETCH_IMAGE", "Failed to fetch image", t)
                callback(null)  // Return null if the request failed
            }
        })
    }

    fun getTagihan(
        kodeProduk: String,
        data: String,
        callback: (Map<String, Any>) -> Unit
    ) {
        val call = apiRoutes.getTagihan(kodeProduk, data)
        call.enqueue(object : retrofit2.Callback<TagihanResponse> {
            override fun onResponse(
                call: Call<TagihanResponse>,
                response: Response<TagihanResponse>
            ) {
                if (response.isSuccessful) {
                    response.body()?.let { tagihanResponse ->
                        // Pass the dynamic map to the callback
                        Log.e("TAGIHAN", "Received Tagihan: ${tagihanResponse.data}")
                        callback(tagihanResponse.data)
                    }
                } else {
                    // Handle unsuccessful response (error case)
                    Log.e("TAGIHAN", "Fucked Up")
                    callback(emptyMap())
                }
            }

            override fun onFailure(call: Call<TagihanResponse>, t: Throwable) {
                // Handle failure (e.g., network issue)
                Log.e("TAGIHAN", "Fucked Up")
                callback(emptyMap())
            }
        })
    }

    fun getBanners(callback: (List<Map<String, Any>>) -> Unit) {
        val call = apiRoutes.getBanners()
        call.enqueue(object : retrofit2.Callback<BannersResponse> {
            override fun onResponse(
                call: Call<BannersResponse>,
                response: Response<BannersResponse>
            ) {
                if (response.isSuccessful) {
                    response.body()?.let { bannerResponse ->

                        Log.d("HttpRequest", "Received Banners: ${bannerResponse.banners}") // Log the raw response

                        // Convert the banners list to a list of maps
                        val bannerList = bannerResponse.banners.map { banner ->
                            mapOf(
                                "penempatan" to banner.penempatan,
                                "url" to banner.url
                            )
                        }

                        Log.d("HttpRequest", "Received Banners as List of Maps: $bannerList") // Log the converted response
                        callback(bannerList) // Return the list of maps via callback

                    } ?: run {
                        // Handle case where body is null (could indicate an empty response)
                        Log.w("HttpRequest", "Received empty response.")
                        callback(emptyList()) // Return empty list
                    }
                } else {
                    // Handle the error response (e.g., non-2xx status codes)
                    Log.e("HttpRequest", "Error: ${response.code()} ${response.message()}")
                    callback(emptyList()) // Return empty list
                }
            }

            override fun onFailure(call: Call<BannersResponse>, t: Throwable) {
                // Handle the failure case, e.g., network error
                Log.e("HttpRequest", "Network error: ${t.message}")
                callback(emptyList()) // Return empty list on failure
            }
        })
    }
}
