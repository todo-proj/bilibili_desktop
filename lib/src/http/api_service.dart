import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'api_response.dart';
import 'model/account_model.dart';
import 'model/login_qr_code_model.dart';
import 'model/recommend_video_model.dart';
import 'model/video_info_model.dart';
import 'model/video_reply_model.dart';
import 'model/video_url_model.dart';
import 'network_config.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: NetworkConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // base url: https://passport.bilibili.com/x/
  @GET('x/passport-login/web/qrcode/generate')
  Future<ApiResponse<LoginQRCodeModel>> generateCode();

  @GET("x/passport-login/web/qrcode/poll")
  Future<ApiResponse<dynamic>> checkCode(
    @Query("qrcode_key") String qrcodeKey,
  );


  @GET("x/web-interface/index/top/rcmd")
  Future<ApiResponse<RecommendVideoModel>> getRecommendVideoList(
    @Query("ps") int pageSize, {
    @Query("fresh_type") int freshType = 3,
  });

  @GET("x/member/web/account")
  Future<ApiResponse<AccountModel>> getAccountInfo();

  @GET("x/web-interface/view")
  Future<ApiResponse<VideoInfoModel>> videoInfo(@Query("bvid") String bvid);

  @GET("x/player/playurl")
  Future<ApiResponse<VideoUrlModel>> videoUrl(
    @Query("bvid") String bvid,
    @Query("cid") String cid, {
    @Query("qn") String qn = "80",
  });

  @GET("x/v2/reply")
  Future<ApiResponse<VideoReplyModel>> videoReply(
    @Query("oid") String oid,
    @Query("pn") int pn, {
    @Query("type") int type = 1,
    @Query("mode") int mode = 3,
    @Query("ps") int ps = 20,
  });
}
