part of drive_v2_api_client;

/** An item with user information and settings. */
class About {

  /** Information about supported additional roles per file type. The most specific type takes precedence. */
  core.List<AboutAdditionalRoleInfo> additionalRoleInfo;

  /** The domain sharing policy for the current user. */
  core.String domainSharingPolicy;

  /** The ETag of the item. */
  core.String etag;

  /** The allowable export formats. */
  core.List<AboutExportFormats> exportFormats;

  /** List of additional features enabled on this account. */
  core.List<AboutFeatures> features;

  /** The allowable import formats. */
  core.List<AboutImportFormats> importFormats;

  /** A boolean indicating whether the authenticated app is installed by the authenticated user. */
  core.bool isCurrentAppInstalled;

  /** This is always drive#about. */
  core.String kind;

  /** The largest change id. */
  core.int largestChangeId;

  /** List of max upload sizes for each file type. The most specific type takes precedence. */
  core.List<AboutMaxUploadSizes> maxUploadSizes;

  /** The name of the current user. */
  core.String name;

  /** The current user's ID as visible in the permissions collection. */
  core.String permissionId;

  /** The total number of quota bytes. */
  core.int quotaBytesTotal;

  /** The number of quota bytes used by Google Drive. */
  core.int quotaBytesUsed;

  /** The number of quota bytes used by all Google apps (Drive, Picasa, etc.). */
  core.int quotaBytesUsedAggregate;

  /** The number of quota bytes used by trashed items. */
  core.int quotaBytesUsedInTrash;

  /** The number of remaining change ids. */
  core.int remainingChangeIds;

  /** The id of the root folder. */
  core.String rootFolderId;

  /** A link back to this item. */
  core.String selfLink;

  /** The authenticated user. */
  User user;

