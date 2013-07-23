part of oauth2_v2_api_console;

/** Client to access the oauth2 v2 API */
/** Lets you access OAuth2 protocol related APIs. */
class Oauth2 extends ConsoleClient {

  UserinfoResource_ _userinfo;
  UserinfoResource_ get userinfo => _userinfo;

  /** OAuth Scope2: Know your name, basic info, and list of people you're connected to on Google+ */
  static const core.String PLUS_LOGIN_SCOPE = "https://www.googleapis.com/auth/plus.login";

  /** OAuth Scope2: Know who you are on Google */
  static const core.String PLUS_ME_SCOPE = "https://www.googleapis.com/auth/plus.me";

  /** OAuth Scope2: View your email address */
  static const core.String USERINFO_EMAIL_SCOPE = "https://www.googleapis.com/auth/userinfo.email";

  /** OAuth Scope2: View basic information about your account */
  static const core.String USERINFO_PROFILE_SCOPE = "https://www.googleapis.com/auth/userinfo.profile";

  /**
   * Data format for the response.
   * Added as queryParameter for each request.
   */
  core.String get alt => params["alt"];
  set alt(core.String value) => params["alt"] = value;

  /**
   * Selector specifying which fields to include in a partial response.
   * Added as queryParameter for each request.
   */
  core.String get fields => params["fields"];
  set fields(core.String value) => params["fields"] = value;

  /**
   * API key. Your API key identifies your project and provides you with API access, quota, and reports. Required unless you provide an OAuth 2.0 token.
   * Added as queryParameter for each request.
   */
  core.String get key => params["key"];
  set key(core.String value) => params["key"] = value;

  /**
   * OAuth 2.0 token for the current user.
   * Added as queryParameter for each request.
   */
  core.String get oauth_token => params["oauth_token"];
  set oauth_token(core.String value) => params["oauth_token"] = value;

  /**
   * Returns response with indentations and line breaks.
   * Added as queryParameter for each request.
   */
  core.bool get prettyPrint => params["prettyPrint"];
  set prettyPrint(core.bool value) => params["prettyPrint"] = value;

  /**
   * Available to use for quota purposes for server-side applications. Can be any arbitrary string assigned to a user, but should not exceed 40 characters. Overrides userIp if both are provided.
   * Added as queryParameter for each request.
   */
  core.String get quotaUser => params["quotaUser"];
  set quotaUser(core.String value) => params["quotaUser"] = value;

  /**
   * IP address of the site where the request originates. Use this if you want to enforce per-user limits.
   * Added as queryParameter for each request.
   */
  core.String get userIp => params["userIp"];
  set userIp(core.String value) => params["userIp"] = value;

  Oauth2([oauth2.OAuth2Console auth]) : super(auth) {
    basePath = "/";
    rootUrl = "https://www.googleapis.com/";
    _userinfo = new UserinfoResource_(this);
  }

  /**
   *
   * [access_token]
   *
   * [id_token]
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Tokeninfo> tokeninfo({core.String access_token, core.String id_token, core.Map optParams}) {
    var url = "oauth2/v2/tokeninfo";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (access_token != null) queryParams["access_token"] = access_token;
    if (id_token != null) queryParams["id_token"] = id_token;
    if (optParams != null) {
      optParams.forEach((key, value) {
        if (value != null && queryParams[key] == null) {
          queryParams[key] = value;
        }
      });
    }

    if (!paramErrors.isEmpty) {
      throw new core.ArgumentError(paramErrors.join(" / "));
    }

    var response;
    response = this.request(url, "POST", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Tokeninfo.fromJson(data));
  }
}
