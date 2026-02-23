//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
//
// class CustomWebviewScreen extends StatefulWidget {
//   final String openURL;
//   final String title;
//
//   const CustomWebviewScreen({super.key, required this.openURL, required this.title});
//
//   @override
//   State<CustomWebviewScreen> createState() => _CustomWebviewScreenState();
// }
//
// class _CustomWebviewScreenState extends State<CustomWebviewScreen> {
//   WebViewController? controllerForMobile;
//   PlatformWebViewController? controllerForWeb;
//   bool _isLoading = true;
//   int percentage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     if (!kIsWeb) {
//       controllerForMobile = WebViewController()
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..setNavigationDelegate(
//           NavigationDelegate(
//             onProgress: (int progress) {
//               setState(() {
//                 percentage = progress;
//               });
//             },
//             onPageStarted: (String url) {
//               setState(() {
//                 _isLoading = true;
//               });
//             },
//             onPageFinished: (String url) {
//               if (percentage == 100) {
//                 Future.delayed(const Duration(seconds: 2), () async {
//                   setState(() {
//                     _isLoading = false;
//                   });
//                 });
//               }
//             },
//             onHttpError: (HttpResponseError error) {
//               setState(() {
//                 _isLoading = false;
//               });
//             },
//             onWebResourceError: (WebResourceError error) {
//               setState(() {
//                 _isLoading = false;
//               });
//             },
//             onNavigationRequest: (NavigationRequest request) {
//               // if (request.url.startsWith('https://www.youtube.com/')) {
//               //   return NavigationDecision.prevent;
//               // }
//               return NavigationDecision.navigate;
//             },
//           ),
//         )
//         ..loadRequest(Uri.parse(widget.openURL));
//     } else if (kIsWeb) {
//       controllerForWeb = PlatformWebViewController(
//         const PlatformWebViewControllerCreationParams(),
//       )..loadRequest(
//           LoadRequestParams(
//             uri: Uri.parse(widget.openURL),
//           ),
//         );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: MyColors.black,
//         statusBarIconBrightness: Brightness.light,
//       ),
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: MyColors.black,
//           automaticallyImplyLeading: false,
//           title: Row(
//             children: [
//               GestureDetector(
//                 onTap: () => context.pop(),
//                 child: SvgPicture.asset(
//                   ConstImages.cross,
//                   height: 20.0,
//                   fit: BoxFit.cover,
//                   colorFilter:
//                       const ColorFilter.mode(MyColors.white, BlendMode.srcIn),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 12.0),
//                   child: TextSubHeading(
//                     text: widget.title,
//                     fontWeight: FontWeight.w400,
//                     color: MyColors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         backgroundColor: MyColors.white,
//         body: (!kIsWeb)
//             ? Stack(
//                 children: [
//                   Visibility(
//                       visible: !_isLoading,
//                       child: WebViewWidget(controller: controllerForMobile!)),
//                   if (_isLoading)
//                     LoaderWidget(percentage: percentage), // Show loader
//                 ],
//               )
//             : Stack(
//                 children: [
//                   PlatformWebViewWidget(
//                     PlatformWebViewWidgetCreationParams(
//                         controller: controllerForWeb!),
//                   ).build(context),
//                 ],
//               ),
//         bottomNavigationBar: const NetworkStatus(),
//       ),
//     );
//   }
// }
//
// class LoaderWidget extends StatelessWidget {
//   final int percentage;
//
//   const LoaderWidget({Key? key, required this.percentage}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CircularProgressIndicator(value: percentage / 100),
//             SB.h(16),
//             Text('$percentage%', style: const TextStyle(fontSize: 20)),
//           ],
//         ),
//       ),
//     );
//   }
// }
