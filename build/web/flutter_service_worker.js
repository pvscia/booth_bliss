'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "f5a0caf62c0ac5ff3bfd997556adede1",
"assets/AssetManifest.bin.json": "e448b68a82aec624a9426b1626bf7522",
"assets/AssetManifest.json": "e71c6b2f8334c95502385bc700b3a3f7",
"assets/assets/default-user.png": "2f15f2e8c688b3120d3d26467b06330c",
"assets/assets/error.gif": "9455f33e221b056e8f6ec8052eb61b1f",
"assets/assets/img.png": "ce0ea8670f2629d4a263b9b230f8dc06",
"assets/assets/img_1.png": "b1d54156f309829ef2e50f2b78c0abff",
"assets/assets/layout_1.jpg": "2112f3a50845b5cc4b369f9a962ba787",
"assets/assets/layout_1.png": "d2512cdc411ad1c9285a1a0771f3ddea",
"assets/assets/layout_2.jpg": "f192d383fff1946896ee5306efe200cd",
"assets/assets/layout_2.png": "4fdaaab910af7c4fe7fb0d45837c66a5",
"assets/assets/layout_3.jpg": "137833f6b5d0b0738409a0805266e5be",
"assets/assets/layout_3.png": "fd60dd30cd93ee947116b650139489aa",
"assets/assets/layout_4.jpg": "a051dad27a048ad0d31f3a57679a1153",
"assets/assets/layout_4.png": "7c3fc4d3f6416c80723eff404646ca98",
"assets/assets/layout_5.jpg": "17ae04365101427eee32796d6f8c4cae",
"assets/assets/layout_5.png": "70399726775dd81bb2b2b381e3a017a8",
"assets/assets/layout_6.jpg": "42da79778b2257a3b43c5c3eafa44313",
"assets/assets/layout_6.png": "65e82e8638f7d7efd20f2e9143cfa4b2",
"assets/assets/logo.png": "aca698fb0391783b6460e55dc340723f",
"assets/assets/question.gif": "7efb9b05094e608dfe33f9789d391886",
"assets/assets/success.gif": "8c254ae63d8e0968ad0a9d2034b9d28a",
"assets/assets/warning.gif": "38c5238a7da1aa2732f8bb445ec5059a",
"assets/FontManifest.json": "0cd1bf945ed8e4c380bc01248ec38767",
"assets/fonts/BeautifulPeople.ttf": "894b3ff6db3e97ef001117d8c9924a28",
"assets/fonts/BeautyMountains.ttf": "c59a76cf566cf6583bcca2d201deb7b8",
"assets/fonts/Billabong.ttf": "52b04f1c2bd73f240b4ad620924a40c9",
"assets/fonts/BiteChocolate.ttf": "8368b26ff49587e717f6eabc589b439a",
"assets/fonts/BlackberryJam.ttf": "c6b7ba1dc1c80e00e6c17ac72eb753cc",
"assets/fonts/BunchBlossoms.ttf": "9d28feb1d23d6cfab7cb344a9ef3c57b",
"assets/fonts/CinderelaRegular.ttf": "6edb644ec28809e6b210ac2e0f6f85fb",
"assets/fonts/Countryside.ttf": "1a3cffa9306fa82ed542195bd55f320f",
"assets/fonts/GrandHotel.otf": "12b13e1fb62fe03b9039600c319d52b9",
"assets/fonts/Halimun.ttf": "316ee285f7fbbf7d9b6781e4daa2a02c",
"assets/fonts/LemonJelly.ttf": "9c6d8216ee966bccd5cdc68cee121903",
"assets/fonts/MaterialIcons-Regular.otf": "89b2ac065b6976f7c1e9620b1499fa7b",
"assets/fonts/Montserrat-Black.ttf": "cce7ff8c1d7999f907b6760fbe75d99d",
"assets/fonts/Montserrat-BlackItalic.ttf": "a67f4df02f4d73bb8bfd5bff421e4d1f",
"assets/fonts/Montserrat-Bold.ttf": "ed86af2ed5bbaf879e9f2ec2e2eac929",
"assets/fonts/Montserrat-BoldItalic.ttf": "a49032b6a945b021303f16b664f87e6c",
"assets/fonts/Montserrat-ExtraBold.ttf": "9e07cac927a9b4d955e2138bf6136d6a",
"assets/fonts/Montserrat-ExtraBoldItalic.ttf": "8a4a6844448e210672d54f8b32932ee9",
"assets/fonts/Montserrat-ExtraLight.ttf": "a7fe50578d9aa3966c925cb9722db03a",
"assets/fonts/Montserrat-ExtraLightItalic.ttf": "9c3e2f21cc8fba26dc3da67e89a9365d",
"assets/fonts/Montserrat-Italic-VariableFont_wght.ttf": "87a9f36eac8c031aff3af3957a14e81e",
"assets/fonts/Montserrat-Italic.ttf": "cc53ad8bb1c801746c831bb7ce493f74",
"assets/fonts/Montserrat-Light.ttf": "94fbe93542f684134cad1d775947ca92",
"assets/fonts/Montserrat-LightItalic.ttf": "c54486c33610a1fca147afc18af3034f",
"assets/fonts/Montserrat-Medium.ttf": "bdb7ba651b7bdcda6ce527b3b6705334",
"assets/fonts/Montserrat-MediumItalic.ttf": "2ed625fc9f039d801a5aab9b6f9cd8ef",
"assets/fonts/Montserrat-Regular.ttf": "5e077c15f6e1d334dd4e9be62b28ac75",
"assets/fonts/Montserrat-SemiBold.ttf": "cc10461cb5e0a6f2621c7179f4d6de17",
"assets/fonts/Montserrat-SemiBoldItalic.ttf": "75c4176c64611f32faf01a5de7631877",
"assets/fonts/Montserrat-Thin.ttf": "b3638b16904211d1d24d04ce53810c4d",
"assets/fonts/Montserrat-ThinItalic.ttf": "ff9c45e92d16324b8964447d12d1f458",
"assets/fonts/Montserrat-VariableFont_wght.ttf": "e6cb49ef6502d09136c7302d56f4197b",
"assets/fonts/OpenSans.ttf": "629a55a7e793da068dc580d184cc0e31",
"assets/fonts/Oswald.ttf": "e605f2f859072ed0443aeda5adec4181",
"assets/fonts/Quicksand.otf": "3ce1580b66db6742cecd4b41519fb5f1",
"assets/fonts/QuiteMagicalRegular.ttf": "31e85cbb9bd96ff4e117f099955f9c6b",
"assets/fonts/Tomatoes.ttf": "5eeaab6850aab5765ef94b0b34904267",
"assets/fonts/TropicalAsianDemoRegular.ttf": "fdd5ba9f22852caf617de932a0326166",
"assets/fonts/VeganStyle.ttf": "bcbde461b1330354c7d28f90910e4a2d",
"assets/NOTICES": "6c6316759175e6784f4364b2d525aee1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "de68a32dd1026a880a204905bea598ce",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "7822fe1f6dfc0a11cd0d2568e27731a3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "58d3f18a7df598032d153f90c18aa3c6",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "33022087be8c5c1de92c674e5eea9e47",
"/": "33022087be8c5c1de92c674e5eea9e47",
"main.dart.js": "be8c27ae65dd68c01ee17f99851abdda",
"manifest.json": "61b84cba9c393439c5ec0a8b51fee900",
"version.json": "64b56d209c04024511a6094b3d99d5b7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
