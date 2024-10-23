package com.example.white_label

import android.content.Context
import android.util.Log
import retrofit2.Call
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class HttpRequest(private val context: Context) {

    private val baseUrl = "http://103.139.244.148:5001/" // replace with your API base URL
    private val retrofit: Retrofit = Retrofit.Builder()
        .baseUrl(baseUrl)
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    private val apiService: ApiService = retrofit.create(ApiService::class.java)

    data class Product(
        val kodeProduk: String,
        val namaProduk: String,
        val detailProduk: String,
        val masaAktif: String?,
        val status: Int,
        val totalKuota: String,
        val pembagian: String,
        val deskripsi: String?,
        val hargaJual: Int?,
        val hargaCoret: Int?
    )

    // Update the response model to match the "products" object
    data class ProductsResponse(
        val products: Map<String, Product> // This will map the product ID to the product details
    )

    fun getProducts(callback: (List<Map<String, Any>>) -> Unit) {
        val call = apiService.getProducts()
        call.enqueue(object : retrofit2.Callback<ProductsResponse> {
            override fun onResponse(
                call: Call<ProductsResponse>,
                response: retrofit2.Response<ProductsResponse>
            ) {
                if (response.isSuccessful) {
                    response.body()?.let { productsResponse ->
                        Log.d(
                            "HttpRequest",
                            "Received Products: ${productsResponse.products}"
                        ) // Log the raw response

                        // Convert the products map to a list of maps
                        val productList = productsResponse.products.map { (_, product) ->
                            val productMap = mapOf(
                                "kodeProduk" to product.kodeProduk,
                                "namaProduk" to product.namaProduk,
                                "detailProduk" to product.detailProduk,
                                "masaAktif" to (product.masaAktif ?: ""),
                                "status" to product.status,
                                "totalKuota" to product.totalKuota,
                                "pembagian" to product.pembagian,
                                "deskripsi" to (product.deskripsi ?: "")
                            )
                            Log.d(
                                "HttpRequest",
                                "Mapping Product: $productMap"
                            ) // Log each mapped product
                            productMap
                        }

                        // Call the callback with the list of maps
                        callback(productList)
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

            override fun onFailure(call: Call<ProductsResponse>, t: Throwable) {
                // Handle the failure case, e.g., network error
                Log.e("HttpRequest", "Network error: ${t.message}")
                callback(emptyList()) // Return empty list on failure
            }
        })
    }
}