  /** Create new About from JSON data */
  About.fromJson(core.Map json) {
    if (json.containsKey("additionalRoleInfo")) {
      additionalRoleInfo = [];
      json["additionalRoleInfo"].forEach((item) {
        additionalRoleInfo.add(new AboutAdditionalRoleInfo.fromJson(item));
      });
    }
    if (json.containsKey("domainSharingPolicy")) {
      domainSharingPolicy = json["domainSharingPolicy"];
    }
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("exportFormats")) {
      exportFormats = [];
      json["exportFormats"].forEach((item) {
        exportFormats.add(new AboutExportFormats.fromJson(item));
      });
    }
    if (json.containsKey("features")) {
      features = [];
      json["features"].forEach((item) {
        features.add(new AboutFeatures.fromJson(item));
      });
    }
    if (json.containsKey("importFormats")) {
      importFormats = [];
      json["importFormats"].forEach((item) {
        importFormats.add(new AboutImportFormats.fromJson(item));
      });
    }
    if (json.containsKey("isCurrentAppInstalled")) {
      isCurrentAppInstalled = json["isCurrentAppInstalled"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("largestChangeId")) {
      if(json["largestChangeId"] is core.String){
        largestChangeId = core.int.parse(json["largestChangeId"]);
      }else{
        largestChangeId = json["largestChangeId"];
      }
    }
    if (json.containsKey("maxUploadSizes")) {
      maxUploadSizes = [];
      json["maxUploadSizes"].forEach((item) {
        maxUploadSizes.add(new AboutMaxUploadSizes.fromJson(item));
      });
    }
    if (json.containsKey("name")) {
      name = json["name"];
    }
    if (json.containsKey("permissionId")) {
      permissionId = json["permissionId"];
    }
    if (json.containsKey("quotaBytesTotal")) {
      if(json["quotaBytesTotal"] is core.String){
        quotaBytesTotal = core.int.parse(json["quotaBytesTotal"]);
      }else{
        quotaBytesTotal = json["quotaBytesTotal"];
      }
    }
    if (json.containsKey("quotaBytesUsed")) {
      if(json["quotaBytesUsed"] is core.String){
        quotaBytesUsed = core.int.parse(json["quotaBytesUsed"]);
      }else{
        quotaBytesUsed = json["quotaBytesUsed"];
      }
    }
    if (json.containsKey("quotaBytesUsedAggregate")) {
      if(json["quotaBytesUsedAggregate"] is core.String){
        quotaBytesUsedAggregate = core.int.parse(json["quotaBytesUsedAggregate"]);
      }else{
        quotaBytesUsedAggregate = json["quotaBytesUsedAggregate"];
      }
    }
    if (json.containsKey("quotaBytesUsedInTrash")) {
      if(json["quotaBytesUsedInTrash"] is core.String){
        quotaBytesUsedInTrash = core.int.parse(json["quotaBytesUsedInTrash"]);
      }else{
        quotaBytesUsedInTrash = json["quotaBytesUsedInTrash"];
      }
    }
    if (json.containsKey("remainingChangeIds")) {
      if(json["remainingChangeIds"] is core.String){
        remainingChangeIds = core.int.parse(json["remainingChangeIds"]);
      }else{
        remainingChangeIds = json["remainingChangeIds"];
      }
    }
    if (json.containsKey("rootFolderId")) {
      rootFolderId = json["rootFolderId"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
    if (json.containsKey("user")) {
      user = new User.fromJson(json["user"]);
    }
  }

  /** Create JSON Object for About */
  core.Map toJson() {
    var output = new core.Map();

    if (additionalRoleInfo != null) {
      output["additionalRoleInfo"] = new core.List();
      additionalRoleInfo.forEach((item) {
        output["additionalRoleInfo"].add(item.toJson());
      });
    }
    if (domainSharingPolicy != null) {
      output["domainSharingPolicy"] = domainSharingPolicy;
    }
    if (etag != null) {
      output["etag"] = etag;
    }
    if (exportFormats != null) {
      output["exportFormats"] = new core.List();
      exportFormats.forEach((item) {
        output["exportFormats"].add(item.toJson());
      });
    }
    if (features != null) {
      output["features"] = new core.List();
      features.forEach((item) {
        output["features"].add(item.toJson());
      });
    }
    if (importFormats != null) {
      output["importFormats"] = new core.List();
      importFormats.forEach((item) {
        output["importFormats"].add(item.toJson());
      });
    }
    if (isCurrentAppInstalled != null) {
      output["isCurrentAppInstalled"] = isCurrentAppInstalled;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (largestChangeId != null) {
      output["largestChangeId"] = largestChangeId;
    }
    if (maxUploadSizes != null) {
      output["maxUploadSizes"] = new core.List();
      maxUploadSizes.forEach((item) {
        output["maxUploadSizes"].add(item.toJson());
      });
    }
    if (name != null) {
      output["name"] = name;
    }
    if (permissionId != null) {
      output["permissionId"] = permissionId;
    }
    if (quotaBytesTotal != null) {
      output["quotaBytesTotal"] = quotaBytesTotal;
    }
    if (quotaBytesUsed != null) {
      output["quotaBytesUsed"] = quotaBytesUsed;
    }
    if (quotaBytesUsedAggregate != null) {
      output["quotaBytesUsedAggregate"] = quotaBytesUsedAggregate;
    }
    if (quotaBytesUsedInTrash != null) {
      output["quotaBytesUsedInTrash"] = quotaBytesUsedInTrash;
    }
    if (remainingChangeIds != null) {
      output["remainingChangeIds"] = remainingChangeIds;
    }
    if (rootFolderId != null) {
      output["rootFolderId"] = rootFolderId;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }
    if (user != null) {
      output["user"] = user.toJson();
    }

    return output;
  }

  /** Return String representation of About */
  core.String toString() => JSON.stringify(this.toJson());

}

class AboutMaxUploadSizes {

  /** The max upload size for this type. */
  core.int size;

  /** The file type. */
  core.String type;

  /** Create new AboutMaxUploadSizes from JSON data */
  AboutMaxUploadSizes.fromJson(core.Map json) {
    if (json.containsKey("size")) {
      if(json["size"] is core.String){
        size = core.int.parse(json["size"]);
      }else{
        size = json["size"];
      }
    }
    if (json.containsKey("type")) {
      type = json["type"];
    }
  }

  /** Create JSON Object for AboutMaxUploadSizes */
  core.Map toJson() {
    var output = new core.Map();

    if (size != null) {
      output["size"] = size;
    }
    if (type != null) {
      output["type"] = type;
    }

    return output;
  }

  /** Return String representation of AboutMaxUploadSizes */
  core.String toString() => JSON.stringify(this.toJson());

}

class AboutExportFormats {

  /** The content type to convert from. */
  core.String source;

  /** The possible content types to convert to. */
  core.List<core.String> targets;

  /** Create new AboutExportFormats from JSON data */
  AboutExportFormats.fromJson(core.Map json) {
    if (json.containsKey("source")) {
      source = json["source"];
    }
    if (json.containsKey("targets")) {
      targets = [];
      json["targets"].forEach((item) {
        targets.add(item);
      });
    }
  }

  /** Create JSON Object for AboutExportFormats */
  core.Map toJson() {
    var output = new core.Map();

    if (source != null) {
      output["source"] = source;
    }
    if (targets != null) {
      output["targets"] = new core.List();
      targets.forEach((item) {
        output["targets"].add(item);
      });
    }

    return output;
  }

  /** Return String representation of AboutExportFormats */
  core.String toString() => JSON.stringify(this.toJson());

}

class AboutFeatures {

  /** The name of the feature. */
  core.String featureName;

  /** The request limit rate for this feature, in queries per second. */
  core.num featureRate;

  /** Create new AboutFeatures from JSON data */
  AboutFeatures.fromJson(core.Map json) {
    if (json.containsKey("featureName")) {
      featureName = json["featureName"];
    }
    if (json.containsKey("featureRate")) {
      featureRate = json["featureRate"];
    }
  }

  /** Create JSON Object for AboutFeatures */
  core.Map toJson() {
    var output = new core.Map();

    if (featureName != null) {
      output["featureName"] = featureName;
    }
    if (featureRate != null) {
      output["featureRate"] = featureRate;
    }

    return output;
  }

  /** Return String representation of AboutFeatures */
  core.String toString() => JSON.stringify(this.toJson());

}

class AboutAdditionalRoleInfo {

  /** The supported additional roles per primary role. */
  core.List<AboutAdditionalRoleInfoRoleSets> roleSets;

  /** The content type that this additional role info applies to. */
  core.String type;

  /** Create new AboutAdditionalRoleInfo from JSON data */
  AboutAdditionalRoleInfo.fromJson(core.Map json) {
    if (json.containsKey("roleSets")) {
      roleSets = [];
      json["roleSets"].forEach((item) {
        roleSets.add(new AboutAdditionalRoleInfoRoleSets.fromJson(item));
      });
    }
    if (json.containsKey("type")) {
      type = json["type"];
    }
  }

  /** Create JSON Object for AboutAdditionalRoleInfo */
  core.Map toJson() {
    var output = new core.Map();

    if (roleSets != null) {
      output["roleSets"] = new core.List();
      roleSets.forEach((item) {
        output["roleSets"].add(item.toJson());
      });
    }
    if (type != null) {
      output["type"] = type;
    }

    return output;
  }

  /** Return String representation of AboutAdditionalRoleInfo */
  core.String toString() => JSON.stringify(this.toJson());

}

class AboutAdditionalRoleInfoRoleSets {

  /** The supported additional roles with the primary role. */
  core.List<core.String> additionalRoles;

  /** A primary permission role. */
  core.String primaryRole;

  /** Create new AboutAdditionalRoleInfoRoleSets from JSON data */
  AboutAdditionalRoleInfoRoleSets.fromJson(core.Map json) {
    if (json.containsKey("additionalRoles")) {
      additionalRoles = [];
      json["additionalRoles"].forEach((item) {
        additionalRoles.add(item);
      });
    }
    if (json.containsKey("primaryRole")) {
      primaryRole = json["primaryRole"];
    }
  }

  /** Create JSON Object for AboutAdditionalRoleInfoRoleSets */
  core.Map toJson() {
    var output = new core.Map();

    if (additionalRoles != null) {
      output["additionalRoles"] = new core.List();
      additionalRoles.forEach((item) {
        output["additionalRoles"].add(item);
      });
    }
    if (primaryRole != null) {
      output["primaryRole"] = primaryRole;
    }

    return output;
  }

  /** Return String representation of AboutAdditionalRoleInfoRoleSets */
  core.String toString() => JSON.stringify(this.toJson());

}

class AboutImportFormats {

  /** The imported file's content type to convert from. */
  core.String source;

  /** The possible content types to convert to. */
  core.List<core.String> targets;

  /** Create new AboutImportFormats from JSON data */
  AboutImportFormats.fromJson(core.Map json) {
    if (json.containsKey("source")) {
      source = json["source"];
    }
    if (json.containsKey("targets")) {
      targets = [];
      json["targets"].forEach((item) {
        targets.add(item);
      });
    }
  }

  /** Create JSON Object for AboutImportFormats */
  core.Map toJson() {
    var output = new core.Map();

    if (source != null) {
      output["source"] = source;
    }
    if (targets != null) {
      output["targets"] = new core.List();
      targets.forEach((item) {
        output["targets"].add(item);
      });
    }

    return output;
  }

  /** Return String representation of AboutImportFormats */
  core.String toString() => JSON.stringify(this.toJson());

}

/** The apps resource provides a list of the apps that a user has installed, with information about each app's supported MIME types, file extensions, and other details. */
class App {

  /** Whether the app is authorized to access data on the user's Drive. */
  core.bool authorized;

  /** The various icons for the app. */
  core.List<AppIcons> icons;

  /** The ID of the app. */
  core.String id;

  /** Whether the app is installed. */
  core.bool installed;

  /** This is always drive#app. */
  core.String kind;

  /** A long description of the app. */
  core.String longDescription;

  /** The name of the app. */
  core.String name;

  /** The type of object this app creates (e.g. Chart). If empty, the app name should be used instead. */
  core.String objectType;

  /** The template url for opening files with this app. The template will contain {ids} and/or {exportIds} to be replaced by the actual file ids. */
  core.String openUrlTemplate;

  /** The list of primary file extensions. */
  core.List<core.String> primaryFileExtensions;

  /** The list of primary mime types. */
  core.List<core.String> primaryMimeTypes;

  /** The ID of the product listing for this app. */
  core.String productId;

  /** A link to the product listing for this app. */
  core.String productUrl;

  /** The list of secondary file extensions. */
  core.List<core.String> secondaryFileExtensions;

  /** The list of secondary mime types. */
  core.List<core.String> secondaryMimeTypes;

  /** A short description of the app. */
  core.String shortDescription;

  /** Whether this app supports creating new objects. */
  core.bool supportsCreate;

  /** Whether this app supports importing Google Docs. */
  core.bool supportsImport;

  /** Whether this app supports opening more than one file. */
  core.bool supportsMultiOpen;

  /** Whether the app is selected as the default handler for the types it supports. */
  core.bool useByDefault;

  /** Create new App from JSON data */
  App.fromJson(core.Map json) {
    if (json.containsKey("authorized")) {
      authorized = json["authorized"];
    }
    if (json.containsKey("icons")) {
      icons = [];
      json["icons"].forEach((item) {
        icons.add(new AppIcons.fromJson(item));
      });
    }
    if (json.containsKey("id")) {
      id = json["id"];
    }
    if (json.containsKey("installed")) {
      installed = json["installed"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("longDescription")) {
      longDescription = json["longDescription"];
    }
    if (json.containsKey("name")) {
      name = json["name"];
    }
    if (json.containsKey("objectType")) {
      objectType = json["objectType"];
    }
    if (json.containsKey("openUrlTemplate")) {
      openUrlTemplate = json["openUrlTemplate"];
    }
    if (json.containsKey("primaryFileExtensions")) {
      primaryFileExtensions = [];
      json["primaryFileExtensions"].forEach((item) {
        primaryFileExtensions.add(item);
      });
    }
    if (json.containsKey("primaryMimeTypes")) {
      primaryMimeTypes = [];
      json["primaryMimeTypes"].forEach((item) {
        primaryMimeTypes.add(item);
      });
    }
    if (json.containsKey("productId")) {
      productId = json["productId"];
    }
    if (json.containsKey("productUrl")) {
      productUrl = json["productUrl"];
    }
    if (json.containsKey("secondaryFileExtensions")) {
      secondaryFileExtensions = [];
      json["secondaryFileExtensions"].forEach((item) {
        secondaryFileExtensions.add(item);
      });
    }
    if (json.containsKey("secondaryMimeTypes")) {
      secondaryMimeTypes = [];
      json["secondaryMimeTypes"].forEach((item) {
        secondaryMimeTypes.add(item);
      });
    }
    if (json.containsKey("shortDescription")) {
      shortDescription = json["shortDescription"];
    }
    if (json.containsKey("supportsCreate")) {
      supportsCreate = json["supportsCreate"];
    }
    if (json.containsKey("supportsImport")) {
      supportsImport = json["supportsImport"];
    }
    if (json.containsKey("supportsMultiOpen")) {
      supportsMultiOpen = json["supportsMultiOpen"];
    }
    if (json.containsKey("useByDefault")) {
      useByDefault = json["useByDefault"];
    }
  }

  /** Create JSON Object for App */
  core.Map toJson() {
    var output = new core.Map();

    if (authorized != null) {
      output["authorized"] = authorized;
    }
    if (icons != null) {
      output["icons"] = new core.List();
      icons.forEach((item) {
        output["icons"].add(item.toJson());
      });
    }
    if (id != null) {
      output["id"] = id;
    }
    if (installed != null) {
      output["installed"] = installed;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (longDescription != null) {
      output["longDescription"] = longDescription;
    }
    if (name != null) {
      output["name"] = name;
    }
    if (objectType != null) {
      output["objectType"] = objectType;
    }
    if (openUrlTemplate != null) {
      output["openUrlTemplate"] = openUrlTemplate;
    }
    if (primaryFileExtensions != null) {
      output["primaryFileExtensions"] = new core.List();
      primaryFileExtensions.forEach((item) {
        output["primaryFileExtensions"].add(item);
      });
    }
    if (primaryMimeTypes != null) {
      output["primaryMimeTypes"] = new core.List();
      primaryMimeTypes.forEach((item) {
        output["primaryMimeTypes"].add(item);
      });
    }
    if (productId != null) {
      output["productId"] = productId;
    }
    if (productUrl != null) {
      output["productUrl"] = productUrl;
    }
    if (secondaryFileExtensions != null) {
      output["secondaryFileExtensions"] = new core.List();
      secondaryFileExtensions.forEach((item) {
        output["secondaryFileExtensions"].add(item);
      });
    }
    if (secondaryMimeTypes != null) {
      output["secondaryMimeTypes"] = new core.List();
      secondaryMimeTypes.forEach((item) {
        output["secondaryMimeTypes"].add(item);
      });
    }
    if (shortDescription != null) {
      output["shortDescription"] = shortDescription;
    }
    if (supportsCreate != null) {
      output["supportsCreate"] = supportsCreate;
    }
    if (supportsImport != null) {
      output["supportsImport"] = supportsImport;
    }
    if (supportsMultiOpen != null) {
      output["supportsMultiOpen"] = supportsMultiOpen;
    }
    if (useByDefault != null) {
      output["useByDefault"] = useByDefault;
    }

    return output;
  }

  /** Return String representation of App */
  core.String toString() => JSON.stringify(this.toJson());

}

class AppIcons {

  /** Category of the icon. Allowed values are:  
- application - icon for the application 
- document - icon for a file associated with the app 
- documentShared - icon for a shared file associated with the app */
  core.String category;

  /** URL for the icon. */
  core.String iconUrl;

  /** Size of the icon. Represented as the maximum of the width and height. */
  core.int size;

  /** Create new AppIcons from JSON data */
  AppIcons.fromJson(core.Map json) {
    if (json.containsKey("category")) {
      category = json["category"];
    }
    if (json.containsKey("iconUrl")) {
      iconUrl = json["iconUrl"];
    }
    if (json.containsKey("size")) {
      size = json["size"];
    }
  }

  /** Create JSON Object for AppIcons */
  core.Map toJson() {
    var output = new core.Map();

    if (category != null) {
      output["category"] = category;
    }
    if (iconUrl != null) {
      output["iconUrl"] = iconUrl;
    }
    if (size != null) {
      output["size"] = size;
    }

    return output;
  }

  /** Return String representation of AppIcons */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A list of third-party applications which the user has installed or given access to Google Drive. */
class AppList {

  /** The ETag of the list. */
  core.String etag;

  /** The actual list of apps. */
  core.List<App> items;

  /** This is always drive#appList. */
  core.String kind;

  /** A link back to this list. */
  core.String selfLink;

  /** Create new AppList from JSON data */
  AppList.fromJson(core.Map json) {
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new App.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for AppList */
  core.Map toJson() {
    var output = new core.Map();

    if (etag != null) {
      output["etag"] = etag;
    }
    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of AppList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** Representation of a change to a file. */
class Change {

  /** Whether the file has been deleted. */
  core.bool deleted;

  /** The updated state of the file. Present if the file has not been deleted. */
  File file;

  /** The ID of the file associated with this change. */
  core.String fileId;

  /** The ID of the change. */
  core.int id;

  /** This is always drive#change. */
  core.String kind;

  /** A link back to this change. */
  core.String selfLink;

  /** Create new Change from JSON data */
  Change.fromJson(core.Map json) {
    if (json.containsKey("deleted")) {
      deleted = json["deleted"];
    }
    if (json.containsKey("file")) {
      file = new File.fromJson(json["file"]);
    }
    if (json.containsKey("fileId")) {
      fileId = json["fileId"];
    }
    if (json.containsKey("id")) {
      if(json["id"] is core.String){
        id = core.int.parse(json["id"]);
      }else{
        id = json["id"];
      }
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for Change */
  core.Map toJson() {
    var output = new core.Map();

    if (deleted != null) {
      output["deleted"] = deleted;
    }
    if (file != null) {
      output["file"] = file.toJson();
    }
    if (fileId != null) {
      output["fileId"] = fileId;
    }
    if (id != null) {
      output["id"] = id;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of Change */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A list of changes for a user. */
class ChangeList {

  /** The ETag of the list. */
  core.String etag;

  /** The actual list of changes. */
  core.List<Change> items;

  /** This is always drive#changeList. */
  core.String kind;

  /** The current largest change ID. */
  core.int largestChangeId;

  /** A link to the next page of changes. */
  core.String nextLink;

  /** The page token for the next page of changes. */
  core.String nextPageToken;

  /** A link back to this list. */
  core.String selfLink;

  /** Create new ChangeList from JSON data */
  ChangeList.fromJson(core.Map json) {
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new Change.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("largestChangeId")) {
      if(json["largestChangeId"] is core.String){
        largestChangeId = core.int.parse(json["largestChangeId"]);
      }else{
        largestChangeId = json["largestChangeId"];
      }
    }
    if (json.containsKey("nextLink")) {
      nextLink = json["nextLink"];
    }
    if (json.containsKey("nextPageToken")) {
      nextPageToken = json["nextPageToken"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for ChangeList */
  core.Map toJson() {
    var output = new core.Map();

    if (etag != null) {
      output["etag"] = etag;
    }
    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (largestChangeId != null) {
      output["largestChangeId"] = largestChangeId;
    }
    if (nextLink != null) {
      output["nextLink"] = nextLink;
    }
    if (nextPageToken != null) {
      output["nextPageToken"] = nextPageToken;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of ChangeList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A list of children of a file. */
class ChildList {

  /** The ETag of the list. */
  core.String etag;

  /** The actual list of children. */
  core.List<ChildReference> items;

  /** This is always drive#childList. */
  core.String kind;

  /** A link to the next page of children. */
  core.String nextLink;

  /** The page token for the next page of children. */
  core.String nextPageToken;

  /** A link back to this list. */
  core.String selfLink;

  /** Create new ChildList from JSON data */
  ChildList.fromJson(core.Map json) {
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new ChildReference.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("nextLink")) {
      nextLink = json["nextLink"];
    }
    if (json.containsKey("nextPageToken")) {
      nextPageToken = json["nextPageToken"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for ChildList */
  core.Map toJson() {
    var output = new core.Map();

    if (etag != null) {
      output["etag"] = etag;
    }
    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (nextLink != null) {
      output["nextLink"] = nextLink;
    }
    if (nextPageToken != null) {
      output["nextPageToken"] = nextPageToken;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of ChildList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A reference to a folder's child. */
class ChildReference {

  /** A link to the child. */
  core.String childLink;

  /** The ID of the child. */
  core.String id;

  /** This is always drive#childReference. */
  core.String kind;

  /** A link back to this reference. */
  core.String selfLink;

  /** Create new ChildReference from JSON data */
  ChildReference.fromJson(core.Map json) {
    if (json.containsKey("childLink")) {
      childLink = json["childLink"];
    }
    if (json.containsKey("id")) {
      id = json["id"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for ChildReference */
  core.Map toJson() {
    var output = new core.Map();

    if (childLink != null) {
      output["childLink"] = childLink;
    }
    if (id != null) {
      output["id"] = id;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of ChildReference */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A JSON representation of a comment on a file in Google Drive. */
class Comment {

  /** A region of the document represented as a JSON string. See anchor documentation for details on how to define and interpret anchor properties. */
  core.String anchor;

  /** The user who wrote this comment. */
  User author;

  /** The ID of the comment. */
  core.String commentId;

  /** The plain text content used to create this comment. This is not HTML safe and should only be used as a starting point to make edits to a comment's content. */
  core.String content;

  /** The context of the file which is being commented on. */
  CommentContext context;

  /** The date when this comment was first created. */
  core.String createdDate;

  /** Whether this comment has been deleted. If a comment has been deleted the content will be cleared and this will only represent a comment that once existed. */
  core.bool deleted;

  /** The file which this comment is addressing. */
  core.String fileId;

  /** The title of the file which this comment is addressing. */
  core.String fileTitle;

  /** HTML formatted content for this comment. */
  core.String htmlContent;

  /** This is always drive#comment. */
  core.String kind;

  /** The date when this comment or any of its replies were last modified. */
  core.String modifiedDate;

  /** Replies to this post. */
  core.List<CommentReply> replies;

  /** A link back to this comment. */
  core.String selfLink;

  /** The status of this comment. Status can be changed by posting a reply to a comment with the desired status.  
- "open" - The comment is still open. 
- "resolved" - The comment has been resolved by one of its replies. */
  core.String status;

  /** Create new Comment from JSON data */
  Comment.fromJson(core.Map json) {
    if (json.containsKey("anchor")) {
      anchor = json["anchor"];
    }
    if (json.containsKey("author")) {
      author = new User.fromJson(json["author"]);
    }
    if (json.containsKey("commentId")) {
      commentId = json["commentId"];
    }
    if (json.containsKey("content")) {
      content = json["content"];
    }
    if (json.containsKey("context")) {
      context = new CommentContext.fromJson(json["context"]);
    }
    if (json.containsKey("createdDate")) {
      createdDate = json["createdDate"];
    }
    if (json.containsKey("deleted")) {
      deleted = json["deleted"];
    }
    if (json.containsKey("fileId")) {
      fileId = json["fileId"];
    }
    if (json.containsKey("fileTitle")) {
      fileTitle = json["fileTitle"];
    }
    if (json.containsKey("htmlContent")) {
      htmlContent = json["htmlContent"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("modifiedDate")) {
      modifiedDate = json["modifiedDate"];
    }
    if (json.containsKey("replies")) {
      replies = [];
      json["replies"].forEach((item) {
        replies.add(new CommentReply.fromJson(item));
      });
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
    if (json.containsKey("status")) {
      status = json["status"];
    }
  }

  /** Create JSON Object for Comment */
  core.Map toJson() {
    var output = new core.Map();

    if (anchor != null) {
      output["anchor"] = anchor;
    }
    if (author != null) {
      output["author"] = author.toJson();
    }
    if (commentId != null) {
      output["commentId"] = commentId;
    }
    if (content != null) {
      output["content"] = content;
    }
    if (context != null) {
      output["context"] = context.toJson();
    }
    if (createdDate != null) {
      output["createdDate"] = createdDate;
    }
    if (deleted != null) {
      output["deleted"] = deleted;
    }
    if (fileId != null) {
      output["fileId"] = fileId;
    }
    if (fileTitle != null) {
      output["fileTitle"] = fileTitle;
    }
    if (htmlContent != null) {
      output["htmlContent"] = htmlContent;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (modifiedDate != null) {
      output["modifiedDate"] = modifiedDate;
    }
    if (replies != null) {
      output["replies"] = new core.List();
      replies.forEach((item) {
        output["replies"].add(item.toJson());
      });
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }
    if (status != null) {
      output["status"] = status;
    }

    return output;
  }

  /** Return String representation of Comment */
  core.String toString() => JSON.stringify(this.toJson());

}

/** The context of the file which is being commented on. */
class CommentContext {

  /** The MIME type of the context snippet. */
  core.String type;

  /** Data representation of the segment of the file being commented on. In the case of a text file for example, this would be the actual text that the comment is about. */
  core.String value;

  /** Create new CommentContext from JSON data */
  CommentContext.fromJson(core.Map json) {
    if (json.containsKey("type")) {
      type = json["type"];
    }
    if (json.containsKey("value")) {
      value = json["value"];
    }
  }

  /** Create JSON Object for CommentContext */
  core.Map toJson() {
    var output = new core.Map();

    if (type != null) {
      output["type"] = type;
    }
    if (value != null) {
      output["value"] = value;
    }

    return output;
  }

  /** Return String representation of CommentContext */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A JSON representation of a list of comments on a file in Google Drive. */
class CommentList {

  /** List of comments. */
  core.List<Comment> items;

  /** This is always drive#commentList. */
  core.String kind;

  /** A link to the next page of comments. */
  core.String nextLink;

  /** The token to use to request the next page of results. */
  core.String nextPageToken;

  /** A link back to this list. */
  core.String selfLink;

  /** Create new CommentList from JSON data */
  CommentList.fromJson(core.Map json) {
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new Comment.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("nextLink")) {
      nextLink = json["nextLink"];
    }
    if (json.containsKey("nextPageToken")) {
      nextPageToken = json["nextPageToken"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for CommentList */
  core.Map toJson() {
    var output = new core.Map();

    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (nextLink != null) {
      output["nextLink"] = nextLink;
    }
    if (nextPageToken != null) {
      output["nextPageToken"] = nextPageToken;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of CommentList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A JSON representation of a reply to a comment on a file in Google Drive. */
class CommentReply {

  /** The user who wrote this reply. */
  User author;

  /** The plain text content used to create this reply. This is not HTML safe and should only be used as a starting point to make edits to a reply's content. This field is required on inserts if no verb is specified (resolve/reopen). */
  core.String content;

  /** The date when this reply was first created. */
  core.String createdDate;

  /** Whether this reply has been deleted. If a reply has been deleted the content will be cleared and this will only represent a reply that once existed. */
  core.bool deleted;

  /** HTML formatted content for this reply. */
  core.String htmlContent;

  /** This is always drive#commentReply. */
  core.String kind;

  /** The date when this reply was last modified. */
  core.String modifiedDate;

  /** The ID of the reply. */
  core.String replyId;

  /** The action this reply performed to the parent comment. When creating a new reply this is the action to be perform to the parent comment. Possible values are:  
- "resolve" - To resolve a comment. 
- "reopen" - To reopen (un-resolve) a comment. */
  core.String verb;

  /** Create new CommentReply from JSON data */
  CommentReply.fromJson(core.Map json) {
    if (json.containsKey("author")) {
      author = new User.fromJson(json["author"]);
    }
    if (json.containsKey("content")) {
      content = json["content"];
    }
    if (json.containsKey("createdDate")) {
      createdDate = json["createdDate"];
    }
    if (json.containsKey("deleted")) {
      deleted = json["deleted"];
    }
    if (json.containsKey("htmlContent")) {
      htmlContent = json["htmlContent"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("modifiedDate")) {
      modifiedDate = json["modifiedDate"];
    }
    if (json.containsKey("replyId")) {
      replyId = json["replyId"];
    }
    if (json.containsKey("verb")) {
      verb = json["verb"];
    }
  }

  /** Create JSON Object for CommentReply */
  core.Map toJson() {
    var output = new core.Map();

    if (author != null) {
      output["author"] = author.toJson();
    }
    if (content != null) {
      output["content"] = content;
    }
    if (createdDate != null) {
      output["createdDate"] = createdDate;
    }
    if (deleted != null) {
      output["deleted"] = deleted;
    }
    if (htmlContent != null) {
      output["htmlContent"] = htmlContent;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (modifiedDate != null) {
      output["modifiedDate"] = modifiedDate;
    }
    if (replyId != null) {
      output["replyId"] = replyId;
    }
    if (verb != null) {
      output["verb"] = verb;
    }

    return output;
  }

  /** Return String representation of CommentReply */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A JSON representation of a list of replies to a comment on a file in Google Drive. */
class CommentReplyList {

  /** List of reply. */
  core.List<CommentReply> items;

  /** This is always drive#commentReplyList. */
  core.String kind;

  /** A link to the next page of replies. */
  core.String nextLink;

  /** The token to use to request the next page of results. */
  core.String nextPageToken;

  /** A link back to this list. */
  core.String selfLink;

  /** Create new CommentReplyList from JSON data */
  CommentReplyList.fromJson(core.Map json) {
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new CommentReply.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("nextLink")) {
      nextLink = json["nextLink"];
    }
    if (json.containsKey("nextPageToken")) {
      nextPageToken = json["nextPageToken"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for CommentReplyList */
  core.Map toJson() {
    var output = new core.Map();

    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (nextLink != null) {
      output["nextLink"] = nextLink;
    }
    if (nextPageToken != null) {
      output["nextPageToken"] = nextPageToken;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of CommentReplyList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** The metadata for a file. */
class File {

  /** A link for opening the file in using a relevant Google editor or viewer. */
  core.String alternateLink;

  /** Whether this file is in the appdata folder. */
  core.bool appDataContents;

  /** Create time for this file (formatted ISO8601 timestamp). */
  core.String createdDate;

  /** A link to open this file with the user's default app for this file. Only populated when the drive.apps.readonly scope is used. */
  core.String defaultOpenWithLink;

  /** A short description of the file. */
  core.String description;

  /** Short lived download URL for the file. This is only populated for files with content stored in Drive. */
  core.String downloadUrl;

  /** Whether the file can be edited by the current user. */
  core.bool editable;

  /** A link for embedding the file. */
  core.String embedLink;

  /** ETag of the file. */
  core.String etag;

  /** Whether this file has been explicitly trashed, as opposed to recursively trashed. This will only be populated if the file is trashed. */
  core.bool explicitlyTrashed;

  /** Links for exporting Google Docs to specific formats. */
  FileExportLinks exportLinks;

  /** The file extension used when downloading this file. This field is read only. To set the extension, include it in the title when creating the file. This is only populated for files with content stored in Drive. */
  core.String fileExtension;

  /** The size of the file in bytes. This is only populated for files with content stored in Drive. */
  core.int fileSize;

  /** A link to the file's icon. */
  core.String iconLink;

  /** The ID of the file. */
  core.String id;

  /** Metadata about image media. This will only be present for image types, and its contents will depend on what can be parsed from the image content. */
  FileImageMediaMetadata imageMediaMetadata;

  /** Indexable text attributes for the file (can only be written) */
  FileIndexableText indexableText;

  /** The type of file. This is always drive#file. */
  core.String kind;

  /** A group of labels for the file. */
  FileLabels labels;

  /** The last user to modify this file. */
  User lastModifyingUser;

  /** Name of the last user to modify this file. */
  core.String lastModifyingUserName;

  /** Last time this file was viewed by the user (formatted RFC 3339 timestamp). */
  core.String lastViewedByMeDate;

  /** An MD5 checksum for the content of this file. This is populated only for files with content stored in Drive. */
  core.String md5Checksum;

  /** The MIME type of the file. This is only mutable on update when uploading new content. This field can be left blank, and the mimetype will be determined from the uploaded content's MIME type. */
  core.String mimeType;

  /** Last time this file was modified by the user (formatted RFC 3339 timestamp). Note that setting modifiedDate will also update the modifiedByMe date for the user which set the date. */
  core.String modifiedByMeDate;

  /** Last time this file was modified by anyone (formatted RFC 3339 timestamp). This is only mutable on update when the setModifiedDate parameter is set. */
  core.String modifiedDate;

  /** A map of the id of each of the user's apps to a link to open this file with that app. Only populated when the drive.apps.readonly scope is used. */
  FileOpenWithLinks openWithLinks;

  /** The original filename if the file was uploaded manually, or the original title if the file was inserted through the API. Note that renames of the title will not change the original filename. This will only be populated on files with content stored in Drive. */
  core.String originalFilename;

  /** Name(s) of the owner(s) of this file. */
  core.List<core.String> ownerNames;

  /** The owner(s) of this file. */
  core.List<User> owners;

  /** Collection of parent folders which contain this file.
Setting this field will put the file in all of the provided folders. On insert, if no folders are provided, the file will be placed in the default root folder. */
  core.List<ParentReference> parents;

  /** The number of quota bytes used by this file. */
  core.int quotaBytesUsed;

  /** A link back to this file. */
  core.String selfLink;

  /** Whether the file has been shared. */
  core.bool shared;

  /** Time at which this file was shared with the user (formatted RFC 3339 timestamp). */
  core.String sharedWithMeDate;

  /** Thumbnail for the file. Only accepted on upload and for files that are not already thumbnailed by Google. */
  FileThumbnail thumbnail;

  /** A link to the file's thumbnail. */
  core.String thumbnailLink;

  /** The title of this file. */
  core.String title;

  /** The permissions for the authenticated user on this file. */
  Permission userPermission;

  /** A link for downloading the content of the file in a browser using cookie based authentication. In cases where the content is shared publicly, the content can be downloaded without any credentials. */
  core.String webContentLink;

  /** A link only available on public folders for viewing their static web assets (HTML, CSS, JS, etc) via Google Drive's Website Hosting. */
  core.String webViewLink;

  /** Whether writers can share the document with other users. */
  core.bool writersCanShare;

  /** Create new File from JSON data */
  File.fromJson(core.Map json) {
    if (json.containsKey("alternateLink")) {
      alternateLink = json["alternateLink"];
    }
    if (json.containsKey("appDataContents")) {
      appDataContents = json["appDataContents"];
    }
    if (json.containsKey("createdDate")) {
      createdDate = json["createdDate"];
    }
    if (json.containsKey("defaultOpenWithLink")) {
      defaultOpenWithLink = json["defaultOpenWithLink"];
    }
    if (json.containsKey("description")) {
      description = json["description"];
    }
    if (json.containsKey("downloadUrl")) {
      downloadUrl = json["downloadUrl"];
    }
    if (json.containsKey("editable")) {
      editable = json["editable"];
    }
    if (json.containsKey("embedLink")) {
      embedLink = json["embedLink"];
    }
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("explicitlyTrashed")) {
      explicitlyTrashed = json["explicitlyTrashed"];
    }
    if (json.containsKey("exportLinks")) {
      exportLinks = new FileExportLinks.fromJson(json["exportLinks"]);
    }
    if (json.containsKey("fileExtension")) {
      fileExtension = json["fileExtension"];
    }
    if (json.containsKey("fileSize")) {
      if(json["fileSize"] is core.String){
        fileSize = core.int.parse(json["fileSize"]);
      }else{
        fileSize = json["fileSize"];
      }
    }
    if (json.containsKey("iconLink")) {
      iconLink = json["iconLink"];
    }
    if (json.containsKey("id")) {
      id = json["id"];
    }
    if (json.containsKey("imageMediaMetadata")) {
      imageMediaMetadata = new FileImageMediaMetadata.fromJson(json["imageMediaMetadata"]);
    }
    if (json.containsKey("indexableText")) {
      indexableText = new FileIndexableText.fromJson(json["indexableText"]);
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("labels")) {
      labels = new FileLabels.fromJson(json["labels"]);
    }
    if (json.containsKey("lastModifyingUser")) {
      lastModifyingUser = new User.fromJson(json["lastModifyingUser"]);
    }
    if (json.containsKey("lastModifyingUserName")) {
      lastModifyingUserName = json["lastModifyingUserName"];
    }
    if (json.containsKey("lastViewedByMeDate")) {
      lastViewedByMeDate = json["lastViewedByMeDate"];
    }
    if (json.containsKey("md5Checksum")) {
      md5Checksum = json["md5Checksum"];
    }
    if (json.containsKey("mimeType")) {
      mimeType = json["mimeType"];
    }
    if (json.containsKey("modifiedByMeDate")) {
      modifiedByMeDate = json["modifiedByMeDate"];
    }
    if (json.containsKey("modifiedDate")) {
      modifiedDate = json["modifiedDate"];
    }
    if (json.containsKey("openWithLinks")) {
      openWithLinks = new FileOpenWithLinks.fromJson(json["openWithLinks"]);
    }
    if (json.containsKey("originalFilename")) {
      originalFilename = json["originalFilename"];
    }
    if (json.containsKey("ownerNames")) {
      ownerNames = [];
      json["ownerNames"].forEach((item) {
        ownerNames.add(item);
      });
    }
    if (json.containsKey("owners")) {
      owners = [];
      json["owners"].forEach((item) {
        owners.add(new User.fromJson(item));
      });
    }
    if (json.containsKey("parents")) {
      parents = [];
      json["parents"].forEach((item) {
        parents.add(new ParentReference.fromJson(item));
      });
    }
    if (json.containsKey("quotaBytesUsed")) {
      if(json["quotaBytesUsed"] is core.String){
        quotaBytesUsed = core.int.parse(json["quotaBytesUsed"]);
      }else{
        quotaBytesUsed = json["quotaBytesUsed"];
      }
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
    if (json.containsKey("shared")) {
      shared = json["shared"];
    }
    if (json.containsKey("sharedWithMeDate")) {
      sharedWithMeDate = json["sharedWithMeDate"];
    }
    if (json.containsKey("thumbnail")) {
      thumbnail = new FileThumbnail.fromJson(json["thumbnail"]);
    }
    if (json.containsKey("thumbnailLink")) {
      thumbnailLink = json["thumbnailLink"];
    }
    if (json.containsKey("title")) {
      title = json["title"];
    }
    if (json.containsKey("userPermission")) {
      userPermission = new Permission.fromJson(json["userPermission"]);
    }
    if (json.containsKey("webContentLink")) {
      webContentLink = json["webContentLink"];
    }
    if (json.containsKey("webViewLink")) {
      webViewLink = json["webViewLink"];
    }
    if (json.containsKey("writersCanShare")) {
      writersCanShare = json["writersCanShare"];
    }
  }

  /** Create JSON Object for File */
  core.Map toJson() {
    var output = new core.Map();

    if (alternateLink != null) {
      output["alternateLink"] = alternateLink;
    }
    if (appDataContents != null) {
      output["appDataContents"] = appDataContents;
    }
    if (createdDate != null) {
      output["createdDate"] = createdDate;
    }
    if (defaultOpenWithLink != null) {
      output["defaultOpenWithLink"] = defaultOpenWithLink;
    }
    if (description != null) {
      output["description"] = description;
    }
    if (downloadUrl != null) {
      output["downloadUrl"] = downloadUrl;
    }
    if (editable != null) {
      output["editable"] = editable;
    }
    if (embedLink != null) {
      output["embedLink"] = embedLink;
    }
    if (etag != null) {
      output["etag"] = etag;
    }
    if (explicitlyTrashed != null) {
      output["explicitlyTrashed"] = explicitlyTrashed;
    }
    if (exportLinks != null) {
      output["exportLinks"] = exportLinks.toJson();
    }
    if (fileExtension != null) {
      output["fileExtension"] = fileExtension;
    }
    if (fileSize != null) {
      output["fileSize"] = fileSize;
    }
    if (iconLink != null) {
      output["iconLink"] = iconLink;
    }
    if (id != null) {
      output["id"] = id;
    }
    if (imageMediaMetadata != null) {
      output["imageMediaMetadata"] = imageMediaMetadata.toJson();
    }
    if (indexableText != null) {
      output["indexableText"] = indexableText.toJson();
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (labels != null) {
      output["labels"] = labels.toJson();
    }
    if (lastModifyingUser != null) {
      output["lastModifyingUser"] = lastModifyingUser.toJson();
    }
    if (lastModifyingUserName != null) {
      output["lastModifyingUserName"] = lastModifyingUserName;
    }
    if (lastViewedByMeDate != null) {
      output["lastViewedByMeDate"] = lastViewedByMeDate;
    }
    if (md5Checksum != null) {
      output["md5Checksum"] = md5Checksum;
    }
    if (mimeType != null) {
      output["mimeType"] = mimeType;
    }
    if (modifiedByMeDate != null) {
      output["modifiedByMeDate"] = modifiedByMeDate;
    }
    if (modifiedDate != null) {
      output["modifiedDate"] = modifiedDate;
    }
    if (openWithLinks != null) {
      output["openWithLinks"] = openWithLinks.toJson();
    }
    if (originalFilename != null) {
      output["originalFilename"] = originalFilename;
    }
    if (ownerNames != null) {
      output["ownerNames"] = new core.List();
      ownerNames.forEach((item) {
        output["ownerNames"].add(item);
      });
    }
    if (owners != null) {
      output["owners"] = new core.List();
      owners.forEach((item) {
        output["owners"].add(item.toJson());
      });
    }
    if (parents != null) {
      output["parents"] = new core.List();
      parents.forEach((item) {
        output["parents"].add(item.toJson());
      });
    }
    if (quotaBytesUsed != null) {
      output["quotaBytesUsed"] = quotaBytesUsed;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }
    if (shared != null) {
      output["shared"] = shared;
    }
    if (sharedWithMeDate != null) {
      output["sharedWithMeDate"] = sharedWithMeDate;
    }
    if (thumbnail != null) {
      output["thumbnail"] = thumbnail.toJson();
    }
    if (thumbnailLink != null) {
      output["thumbnailLink"] = thumbnailLink;
    }
    if (title != null) {
      output["title"] = title;
    }
    if (userPermission != null) {
      output["userPermission"] = userPermission.toJson();
    }
    if (webContentLink != null) {
      output["webContentLink"] = webContentLink;
    }
    if (webViewLink != null) {
      output["webViewLink"] = webViewLink;
    }
    if (writersCanShare != null) {
      output["writersCanShare"] = writersCanShare;
    }

    return output;
  }

  /** Return String representation of File */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A map of the id of each of the user's apps to a link to open this file with that app. Only populated when the drive.apps.readonly scope is used. */
class FileOpenWithLinks {

  /** Create new FileOpenWithLinks from JSON data */
  FileOpenWithLinks.fromJson(core.Map json) {
  }

  /** Create JSON Object for FileOpenWithLinks */
  core.Map toJson() {
    var output = new core.Map();


    return output;
  }

  /** Return String representation of FileOpenWithLinks */
  core.String toString() => JSON.stringify(this.toJson());

}

/** Links for exporting Google Docs to specific formats. */
class FileExportLinks {

  /** Create new FileExportLinks from JSON data */
  FileExportLinks.fromJson(core.Map json) {
  }

  /** Create JSON Object for FileExportLinks */
  core.Map toJson() {
    var output = new core.Map();


    return output;
  }

  /** Return String representation of FileExportLinks */
  core.String toString() => JSON.stringify(this.toJson());

}

/** Thumbnail for the file. Only accepted on upload and for files that are not already thumbnailed by Google. */
class FileThumbnail {

  /** The URL-safe Base64 encoded bytes of the thumbnail image. */
  core.String image;

  /** The MIME type of the thumbnail. */
  core.String mimeType;

  /** Create new FileThumbnail from JSON data */
  FileThumbnail.fromJson(core.Map json) {
    if (json.containsKey("image")) {
      image = json["image"];
    }
    if (json.containsKey("mimeType")) {
      mimeType = json["mimeType"];
    }
  }

  /** Create JSON Object for FileThumbnail */
  core.Map toJson() {
    var output = new core.Map();

    if (image != null) {
      output["image"] = image;
    }
    if (mimeType != null) {
      output["mimeType"] = mimeType;
    }

    return output;
  }

  /** Return String representation of FileThumbnail */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A group of labels for the file. */
class FileLabels {

  /** Whether this file is hidden from the user. */
  core.bool hidden;

  /** Whether viewers are prevented from downloading this file. */
  core.bool restricted;

  /** Whether this file is starred by the user. */
  core.bool starred;

  /** Whether this file has been trashed. */
  core.bool trashed;

  /** Whether this file has been viewed by this user. */
  core.bool viewed;

  /** Create new FileLabels from JSON data */
  FileLabels.fromJson(core.Map json) {
    if (json.containsKey("hidden")) {
      hidden = json["hidden"];
    }
    if (json.containsKey("restricted")) {
      restricted = json["restricted"];
    }
    if (json.containsKey("starred")) {
      starred = json["starred"];
    }
    if (json.containsKey("trashed")) {
      trashed = json["trashed"];
    }
    if (json.containsKey("viewed")) {
      viewed = json["viewed"];
    }
  }

  /** Create JSON Object for FileLabels */
  core.Map toJson() {
    var output = new core.Map();

    if (hidden != null) {
      output["hidden"] = hidden;
    }
    if (restricted != null) {
      output["restricted"] = restricted;
    }
    if (starred != null) {
      output["starred"] = starred;
    }
    if (trashed != null) {
      output["trashed"] = trashed;
    }
    if (viewed != null) {
      output["viewed"] = viewed;
    }

    return output;
  }

  /** Return String representation of FileLabels */
  core.String toString() => JSON.stringify(this.toJson());

}

/** Indexable text attributes for the file (can only be written) */
class FileIndexableText {

  /** The text to be indexed for this file. */
  core.String text;

  /** Create new FileIndexableText from JSON data */
  FileIndexableText.fromJson(core.Map json) {
    if (json.containsKey("text")) {
      text = json["text"];
    }
  }

  /** Create JSON Object for FileIndexableText */
  core.Map toJson() {
    var output = new core.Map();

    if (text != null) {
      output["text"] = text;
    }

    return output;
  }

  /** Return String representation of FileIndexableText */
  core.String toString() => JSON.stringify(this.toJson());

}

/** Metadata about image media. This will only be present for image types, and its contents will depend on what can be parsed from the image content. */
class FileImageMediaMetadata {

  /** The aperture used to create the photo (f-number). */
  core.num aperture;

  /** The make of the camera used to create the photo. */
  core.String cameraMake;

  /** The model of the camera used to create the photo. */
  core.String cameraModel;

  /** The color space of the photo. */
  core.String colorSpace;

  /** The date and time the photo was taken (EXIF format timestamp). */
  core.String date;

  /** The exposure bias of the photo (APEX value). */
  core.num exposureBias;

  /** The exposure mode used to create the photo. */
  core.String exposureMode;

  /** The length of the exposure, in seconds. */
  core.num exposureTime;

  /** Whether a flash was used to create the photo. */
  core.bool flashUsed;

  /** The focal length used to create the photo, in millimeters. */
  core.num focalLength;

  /** The height of the image in pixels. */
  core.int height;

  /** The ISO speed used to create the photo. */
  core.int isoSpeed;

  /** The lens used to create the photo. */
  core.String lens;

  /** Geographic location information stored in the image. */
  FileImageMediaMetadataLocation location;

  /** The smallest f-number of the lens at the focal length used to create the photo (APEX value). */
  core.num maxApertureValue;

  /** The metering mode used to create the photo. */
  core.String meteringMode;

  /** The rotation in clockwise degrees from the image's original orientation. */
  core.int rotation;

  /** The type of sensor used to create the photo. */
  core.String sensor;

  /** The distance to the subject of the photo, in meters. */
  core.int subjectDistance;

  /** The white balance mode used to create the photo. */
  core.String whiteBalance;

  /** The width of the image in pixels. */
  core.int width;

  /** Create new FileImageMediaMetadata from JSON data */
  FileImageMediaMetadata.fromJson(core.Map json) {
    if (json.containsKey("aperture")) {
      aperture = json["aperture"];
    }
    if (json.containsKey("cameraMake")) {
      cameraMake = json["cameraMake"];
    }
    if (json.containsKey("cameraModel")) {
      cameraModel = json["cameraModel"];
    }
    if (json.containsKey("colorSpace")) {
      colorSpace = json["colorSpace"];
    }
    if (json.containsKey("date")) {
      date = json["date"];
    }
    if (json.containsKey("exposureBias")) {
      exposureBias = json["exposureBias"];
    }
    if (json.containsKey("exposureMode")) {
      exposureMode = json["exposureMode"];
    }
    if (json.containsKey("exposureTime")) {
      exposureTime = json["exposureTime"];
    }
    if (json.containsKey("flashUsed")) {
      flashUsed = json["flashUsed"];
    }
    if (json.containsKey("focalLength")) {
      focalLength = json["focalLength"];
    }
    if (json.containsKey("height")) {
      height = json["height"];
    }
    if (json.containsKey("isoSpeed")) {
      isoSpeed = json["isoSpeed"];
    }
    if (json.containsKey("lens")) {
      lens = json["lens"];
    }
    if (json.containsKey("location")) {
      location = new FileImageMediaMetadataLocation.fromJson(json["location"]);
    }
    if (json.containsKey("maxApertureValue")) {
      maxApertureValue = json["maxApertureValue"];
    }
    if (json.containsKey("meteringMode")) {
      meteringMode = json["meteringMode"];
    }
    if (json.containsKey("rotation")) {
      rotation = json["rotation"];
    }
    if (json.containsKey("sensor")) {
      sensor = json["sensor"];
    }
    if (json.containsKey("subjectDistance")) {
      subjectDistance = json["subjectDistance"];
    }
    if (json.containsKey("whiteBalance")) {
      whiteBalance = json["whiteBalance"];
    }
    if (json.containsKey("width")) {
      width = json["width"];
    }
  }

  /** Create JSON Object for FileImageMediaMetadata */
  core.Map toJson() {
    var output = new core.Map();

    if (aperture != null) {
      output["aperture"] = aperture;
    }
    if (cameraMake != null) {
      output["cameraMake"] = cameraMake;
    }
    if (cameraModel != null) {
      output["cameraModel"] = cameraModel;
    }
    if (colorSpace != null) {
      output["colorSpace"] = colorSpace;
    }
    if (date != null) {
      output["date"] = date;
    }
    if (exposureBias != null) {
      output["exposureBias"] = exposureBias;
    }
    if (exposureMode != null) {
      output["exposureMode"] = exposureMode;
    }
    if (exposureTime != null) {
      output["exposureTime"] = exposureTime;
    }
    if (flashUsed != null) {
      output["flashUsed"] = flashUsed;
    }
    if (focalLength != null) {
      output["focalLength"] = focalLength;
    }
    if (height != null) {
      output["height"] = height;
    }
    if (isoSpeed != null) {
      output["isoSpeed"] = isoSpeed;
    }
    if (lens != null) {
      output["lens"] = lens;
    }
    if (location != null) {
      output["location"] = location.toJson();
    }
    if (maxApertureValue != null) {
      output["maxApertureValue"] = maxApertureValue;
    }
    if (meteringMode != null) {
      output["meteringMode"] = meteringMode;
    }
    if (rotation != null) {
      output["rotation"] = rotation;
    }
    if (sensor != null) {
      output["sensor"] = sensor;
    }
    if (subjectDistance != null) {
      output["subjectDistance"] = subjectDistance;
    }
    if (whiteBalance != null) {
      output["whiteBalance"] = whiteBalance;
    }
    if (width != null) {
      output["width"] = width;
    }

    return output;
  }

  /** Return String representation of FileImageMediaMetadata */
  core.String toString() => JSON.stringify(this.toJson());

}

/** Geographic location information stored in the image. */
class FileImageMediaMetadataLocation {

  /** The altitude stored in the image. */
  core.num altitude;

  /** The latitude stored in the image. */
  core.num latitude;

  /** The longitude stored in the image. */
  core.num longitude;

  /** Create new FileImageMediaMetadataLocation from JSON data */
  FileImageMediaMetadataLocation.fromJson(core.Map json) {
    if (json.containsKey("altitude")) {
      altitude = json["altitude"];
    }
    if (json.containsKey("latitude")) {
      latitude = json["latitude"];
    }
    if (json.containsKey("longitude")) {
      longitude = json["longitude"];
    }
  }

  /** Create JSON Object for FileImageMediaMetadataLocation */
  core.Map toJson() {
    var output = new core.Map();

    if (altitude != null) {
      output["altitude"] = altitude;
    }
    if (latitude != null) {
      output["latitude"] = latitude;
    }
    if (longitude != null) {
      output["longitude"] = longitude;
    }

    return output;
  }

  /** Return String representation of FileImageMediaMetadataLocation */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A list of files. */
class FileList {

  /** The ETag of the list. */
  core.String etag;

  /** The actual list of files. */
  core.List<File> items;

  /** This is always drive#fileList. */
  core.String kind;

  /** A link to the next page of files. */
  core.String nextLink;

  /** The page token for the next page of files. */
  core.String nextPageToken;

  /** A link back to this list. */
  core.String selfLink;

  /** Create new FileList from JSON data */
  FileList.fromJson(core.Map json) {
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new File.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("nextLink")) {
      nextLink = json["nextLink"];
    }
    if (json.containsKey("nextPageToken")) {
      nextPageToken = json["nextPageToken"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for FileList */
  core.Map toJson() {
    var output = new core.Map();

    if (etag != null) {
      output["etag"] = etag;
    }
    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (nextLink != null) {
      output["nextLink"] = nextLink;
    }
    if (nextPageToken != null) {
      output["nextPageToken"] = nextPageToken;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of FileList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A list of a file's parents. */
class ParentList {

  /** The ETag of the list. */
  core.String etag;

  /** The actual list of parents. */
  core.List<ParentReference> items;

  /** This is always drive#parentList. */
  core.String kind;

  /** A link back to this list. */
  core.String selfLink;

  /** Create new ParentList from JSON data */
  ParentList.fromJson(core.Map json) {
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new ParentReference.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for ParentList */
  core.Map toJson() {
    var output = new core.Map();

    if (etag != null) {
      output["etag"] = etag;
    }
    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of ParentList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A reference to a file's parent. */
class ParentReference {

  /** The ID of the parent. */
  core.String id;

  /** Whether or not the parent is the root folder. */
  core.bool isRoot;

  /** This is always drive#parentReference. */
  core.String kind;

  /** A link to the parent. */
  core.String parentLink;

  /** A link back to this reference. */
  core.String selfLink;

  /** Create new ParentReference from JSON data */
  ParentReference.fromJson(core.Map json) {
    if (json.containsKey("id")) {
      id = json["id"];
    }
    if (json.containsKey("isRoot")) {
      isRoot = json["isRoot"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("parentLink")) {
      parentLink = json["parentLink"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for ParentReference */
  core.Map toJson() {
    var output = new core.Map();

    if (id != null) {
      output["id"] = id;
    }
    if (isRoot != null) {
      output["isRoot"] = isRoot;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (parentLink != null) {
      output["parentLink"] = parentLink;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of ParentReference */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A permission for a file. */
class Permission {

  /** Additional roles for this user. Only commenter is currently allowed. */
  core.List<core.String> additionalRoles;

  /** The authkey parameter required for this permission. */
  core.String authKey;

  /** The ETag of the permission. */
  core.String etag;

  /** The ID of the permission. */
  core.String id;

  /** This is always drive#permission. */
  core.String kind;

  /** The name for this permission. */
  core.String name;

  /** A link to the profile photo, if available. */
  core.String photoLink;

  /** The primary role for this user. Allowed values are:  
- owner 
- reader 
- writer */
  core.String role;

  /** A link back to this permission. */
  core.String selfLink;

  /** The account type. Allowed values are:  
- user 
- group 
- domain 
- anyone */
  core.String type;

  /** The email address or domain name for the entity. This is not populated in responses. */
  core.String value;

  /** Whether the link is required for this permission. */
  core.bool withLink;

  /** Create new Permission from JSON data */
  Permission.fromJson(core.Map json) {
    if (json.containsKey("additionalRoles")) {
      additionalRoles = [];
      json["additionalRoles"].forEach((item) {
        additionalRoles.add(item);
      });
    }
    if (json.containsKey("authKey")) {
      authKey = json["authKey"];
    }
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("id")) {
      id = json["id"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("name")) {
      name = json["name"];
    }
    if (json.containsKey("photoLink")) {
      photoLink = json["photoLink"];
    }
    if (json.containsKey("role")) {
      role = json["role"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
    if (json.containsKey("type")) {
      type = json["type"];
    }
    if (json.containsKey("value")) {
      value = json["value"];
    }
    if (json.containsKey("withLink")) {
      withLink = json["withLink"];
    }
  }

  /** Create JSON Object for Permission */
  core.Map toJson() {
    var output = new core.Map();

    if (additionalRoles != null) {
      output["additionalRoles"] = new core.List();
      additionalRoles.forEach((item) {
        output["additionalRoles"].add(item);
      });
    }
    if (authKey != null) {
      output["authKey"] = authKey;
    }
    if (etag != null) {
      output["etag"] = etag;
    }
    if (id != null) {
      output["id"] = id;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (name != null) {
      output["name"] = name;
    }
    if (photoLink != null) {
      output["photoLink"] = photoLink;
    }
    if (role != null) {
      output["role"] = role;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }
    if (type != null) {
      output["type"] = type;
    }
    if (value != null) {
      output["value"] = value;
    }
    if (withLink != null) {
      output["withLink"] = withLink;
    }

    return output;
  }

  /** Return String representation of Permission */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A list of permissions associated with a file. */
class PermissionList {

  /** The ETag of the list. */
  core.String etag;

  /** The actual list of permissions. */
  core.List<Permission> items;

  /** This is always drive#permissionList. */
  core.String kind;

  /** A link back to this list. */
  core.String selfLink;

  /** Create new PermissionList from JSON data */
  PermissionList.fromJson(core.Map json) {
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new Permission.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for PermissionList */
  core.Map toJson() {
    var output = new core.Map();

    if (etag != null) {
      output["etag"] = etag;
    }
    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of PermissionList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A key-value pair that is either public or private to an application. */
class Property {

  /** ETag of the property. */
  core.String etag;

  /** The key of this property. */
  core.String key;

  /** This is always drive#property. */
  core.String kind;

  /** The link back to this property. */
  core.String selfLink;

  /** The value of this property. */
  core.String value;

  /** The visibility of this property. */
  core.String visibility;

  /** Create new Property from JSON data */
  Property.fromJson(core.Map json) {
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("key")) {
      key = json["key"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
    if (json.containsKey("value")) {
      value = json["value"];
    }
    if (json.containsKey("visibility")) {
      visibility = json["visibility"];
    }
  }

  /** Create JSON Object for Property */
  core.Map toJson() {
    var output = new core.Map();

    if (etag != null) {
      output["etag"] = etag;
    }
    if (key != null) {
      output["key"] = key;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }
    if (value != null) {
      output["value"] = value;
    }
    if (visibility != null) {
      output["visibility"] = visibility;
    }

    return output;
  }

  /** Return String representation of Property */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A collection of properties, key-value pairs that are either public or private to an application. */
class PropertyList {

  /** The ETag of the list. */
  core.String etag;

  /** The list of properties. */
  core.List<Property> items;

  /** This is always drive#propertyList. */
  core.String kind;

  /** The link back to this list. */
  core.String selfLink;

  /** Create new PropertyList from JSON data */
  PropertyList.fromJson(core.Map json) {
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new Property.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for PropertyList */
  core.Map toJson() {
    var output = new core.Map();

    if (etag != null) {
      output["etag"] = etag;
    }
    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of PropertyList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A revision of a file. */
class Revision {

  /** Short term download URL for the file. This will only be populated on files with content stored in Drive. */
  core.String downloadUrl;

  /** The ETag of the revision. */
  core.String etag;

  /** Links for exporting Google Docs to specific formats. */
  RevisionExportLinks exportLinks;

  /** The size of the revision in bytes. This will only be populated on files with content stored in Drive. */
  core.int fileSize;

  /** The ID of the revision. */
  core.String id;

  /** This is always drive#revision. */
  core.String kind;

  /** The last user to modify this revision. */
  User lastModifyingUser;

  /** Name of the last user to modify this revision. */
  core.String lastModifyingUserName;

  /** An MD5 checksum for the content of this revision. This will only be populated on files with content stored in Drive. */
  core.String md5Checksum;

  /** The MIME type of the revision. */
  core.String mimeType;

  /** Last time this revision was modified (formatted RFC 3339 timestamp). */
  core.String modifiedDate;

  /** The original filename when this revision was created. This will only be populated on files with content stored in Drive. */
  core.String originalFilename;

  /** Whether this revision is pinned to prevent automatic purging. This will only be populated and can only be modified on files with content stored in Drive which are not Google Docs. Revisions can also be pinned when they are created through the drive.files.insert/update/copy by using the pinned query parameter. */
  core.bool pinned;

  /** Whether subsequent revisions will be automatically republished. This is only populated and can only be modified for Google Docs. */
  core.bool publishAuto;

  /** Whether this revision is published. This is only populated and can only be modified for Google Docs. */
  core.bool published;

  /** A link to the published revision. */
  core.String publishedLink;

  /** Whether this revision is published outside the domain. This is only populated and can only be modified for Google Docs. */
  core.bool publishedOutsideDomain;

  /** A link back to this revision. */
  core.String selfLink;

  /** Create new Revision from JSON data */
  Revision.fromJson(core.Map json) {
    if (json.containsKey("downloadUrl")) {
      downloadUrl = json["downloadUrl"];
    }
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("exportLinks")) {
      exportLinks = new RevisionExportLinks.fromJson(json["exportLinks"]);
    }
    if (json.containsKey("fileSize")) {
      if(json["fileSize"] is core.String){
        fileSize = core.int.parse(json["fileSize"]);
      }else{
        fileSize = json["fileSize"];
      }
    }
    if (json.containsKey("id")) {
      id = json["id"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("lastModifyingUser")) {
      lastModifyingUser = new User.fromJson(json["lastModifyingUser"]);
    }
    if (json.containsKey("lastModifyingUserName")) {
      lastModifyingUserName = json["lastModifyingUserName"];
    }
    if (json.containsKey("md5Checksum")) {
      md5Checksum = json["md5Checksum"];
    }
    if (json.containsKey("mimeType")) {
      mimeType = json["mimeType"];
    }
    if (json.containsKey("modifiedDate")) {
      modifiedDate = json["modifiedDate"];
    }
    if (json.containsKey("originalFilename")) {
      originalFilename = json["originalFilename"];
    }
    if (json.containsKey("pinned")) {
      pinned = json["pinned"];
    }
    if (json.containsKey("publishAuto")) {
      publishAuto = json["publishAuto"];
    }
    if (json.containsKey("published")) {
      published = json["published"];
    }
    if (json.containsKey("publishedLink")) {
      publishedLink = json["publishedLink"];
    }
    if (json.containsKey("publishedOutsideDomain")) {
      publishedOutsideDomain = json["publishedOutsideDomain"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for Revision */
  core.Map toJson() {
    var output = new core.Map();

    if (downloadUrl != null) {
      output["downloadUrl"] = downloadUrl;
    }
    if (etag != null) {
      output["etag"] = etag;
    }
    if (exportLinks != null) {
      output["exportLinks"] = exportLinks.toJson();
    }
    if (fileSize != null) {
      output["fileSize"] = fileSize;
    }
    if (id != null) {
      output["id"] = id;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (lastModifyingUser != null) {
      output["lastModifyingUser"] = lastModifyingUser.toJson();
    }
    if (lastModifyingUserName != null) {
      output["lastModifyingUserName"] = lastModifyingUserName;
    }
    if (md5Checksum != null) {
      output["md5Checksum"] = md5Checksum;
    }
    if (mimeType != null) {
      output["mimeType"] = mimeType;
    }
    if (modifiedDate != null) {
      output["modifiedDate"] = modifiedDate;
    }
    if (originalFilename != null) {
      output["originalFilename"] = originalFilename;
    }
    if (pinned != null) {
      output["pinned"] = pinned;
    }
    if (publishAuto != null) {
      output["publishAuto"] = publishAuto;
    }
    if (published != null) {
      output["published"] = published;
    }
    if (publishedLink != null) {
      output["publishedLink"] = publishedLink;
    }
    if (publishedOutsideDomain != null) {
      output["publishedOutsideDomain"] = publishedOutsideDomain;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of Revision */
  core.String toString() => JSON.stringify(this.toJson());

}

/** Links for exporting Google Docs to specific formats. */
class RevisionExportLinks {

  /** Create new RevisionExportLinks from JSON data */
  RevisionExportLinks.fromJson(core.Map json) {
  }

  /** Create JSON Object for RevisionExportLinks */
  core.Map toJson() {
    var output = new core.Map();


    return output;
  }

  /** Return String representation of RevisionExportLinks */
  core.String toString() => JSON.stringify(this.toJson());

}

/** A list of revisions of a file. */
class RevisionList {

  /** The ETag of the list. */
  core.String etag;

  /** The actual list of revisions. */
  core.List<Revision> items;

  /** This is always drive#revisionList. */
  core.String kind;

  /** A link back to this list. */
  core.String selfLink;

  /** Create new RevisionList from JSON data */
  RevisionList.fromJson(core.Map json) {
    if (json.containsKey("etag")) {
      etag = json["etag"];
    }
    if (json.containsKey("items")) {
      items = [];
      json["items"].forEach((item) {
        items.add(new Revision.fromJson(item));
      });
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("selfLink")) {
      selfLink = json["selfLink"];
    }
  }

  /** Create JSON Object for RevisionList */
  core.Map toJson() {
    var output = new core.Map();

    if (etag != null) {
      output["etag"] = etag;
    }
    if (items != null) {
      output["items"] = new core.List();
      items.forEach((item) {
        output["items"].add(item.toJson());
      });
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (selfLink != null) {
      output["selfLink"] = selfLink;
    }

    return output;
  }

  /** Return String representation of RevisionList */
  core.String toString() => JSON.stringify(this.toJson());

}

/** The JSON template for a user. */
class User {

  /** A plain text displayable name for this user. */
  core.String displayName;

  /** Whether this user is the same as the authenticated user for whom the request was made. */
  core.bool isAuthenticatedUser;

  /** This is always drive#user. */
  core.String kind;

  /** The user's ID as visible in the permissions collection. */
  core.String permissionId;

  /** The user's profile picture. */
  UserPicture picture;

  /** Create new User from JSON data */
  User.fromJson(core.Map json) {
    if (json.containsKey("displayName")) {
      displayName = json["displayName"];
    }
    if (json.containsKey("isAuthenticatedUser")) {
      isAuthenticatedUser = json["isAuthenticatedUser"];
    }
    if (json.containsKey("kind")) {
      kind = json["kind"];
    }
    if (json.containsKey("permissionId")) {
      permissionId = json["permissionId"];
    }
    if (json.containsKey("picture")) {
      picture = new UserPicture.fromJson(json["picture"]);
    }
  }

  /** Create JSON Object for User */
  core.Map toJson() {
    var output = new core.Map();

    if (displayName != null) {
      output["displayName"] = displayName;
    }
    if (isAuthenticatedUser != null) {
      output["isAuthenticatedUser"] = isAuthenticatedUser;
    }
    if (kind != null) {
      output["kind"] = kind;
    }
    if (permissionId != null) {
      output["permissionId"] = permissionId;
    }
    if (picture != null) {
      output["picture"] = picture.toJson();
    }

    return output;
  }

  /** Return String representation of User */
  core.String toString() => JSON.stringify(this.toJson());

}

/** The user's profile picture. */
class UserPicture {

  /** A URL that points to a profile picture of this user. */
  core.String url;

  /** Create new UserPicture from JSON data */
  UserPicture.fromJson(core.Map json) {
    if (json.containsKey("url")) {
      url = json["url"];
    }
  }

  /** Create JSON Object for UserPicture */
  core.Map toJson() {
    var output = new core.Map();

    if (url != null) {
      output["url"] = url;
    }

    return output;
  }

  /** Return String representation of UserPicture */
  core.String toString() => JSON.stringify(this.toJson());

}

