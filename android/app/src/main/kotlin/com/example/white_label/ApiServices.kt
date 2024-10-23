package com.example.white_label

import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface ApiService {
    // Example of a GET request for a list of products
    @GET("products")
    fun getProducts(): Call<HttpRequest.ProductsResponse>
}