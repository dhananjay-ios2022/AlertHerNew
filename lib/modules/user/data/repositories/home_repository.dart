import 'dart:convert';
import 'package:alert_her/core/constants/api_const.dart';
import 'package:alert_her/modules/user/data/models/requests/add_review_request.dart';
import 'package:alert_her/modules/user/data/models/requests/edit_review_request.dart';
import 'package:alert_her/modules/user/data/models/requests/report_request.dart';
import 'package:alert_her/modules/user/data/models/requests/subscription_request.dart';
import 'package:alert_her/modules/user/data/models/requests/update_profile_request.dart';
import 'package:alert_her/modules/user/data/models/responses/add_edit_review_response.dart';
import 'package:alert_her/modules/user/data/models/responses/base_response.dart';
import 'package:alert_her/modules/user/data/models/responses/get_profile_response.dart';
import 'package:alert_her/modules/user/data/models/responses/nationality_response.dart';
import 'package:alert_her/modules/user/data/models/responses/notification_response.dart';
import 'package:alert_her/modules/user/data/models/responses/review_history_response.dart';
import 'package:alert_her/modules/user/data/models/responses/review_stats_response.dart';
import 'package:alert_her/modules/user/data/models/responses/search_response.dart';

import '../../../../core/services/http_client.dart';
import '../../../../core/utils/api_response.dart';
import '../models/responses/add_subscription_response.dart';
import '../models/responses/delete_review_response.dart';


class HomeRepository {

  Future<ApiResponse<ReviewStatsResponse>> reviewStatsRepo(String page,String limit,String countryCode,String mobileNumber) async {
    final response = await HttpClient.get(
      "${ApiConst.reviewStats}$page&limit=$limit&mobile=$mobileNumber&countryCode=$countryCode",
    );
    if (response.statusCode == ApiStatusCode.success200.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = ReviewStatsResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

  Future<ApiResponse<AddReviewResponse>> addReviewRepo(AddReviewRequest req) async {
    final response = await HttpClient.post(
      ApiConst.addReview,
      json.encode(req.toJson()),
    );
    if (response.statusCode == ApiStatusCode.success200.value || response.statusCode == ApiStatusCode.created201.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = AddReviewResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

  Future<ApiResponse<BaseResponse>> editReviewRepo(EditReviewRequest req) async {
    final response = await HttpClient.post(
      ApiConst.editReview,
      json.encode(req.toJson()),
    );
    if (response.statusCode == ApiStatusCode.success200.value || response.statusCode == ApiStatusCode.created201.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = BaseResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

  Future<ApiResponse<SearchResponse>> searchMobileRepo(String countryCode,String mobileNumber) async {
    final response = await HttpClient.get(
      "${ApiConst.search}$countryCode&mobile=$mobileNumber",
    );
    if (response.statusCode == ApiStatusCode.success200.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = SearchResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

  Future<ApiResponse<DeleteReviewResponse>> deleteReviewRepo(String id) async {
    final response = await HttpClient.delete(
      "${ApiConst.deleteReview}/$id",
    );
    if (response.statusCode == ApiStatusCode.success200.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = DeleteReviewResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

  Future<ApiResponse<ReviewHistoryResponse>> reviewHistoryRepo(String countryCode,String mobileNumber,String limit,String page,bool flag) async {
    final response = await HttpClient.get(
      "${ApiConst.reviewHistory}$countryCode&mobile=$mobileNumber&limit=$limit&page=$page"
          "${flag ? "&recentFlag=$flag" : ""}", //&recentFlag=$flag
    );

    if (response.statusCode == ApiStatusCode.success200.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = ReviewHistoryResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

  Future<ApiResponse<NotificationResponse>> notificationHistoryRepo(String limit,String page) async {
    final response = await HttpClient.get(
      "${ApiConst.notificationHistory}$page&limit=$limit"
    );

    if (response.statusCode == ApiStatusCode.success200.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = NotificationResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }



  Future<ApiResponse<GetProfileResponse>> getProfileRepo() async {
    final response = await HttpClient.get(
      ApiConst.getProfile,
    );

    if (response.statusCode == ApiStatusCode.success200.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = GetProfileResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

  Future<ApiResponse<NationalityResponse>> getNationalityRepo() async {
    final response = await HttpClient.get(
      ApiConst.getNationalities,
    );
    if (response.statusCode == ApiStatusCode.success200.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = NationalityResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

  Future<ApiResponse<ReviewHistoryResponse>> updateProfileRepo(UpdateProfileRequest req) async {
    final response = await HttpClient.post(
      ApiConst.updateProfile,
      json.encode(req.toJson()),
    );
    if (response.statusCode == ApiStatusCode.success200.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = ReviewHistoryResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

  Future<ApiResponse<BaseResponse>> reportUserOrReviewRepo(ReportRequest req) async {
    final response = await HttpClient.post(
      ApiConst.addReport,
      json.encode(req.toJson()),
    );
    if (response.statusCode == ApiStatusCode.created201.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = BaseResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }


  Future<ApiResponse<GetSubscriptionResponse>> subscriptionRepo(SubscriptionRequest req) async {
    final response = await HttpClient.post(
      ApiConst.addSubscription,
      json.encode(req.toJson()),
    );
    if (response.statusCode == ApiStatusCode.success200.value) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final res = GetSubscriptionResponse.fromJson(responseData);
      return ApiResponse.success(res);
    } else {
      return ApiResponse.error(response.statusCode);
    }
  }

}
