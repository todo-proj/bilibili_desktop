import 'package:bilibili_desktop/src/http/model/basic_user_info_model.dart';
import 'package:bilibili_desktop/src/http/model/relation_stat_model.dart';
import 'package:bilibili_desktop/src/http/model/reply_message_model.dart';
import 'package:bilibili_desktop/src/http/model/search_hot_word_model.dart';
import 'package:bilibili_desktop/src/http/model/search_result_model.dart';
import 'package:bilibili_desktop/src/http/model/session_model.dart';
import 'package:bilibili_desktop/src/http/model/simple_user_card_model.dart';
import 'package:bilibili_desktop/src/http/model/single_unread_message_model.dart';
import 'package:bilibili_desktop/src/http/model/unread_message_model.dart';
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

  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/search/suggest.md
  @GET('suggest')
  Future<String> searchSuggest(@Query('term') String term);

  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/search/hot.md
  @GET("x/web-interface/wbi/search/square")
  Future<ApiResponse<SearchHotWordModel>> searchHot(@Query('limit') int limit);

  @GET("x/v2/reply")
  Future<ApiResponse<VideoReplyModel>> videoReply(
    @Query("oid") String oid,
    @Query("pn") int pn, {
    @Query("type") int type = 1,
    @Query("mode") int mode = 3,
    @Query("ps") int ps = 20,
  });

  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/message/msg.md
  // baseUrl  https://api.vc.bilibili.com/
  @GET('x/im/web/msgfeed/unread')
  Future<ApiResponse<UnreadMessageModel>> getUnreadMsg();

  @GET('x/msgfeed/reply')
  Future<ApiResponse<ReplyMessageModel>> getReplyMsg();

  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/message/private_msg.md#%E6%9C%AA%E8%AF%BB%E7%A7%81%E4%BF%A1%E6%95%B0
  // baseUrl  https://api.vc.bilibili.com/
  @GET('session_svr/v1/session_svr/single_unread')
  Future<ApiResponse<SingleUnreadMessageModel>> getSingleUnreadMsg();

  @GET('session_svr/v1/session_svr/get_sessions')
  Future<ApiResponse<SessionModel>> getSessions({@Query('session_type') int sessionType = 4, @Query('size') int size = 50});

  @POST('session_svr/v1/session_svr/remove_session')
  @FormUrlEncoded()
  Future<ApiResponse<dynamic>> removeSession(@Field('talker_id') int talkerId, @Field('session_type') int sessionType, @Field('csrf_token') String csrfToken, @Field('csrf') String csrf);

  // 设置会话为已读
  @POST('session_svr/v1/session_svr/update_ack')
  @FormUrlEncoded()
  Future<ApiResponse<dynamic>> updateSessionRead(@Field('talker_id') int talkerId, @Field('session_type') int sessionType, @Field('csrf_token') String csrfToken, @Field('csrf') String csrf);

  // 修改会话置顶状态
  // 0：置顶 1 ：取消置顶
  @POST('session_svr/v1/session_svr/set_top')
  @FormUrlEncoded()
  Future<ApiResponse<dynamic>> setSessionTop(@Field('talker_id') int talkerId, @Field('session_type') int sessionType, @Field('op_type') int opType, @Field('csrf_token') String csrfToken, @Field('csrf') String csrf);

  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/user/info.md#%E5%A4%9A%E7%94%A8%E6%88%B7%E8%AF%A6%E7%BB%86%E4%BF%A1%E6%81%AF
  @GET('x/polymer/pc-electron/v1/user/cards')
  Future<ApiResponse<SimpleUserCardModel>> getMultiUserCards(@Query('uids') String uids);
}
