part of drive_v2_api_console;

/** Client to access the drive v2 API */
/** The API to interact with Drive. */
class Drive extends ConsoleClient {

  AboutResource_ _about;
  AboutResource_ get about => _about;
  AppsResource_ _apps;
  AppsResource_ get apps => _apps;
  ChangesResource_ _changes;
  ChangesResource_ get changes => _changes;
  ChildrenResource_ _children;
  ChildrenResource_ get children => _children;
  CommentsResource_ _comments;
  CommentsResource_ get comments => _comments;
  FilesResource_ _files;
  FilesResource_ get files => _files;
  ParentsResource_ _parents;
  ParentsResource_ get parents => _parents;
  PermissionsResource_ _permissions;
  PermissionsResource_ get permissions => _permissions;
  PropertiesResource_ _properties;
  PropertiesResource_ get properties => _properties;
  RepliesResource_ _replies;
  RepliesResource_ get replies => _replies;
  RevisionsResource_ _revisions;
  RevisionsResource_ get revisions => _revisions;

  /** OAuth Scope2: View and manage the files and documents in your Google Drive */
  static const core.String DRIVE_SCOPE = "https://www.googleapis.com/auth/drive";

  /** OAuth Scope2: View your Google Drive apps */
  static const core.String DRIVE_APPS_READONLY_SCOPE = "https://www.googleapis.com/auth/drive.apps.readonly";

  /** OAuth Scope2: View and manage Google Drive files that you have opened or created with this app */
  static const core.String DRIVE_FILE_SCOPE = "https://www.googleapis.com/auth/drive.file";

  /** OAuth Scope2: View metadata for files and documents in your Google Drive */
  static const core.String DRIVE_METADATA_READONLY_SCOPE = "https://www.googleapis.com/auth/drive.metadata.readonly";

  /** OAuth Scope2: View the files and documents in your Google Drive */
  static const core.String DRIVE_READONLY_SCOPE = "https://www.googleapis.com/auth/drive.readonly";

  /** OAuth Scope2: Modify your Google Apps Script scripts' behavior */
  static const core.String DRIVE_SCRIPTS_SCOPE = "https://www.googleapis.com/auth/drive.scripts";

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

  Drive([oauth2.OAuth2Console auth]) : super(auth) {
    basePath = "/drive/v2/";
    rootUrl = "https://www.googleapis.com/";
    _about = new AboutResource_(this);
    _apps = new AppsResource_(this);
    _changes = new ChangesResource_(this);
    _children = new ChildrenResource_(this);
    _comments = new CommentsResource_(this);
    _files = new FilesResource_(this);
    _parents = new ParentsResource_(this);
    _permissions = new PermissionsResource_(this);
    _properties = new PropertiesResource_(this);
    _replies = new RepliesResource_(this);
    _revisions = new RevisionsResource_(this);
  }
}
