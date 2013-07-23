part of oauth2_v2_api_client;

class Tokeninfo {

  /** The access type granted with this token. It can be offline or online. */
  core.String access_type;

  /** Who is the intended audience for this token. In general the same as issued_to. */
  core.String audience;

  /** The email address of the user. Present only if the email scope is present in the request. */
  core.String email;

  /** The expiry time of the token, as number of seconds left until expiry. */
  core.int expires_in;

  /** To whom was the token issued to. In general the same as audience. */
  core.String issued_to;

  /** The space separated list of scopes granted to this token. */
  core.String scope;

  /** The Gaia obfuscated user id. */
  core.String user_id;

  /** Boolean flag which is true if the email address is verified. Present only if the email scope is present in the request. */
  core.bool verified_email;

  /** Create new Tokeninfo from JSON data */
  Tokeninfo.fromJson(core.Map json) {
    if (json.containsKey("access_type")) {
      access_type = json["access_type"];
    }
    if (json.containsKey("audience")) {
      audience = json["audience"];
    }
    if (json.containsKey("email")) {
      email = json["email"];
    }
    if (json.containsKey("expires_in")) {
      expires_in = json["expires_in"];
    }
    if (json.containsKey("issued_to")) {
      issued_to = json["issued_to"];
    }
    if (json.containsKey("scope")) {
      scope = json["scope"];
    }
    if (json.containsKey("user_id")) {
      user_id = json["user_id"];
    }
    if (json.containsKey("verified_email")) {
      verified_email = json["verified_email"];
    }
  }

  /** Create JSON Object for Tokeninfo */
  core.Map toJson() {
    var output = new core.Map();

    if (access_type != null) {
      output["access_type"] = access_type;
    }
    if (audience != null) {
      output["audience"] = audience;
    }
    if (email != null) {
      output["email"] = email;
    }
    if (expires_in != null) {
      output["expires_in"] = expires_in;
    }
    if (issued_to != null) {
      output["issued_to"] = issued_to;
    }
    if (scope != null) {
      output["scope"] = scope;
    }
    if (user_id != null) {
      output["user_id"] = user_id;
    }
    if (verified_email != null) {
      output["verified_email"] = verified_email;
    }

    return output;
  }

  /** Return String representation of Tokeninfo */
  core.String toString() => JSON.stringify(this.toJson());

}

class Userinfo {

  /** The user's birthday. The year is not present. */
  core.String birthday;

  /** The user's email address. */
  core.String email;

  /** The user's last name. */
  core.String family_name;

  /** The user's gender. */
  core.String gender;

  /** The user's first name. */
  core.String given_name;

  /** The hosted domain e.g. example.com if the user is Google apps user. */
  core.String hd;

  /** The focus obfuscated gaia id of the user. */
  core.String id;

  /** URL of the profile page. */
  core.String link;

  /** The user's default locale. */
  core.String locale;

  /** The user's full name. */
  core.String name;

  /** URL of the user's picture image. */
  core.String picture;

  /** The user's default timezone. */
  core.String timezone;

  /** Boolean flag which is true if the email address is verified. */
  core.bool verified_email;

  /** Create new Userinfo from JSON data */
  Userinfo.fromJson(core.Map json) {
    if (json.containsKey("birthday")) {
      birthday = json["birthday"];
    }
    if (json.containsKey("email")) {
      email = json["email"];
    }
    if (json.containsKey("family_name")) {
      family_name = json["family_name"];
    }
    if (json.containsKey("gender")) {
      gender = json["gender"];
    }
    if (json.containsKey("given_name")) {
      given_name = json["given_name"];
    }
    if (json.containsKey("hd")) {
      hd = json["hd"];
    }
    if (json.containsKey("id")) {
      id = json["id"];
    }
    if (json.containsKey("link")) {
      link = json["link"];
    }
    if (json.containsKey("locale")) {
      locale = json["locale"];
    }
    if (json.containsKey("name")) {
      name = json["name"];
    }
    if (json.containsKey("picture")) {
      picture = json["picture"];
    }
    if (json.containsKey("timezone")) {
      timezone = json["timezone"];
    }
    if (json.containsKey("verified_email")) {
      verified_email = json["verified_email"];
    }
  }

  /** Create JSON Object for Userinfo */
  core.Map toJson() {
    var output = new core.Map();

    if (birthday != null) {
      output["birthday"] = birthday;
    }
    if (email != null) {
      output["email"] = email;
    }
    if (family_name != null) {
      output["family_name"] = family_name;
    }
    if (gender != null) {
      output["gender"] = gender;
    }
    if (given_name != null) {
      output["given_name"] = given_name;
    }
    if (hd != null) {
      output["hd"] = hd;
    }
    if (id != null) {
      output["id"] = id;
    }
    if (link != null) {
      output["link"] = link;
    }
    if (locale != null) {
      output["locale"] = locale;
    }
    if (name != null) {
      output["name"] = name;
    }
    if (picture != null) {
      output["picture"] = picture;
    }
    if (timezone != null) {
      output["timezone"] = timezone;
    }
    if (verified_email != null) {
      output["verified_email"] = verified_email;
    }

    return output;
  }

  /** Return String representation of Userinfo */
  core.String toString() => JSON.stringify(this.toJson());

}

