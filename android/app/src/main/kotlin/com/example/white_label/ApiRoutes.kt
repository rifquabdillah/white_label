package com.example.white_label

import com.example.white_label.HttpRequest
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface ApiRoutes {
    @GET("products")
    fun getProducts(
        @Query("prefix") prefix: String,
        @Query("tipe") tipe: String
    ): Call<HttpRequest.ProductsResponse>

    @GET("banners")
    fun getBanners(): Call<HttpRequest.BannersResponse>
}