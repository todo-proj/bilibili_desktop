import 'package:bilibili_desktop/src/http/model/basic_user_info_model.dart';
import 'package:bilibili_desktop/src/http/model/relation_stat_model.dart';
import 'package:bilibili_desktop/src/http/model/search_result_model.dart';
import 'package:bilibili_desktop/src/http/model/user_card_model.dart';
import 'package:bilibili_desktop/src/http/model/wbi_img_model.dart';
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
  Future<ApiResponse<dynamic>> checkCode(@Query("qrcode_key") String qrcodeKey);

  @GET("x/member/web/account")
  Future<ApiResponse<AccountModel>> getAccount();

  @GET("x/web-interface/nav")
  Future<ApiResponse<BasicUserInfoModel>> getUserAccountInformation();


  @GET("x/web-interface/nav")
  Future<ApiResponse<WbiImgModel>> getWbiImg();

  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/misc/buvid3_4.md
  // buvid3 , buvid4 需放入cookie
  @GET("x/frontend/finger/spi")
  Future<ApiResponse<dynamic>> getFingerprint();

  @GET("x/web-interface/wbi/index/top/feed/rcmd")
  Future<ApiResponse<RecommendVideoModel>> getRecommendVideoList(
    @Query("ps") int pageSize, {
    @Query("fresh_type") int freshType = 3,
  });

  @GET("x/web-interface/view")
  Future<ApiResponse<VideoInfoModel>> videoInfo(@Query("bvid") String bvid);

  @GET('x/web-interface/card')
  Future<ApiResponse<UserCardModel>> userCard(@Query("mid") String mid,);

  @GET('x/relation/stat')
  Future<ApiResponse<RelationStatModel>> relationStat(@Query("vmid") String vmid);

  @GET("x/web-interface/archive/related")
  Future<ApiResponse<List<Item>>> getRelatedVideo(@Query("bvid") String bvid);

  @GET("x/player/wbi/playurl")
  Future<ApiResponse<VideoUrlModel>> videoUrl(@Queries() Map<String, dynamic> params);

  //https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/search/search_request.md
  //鉴权方式：Wbi 签名, Cookie 中含有 buvid3 字段
  // keyword
  @GET('x/web-interface/wbi/search/all/v2')
  Future<ApiResponse<SearchResultModel>> searchAll(@Queries() Map<String, dynamic> params);

  @GET("x/web-interface/wbi/search/type")
  Future<ApiResponse<SearchResultModel>> searchType(@Queries() Map<String, dynamic> params);

  @GET("x/v2/reply")
  Future<ApiResponse<VideoReplyModel>> videoReply(
    @Query("oid") String oid,
    @Query("pn") int pn, {
    @Query("type") int type = 1,
    @Query("mode") int mode = 3,
    @Query("ps") int ps = 20,
  });
}
