    package com.example.nativekotlinpwa

    import android.content.Context
    import android.graphics.Color
    import android.net.ConnectivityManager
    import android.net.Network
    import android.net.NetworkCapabilities
    import android.net.NetworkRequest
    import android.net.Uri
    import android.os.Bundle
    import android.os.Handler
    import android.os.Looper
    import android.view.View
    import android.view.inputmethod.EditorInfo
    import android.webkit.JavascriptInterface
    import android.webkit.WebResourceError
    import android.webkit.WebResourceRequest
    import android.webkit.WebSettings
    import android.webkit.WebChromeClient
    import android.webkit.WebView
    import android.webkit.WebViewClient
    import android.widget.Button
    import android.widget.EditText
    import android.widget.ImageView
    import android.widget.ProgressBar
    import android.widget.TextView
    import androidx.appcompat.app.AppCompatActivity
    import com.facebook.shimmer.ShimmerFrameLayout
    import com.google.android.material.snackbar.Snackbar

    class MainActivity : AppCompatActivity() {
        private lateinit var webView: WebView
        private lateinit var searchInput: EditText
        private lateinit var loader: ProgressBar
        private lateinit var skeletonLoader: ShimmerFrameLayout
        private lateinit var errorView: View

        private val pwaBaseUrl = "https://ayush-charjan.github.io/bajaj_finserv_hybrid/"
        private val pwaCartBaseUrl = "https://ayush-charjan.github.io/bajaj_cart_angular/"

        private lateinit var navItems: List<View>
        private lateinit var navIcons: List<ImageView?>
        private lateinit var navTexts: List<TextView?>
        private val activeColor = Color.parseColor("#002A54")
        private val inactiveColor = Color.parseColor("#777777")

        private var currentActiveTab: String = ""
        private var isPwaReady: Boolean = false

        private var slowInternetSnackbar: Snackbar? = null
        private val slowInternetHandler = Handler(Looper.getMainLooper())
        private val slowInternetRunnable = Runnable {
            if (!isPwaReady) {
                slowInternetSnackbar = Snackbar.make(
                    findViewById(android.R.id.content),
                    "Slow internet connection. Loading...",
                    Snackbar.LENGTH_INDEFINITE
                )
                slowInternetSnackbar?.show()
            }
        }

        private val networkCallback = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                Handler(Looper.getMainLooper()).post {
                    if (errorView.visibility == View.VISIBLE) {
                        errorView.visibility = View.GONE
                        webView.reload()
                    }
                }
            }

            override fun onLost(network: Network) {
                Handler(Looper.getMainLooper()).post {
                    showOfflineBanner()
                }
            }
        }

        override fun onCreate(savedInstanceState: Bundle?) {
            super.onCreate(savedInstanceState)
            setContentView(R.layout.activity_main)

            webView = findViewById(R.id.webview)
            searchInput = findViewById(R.id.search_input)
            loader = findViewById(R.id.loader)
            skeletonLoader = findViewById(R.id.skeleton_loader)
            errorView = findViewById(R.id.error_view)

            webView.settings.apply {
                javaScriptEnabled = true
                domStorageEnabled = true
                useWideViewPort = true
                loadWithOverviewMode = true
                databaseEnabled = true
                mediaPlaybackRequiresUserGesture = false
                cacheMode = WebSettings.LOAD_DEFAULT

                val originalUA = userAgentString
                if (!originalUA.contains("BajajNativeShell")) {
                    userAgentString = "$originalUA BajajNativeShell/1.0"
                }
            }

            webView.webViewClient = object : WebViewClient() {
                override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                    val url = request?.url ?: return false
                    if (url.scheme == "native") {
                        handleNativeFeature(url.host ?: "")
                        return true
                    }
                    return false
                }

                override fun onPageStarted(view: WebView?, url: String?, favicon: android.graphics.Bitmap?) {
                    super.onPageStarted(view, url, favicon)
                    if (!isPwaReady) showLoading()
                }

                override fun onPageFinished(view: WebView?, url: String?) {
                    super.onPageFinished(view, url)
                    injectNativeBridge()


                    if (url?.contains("bajaj_cart_angular") == true) {
                        hideLoading()
                    }
                }

                override fun onReceivedError(view: WebView?, request: WebResourceRequest?, error: WebResourceError?) {
                    if (request?.isForMainFrame == true && !isNetworkAvailable()) {
                        hideLoading()
                        errorView.visibility = View.VISIBLE
                    }
                }
            }
            webView.webChromeClient = WebChromeClient()
            webView.addJavascriptInterface(NativeShellBridge(), "NativeShell")

            setupListeners()
            setupBottomNav()
            monitorNetwork()
            startApplication()
        }

        private fun showLoading() {
            isPwaReady = false
            loader.visibility = View.VISIBLE
            skeletonLoader.visibility = View.VISIBLE
            errorView.visibility = View.GONE
            skeletonLoader.startShimmer()

            // Schedule slow internet message after 5 seconds
            slowInternetHandler.removeCallbacks(slowInternetRunnable)
            slowInternetHandler.postDelayed(slowInternetRunnable, 5000)
        }

        private fun hideLoading() {
            isPwaReady = true
            // Cancel slow internet message and dismiss snackbar
            slowInternetHandler.removeCallbacks(slowInternetRunnable)
            slowInternetSnackbar?.dismiss()

            // Small delay to ensure content is rendered behind the skeleton
            Handler(Looper.getMainLooper()).postDelayed({
                loader.visibility = View.GONE
                skeletonLoader.visibility = View.GONE
                skeletonLoader.stopShimmer()
            }, 300)
        }

        private fun setupListeners() {
            findViewById<View>(R.id.btn_cart_top).setOnClickListener { loadTab("cart") }
            findViewById<View>(R.id.btn_emi_top).setOnClickListener { loadTab("payemi") }
            findViewById<View>(R.id.btn_prime_top).setOnClickListener { loadTab("offers") }
            findViewById<View>(R.id.btn_notifications_top).setOnClickListener { loadTab("notifications") }
            findViewById<View>(R.id.btn_qr_top).setOnClickListener { loadTab("scan") }
            findViewById<View>(R.id.btn_retry).setOnClickListener { startApplication() }

            findViewById<View>(R.id.btn_search).setOnClickListener {
                submitSearch(searchInput.text?.toString().orEmpty())
            }

            searchInput.setOnEditorActionListener { _, actionId, _ ->
                if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                    submitSearch(searchInput.text?.toString().orEmpty())
                    true
                } else {
                    false
                }
            }
        }

        private fun setupBottomNav() {
            val navHome = findViewById<View>(R.id.nav_home)
            val navProfile = findViewById<View>(R.id.nav_profile)
            val navScan = findViewById<View>(R.id.nav_scan)
            val navPayemi = findViewById<View>(R.id.nav_payemi)
            val navMenu = findViewById<View>(R.id.nav_menu)
            val navChat = findViewById<View>(R.id.nav_chat)

            navItems = listOf(navHome, navProfile, navScan, navPayemi, navMenu, navChat)
            navIcons = listOf(findViewById(R.id.nav_home_icon), findViewById(R.id.nav_profile_icon), null, findViewById(R.id.nav_payemi_icon), findViewById(R.id.nav_menu_icon), findViewById(R.id.nav_chat_icon))
            navTexts = listOf(findViewById(R.id.nav_home_text), findViewById(R.id.nav_profile_text), null, findViewById(R.id.nav_payemi_text), findViewById(R.id.nav_menu_text), findViewById(R.id.nav_chat_text))

            navHome.setOnClickListener { loadTab("home") }
            navProfile.setOnClickListener { loadTab("profile") }
            navScan.setOnClickListener { loadTab("scan") }
            navPayemi.setOnClickListener { loadTab("payemi") }
            navMenu.setOnClickListener { loadTab("menu") }
            navChat.setOnClickListener { loadTab("chat") }
        }

        private fun monitorNetwork() {
            val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            connectivityManager.registerNetworkCallback(
                NetworkRequest.Builder().addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET).build(),
                networkCallback
            )
        }

        private fun startApplication() {
            errorView.visibility = View.GONE
            isPwaReady = false
            if (!isNetworkAvailable()) {
                showOfflineBanner()
                webView.settings.cacheMode = WebSettings.LOAD_CACHE_ELSE_NETWORK
            } else {
                webView.settings.cacheMode = WebSettings.LOAD_DEFAULT
            }
            webView.loadUrl(buildUrl(pwaBaseUrl, "home", "home"))
            updateBottomNavUI("home")
        }

        private fun showOfflineBanner() {
            errorView.visibility = View.VISIBLE
        }

        private fun isNetworkAvailable(): Boolean {
            val cm = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val capabilities = cm.getNetworkCapabilities(cm.activeNetwork)
            return capabilities != null && (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) || capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) || capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET))
        }

        private fun loadTab(tab: String) {
            val currentUrl = webView.url ?: ""
            if (tab == currentActiveTab && currentUrl.contains("nativeShell=true")) return

            updateBottomNavUI(tab)
            currentActiveTab = tab

            val isCartApp = currentUrl.contains("bajaj_cart_angular")
            val targetIsCart = tab == "cart"

            if (targetIsCart && !isCartApp) {
                isPwaReady = false
                webView.loadUrl(buildUrl(pwaCartBaseUrl, "cart", "cart"))
            } else if (!targetIsCart && isCartApp) {
                isPwaReady = false
                webView.loadUrl(buildUrl(pwaBaseUrl, tab, tab))
            } else {
                webView.evaluateJavascript("window.dispatchEvent(new CustomEvent('nativeShellTab', { detail: '$tab' }));", null)
            }
        }

        private fun updateBottomNavUI(tab: String) {
            val activeIndex = when (tab) { "home" -> 0 "profile" -> 1 "scan" -> 2 "payemi" -> 3 "menu" -> 4 "chat" -> 5 else -> -1 }
            for (i in navItems.indices) {
                val color = if (i == activeIndex) activeColor else inactiveColor
                navIcons[i]?.setColorFilter(color)
                navTexts[i]?.setTextColor(color)
            }
        }

        private inner class NativeShellBridge {
            @JavascriptInterface
            fun postMessage(message: String) {
                runOnUiThread { handleNativeFeature(message) }
            }
        }

        private fun handleNativeFeature(feature: String) {
            when (feature.trim().lowercase()) {
                "ready" -> {
                    hideLoading()
                }
                "home", "profile", "scan", "payemi", "menu", "chat", "cart" -> {
                    updateBottomNavUI(feature)
                    currentActiveTab = feature
                }
                "scan-qr" -> loadTab("scan")
            }
        }

        private fun buildUrl(baseUrl: String, tab: String, route: String): String {
            return Uri.parse(baseUrl).buildUpon()
                .appendQueryParameter("nativeShell", "true")
                .appendQueryParameter("embedded", "true")
                .appendQueryParameter("tab", tab)
                .build().toString() + "#/$route?nativeShell=true&embedded=true&tab=$tab"
        }

        private fun submitSearch(query: String) {
            if (query.trim().isEmpty()) return
            val finalUrl = Uri.parse(pwaBaseUrl).buildUpon()
                .appendQueryParameter("nativeShell", "true")
                .appendQueryParameter("embedded", "true")
                .appendQueryParameter("tab", "home")
                .appendQueryParameter("search", query.trim())
                .build().toString() + "#/home?nativeShell=true&embedded=true&search=" + Uri.encode(query.trim())
            webView.loadUrl(finalUrl)
            updateBottomNavUI("home")
        }

        private fun injectNativeBridge() {
            webView.evaluateJavascript("(function(){if(window.__nativeShellHookInstalled)return;window.__nativeShellHookInstalled=true;window.openNativeFeature=function(f){if(window.NativeShell&&typeof window.NativeShell.postMessage==='function'){window.NativeShell.postMessage(String(f||''));}};window.addEventListener('nativeFeature',function(e){var f=e&&e.detail&&e.detail.feature;if(f)window.openNativeFeature(f);});})();", null)
        }

        override fun onDestroy() {
            try {
                val cm = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
                cm.unregisterNetworkCallback(networkCallback)
            } catch (e: Exception) {}
            super.onDestroy()
        }

        override fun onBackPressed() {
            if (this::webView.isInitialized && webView.canGoBack()) webView.goBack() else super.onBackPressed()
        }
    }