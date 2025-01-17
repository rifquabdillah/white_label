package com.example.whitelabel

import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query
import okhttp3.ResponseBody

interface ApiRoutes {
    @GET("products")
    fun getProducts(
        @Query("prefix") prefix: String?,
        @Query("tipe") tipe: String,
        @Query("catatan") catatan: String?
    ): Call<HttpRequest.ProductsResponse>

    @GET("banners")
    fun getBanners(): Call<HttpRequest.BannersResponse>

    @GET("tagihan")
    fun getTagihan(
        @Query("kodeProduk") kodeProduk: String,
        @Query("data") data: String
    ): Call<HttpRequest.TagihanResponse>

    @GET("image")
    fun getProductIcon(
        @Query("key") key: String
    ): Call<ResponseBody>
}