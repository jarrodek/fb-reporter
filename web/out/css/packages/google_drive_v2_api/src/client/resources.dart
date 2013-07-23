part of drive_v2_api_client;

class AboutResource_ extends Resource {

  AboutResource_(Client client) : super(client) {
  }

  /**
   * Gets the information about the current user along with Drive API settings
   *
   * [includeSubscribed] - When calculating the number of remaining change IDs, whether to include shared files and public files the user has opened. When set to false, this counts only change IDs for owned files and any shared or public files that the user has explictly added to a folder in Drive.
   *   Default: true
   *
   * [maxChangeIdCount] - Maximum number of remaining change IDs to count
   *   Default: 1
   *
   * [startChangeId] - Change ID to start counting from when calculating number of remaining change IDs
   *
   * [optParams] - Additional query parameters
   */
  async.Future<About> get({core.bool includeSubscribed, core.int maxChangeIdCount, core.int startChangeId, core.Map optParams}) {
    var url = "about";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (includeSubscribed != null) queryParams["includeSubscribed"] = includeSubscribed;
    if (maxChangeIdCount != null) queryParams["maxChangeIdCount"] = maxChangeIdCount;
    if (startChangeId != null) queryParams["startChangeId"] = startChangeId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new About.fromJson(data));
  }
}

class AppsResource_ extends Resource {

  AppsResource_(Client client) : super(client) {
  }

  /**
   * Gets a specific app.
   *
   * [appId] - The ID of the app.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<App> get(core.String appId, {core.Map optParams}) {
    var url = "apps/{appId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (appId == null) paramErrors.add("appId is required");
    if (appId != null) urlParams["appId"] = appId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new App.fromJson(data));
  }

  /**
   * Lists a user's installed apps.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<AppList> list({core.Map optParams}) {
    var url = "apps";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new AppList.fromJson(data));
  }
}

class ChangesResource_ extends Resource {

  ChangesResource_(Client client) : super(client) {
  }

  /**
   * Gets a specific change.
   *
   * [changeId] - The ID of the change.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Change> get(core.String changeId, {core.Map optParams}) {
    var url = "changes/{changeId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (changeId == null) paramErrors.add("changeId is required");
    if (changeId != null) urlParams["changeId"] = changeId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Change.fromJson(data));
  }

  /**
   * Lists the changes for a user.
   *
   * [includeDeleted] - Whether to include deleted items.
   *   Default: true
   *
   * [includeSubscribed] - Whether to include shared files and public files the user has opened. When set to false, the list will include owned files plus any shared or public files the user has explictly added to a folder in Drive.
   *   Default: true
   *
   * [maxResults] - Maximum number of changes to return.
   *   Default: 100
   *   Minimum: 0
   *
   * [pageToken] - Page token for changes.
   *
   * [startChangeId] - Change ID to start listing changes from.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<ChangeList> list({core.bool includeDeleted, core.bool includeSubscribed, core.int maxResults, core.String pageToken, core.int startChangeId, core.Map optParams}) {
    var url = "changes";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (includeDeleted != null) queryParams["includeDeleted"] = includeDeleted;
    if (includeSubscribed != null) queryParams["includeSubscribed"] = includeSubscribed;
    if (maxResults != null) queryParams["maxResults"] = maxResults;
    if (pageToken != null) queryParams["pageToken"] = pageToken;
    if (startChangeId != null) queryParams["startChangeId"] = startChangeId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new ChangeList.fromJson(data));
  }
}

class ChildrenResource_ extends Resource {

  ChildrenResource_(Client client) : super(client) {
  }

  /**
   * Removes a child from a folder.
   *
   * [folderId] - The ID of the folder.
   *
   * [childId] - The ID of the child.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<core.Map> delete(core.String folderId, core.String childId, {core.Map optParams}) {
    var url = "files/{folderId}/children/{childId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (childId == null) paramErrors.add("childId is required");
    if (childId != null) urlParams["childId"] = childId;
    if (folderId == null) paramErrors.add("folderId is required");
    if (folderId != null) urlParams["folderId"] = folderId;
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
    response = _client.request(url, "DELETE", urlParams: urlParams, queryParams: queryParams);
    return response;
  }

  /**
   * Gets a specific child reference.
   *
   * [folderId] - The ID of the folder.
   *
   * [childId] - The ID of the child.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<ChildReference> get(core.String folderId, core.String childId, {core.Map optParams}) {
    var url = "files/{folderId}/children/{childId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (childId == null) paramErrors.add("childId is required");
    if (childId != null) urlParams["childId"] = childId;
    if (folderId == null) paramErrors.add("folderId is required");
    if (folderId != null) urlParams["folderId"] = folderId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new ChildReference.fromJson(data));
  }

  /**
   * Inserts a file into a folder.
   *
   * [request] - ChildReference to send in this request
   *
   * [folderId] - The ID of the folder.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<ChildReference> insert(ChildReference request, core.String folderId, {core.Map optParams}) {
    var url = "files/{folderId}/children";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (folderId == null) paramErrors.add("folderId is required");
    if (folderId != null) urlParams["folderId"] = folderId;
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
    response = _client.request(url, "POST", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new ChildReference.fromJson(data));
  }

  /**
   * Lists a folder's children.
   *
   * [folderId] - The ID of the folder.
   *
   * [maxResults] - Maximum number of children to return.
   *   Default: 100
   *   Minimum: 0
   *
   * [pageToken] - Page token for children.
   *
   * [q] - Query string for searching children.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<ChildList> list(core.String folderId, {core.int maxResults, core.String pageToken, core.String q, core.Map optParams}) {
    var url = "files/{folderId}/children";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (folderId == null) paramErrors.add("folderId is required");
    if (folderId != null) urlParams["folderId"] = folderId;
    if (maxResults != null) queryParams["maxResults"] = maxResults;
    if (pageToken != null) queryParams["pageToken"] = pageToken;
    if (q != null) queryParams["q"] = q;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new ChildList.fromJson(data));
  }
}

class CommentsResource_ extends Resource {

  CommentsResource_(Client client) : super(client) {
  }

  /**
   * Deletes a comment.
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<core.Map> delete(core.String fileId, core.String commentId, {core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "DELETE", urlParams: urlParams, queryParams: queryParams);
    return response;
  }

  /**
   * Gets a comment by ID.
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [includeDeleted] - If set, this will succeed when retrieving a deleted comment, and will include any deleted replies.
   *   Default: false
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Comment> get(core.String fileId, core.String commentId, {core.bool includeDeleted, core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (includeDeleted != null) queryParams["includeDeleted"] = includeDeleted;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Comment.fromJson(data));
  }

  /**
   * Creates a new comment on the given file.
   *
   * [request] - Comment to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Comment> insert(Comment request, core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/comments";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "POST", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Comment.fromJson(data));
  }

  /**
   * Lists a file's comments.
   *
   * [fileId] - The ID of the file.
   *
   * [includeDeleted] - If set, all comments and replies, including deleted comments and replies (with content stripped) will be returned.
   *   Default: false
   *
   * [maxResults] - The maximum number of discussions to include in the response, used for paging.
   *   Default: 20
   *   Minimum: 0
   *   Maximum: 100
   *
   * [pageToken] - The continuation token, used to page through large result sets. To get the next page of results, set this parameter to the value of "nextPageToken" from the previous response.
   *
   * [updatedMin] - Only discussions that were updated after this timestamp will be returned. Formatted as an RFC 3339 timestamp.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<CommentList> list(core.String fileId, {core.bool includeDeleted, core.int maxResults, core.String pageToken, core.String updatedMin, core.Map optParams}) {
    var url = "files/{fileId}/comments";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (includeDeleted != null) queryParams["includeDeleted"] = includeDeleted;
    if (maxResults != null) queryParams["maxResults"] = maxResults;
    if (pageToken != null) queryParams["pageToken"] = pageToken;
    if (updatedMin != null) queryParams["updatedMin"] = updatedMin;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new CommentList.fromJson(data));
  }

  /**
   * Updates an existing comment. This method supports patch semantics.
   *
   * [request] - Comment to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Comment> patch(Comment request, core.String fileId, core.String commentId, {core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "PATCH", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Comment.fromJson(data));
  }

  /**
   * Updates an existing comment.
   *
   * [request] - Comment to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Comment> update(Comment request, core.String fileId, core.String commentId, {core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "PUT", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Comment.fromJson(data));
  }
}

class FilesResource_ extends Resource {

  FilesResource_(Client client) : super(client) {
  }

  /**
   * Creates a copy of the specified file.
   *
   * [request] - File to send in this request
   *
   * [fileId] - The ID of the file to copy.
   *
   * [convert] - Whether to convert this file to the corresponding Google Docs format.
   *   Default: false
   *
   * [ocr] - Whether to attempt OCR on .jpg, .png, .gif, or .pdf uploads.
   *   Default: false
   *
   * [ocrLanguage] - If ocr is true, hints at the language to use. Valid values are ISO 639-1 codes.
   *
   * [pinned] - Whether to pin the head revision of the new copy.
   *   Default: false
   *
   * [timedTextLanguage] - The language of the timed text.
   *
   * [timedTextTrackName] - The timed text track name.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<File> copy(File request, core.String fileId, {core.bool convert, core.bool ocr, core.String ocrLanguage, core.bool pinned, core.String timedTextLanguage, core.String timedTextTrackName, core.Map optParams}) {
    var url = "files/{fileId}/copy";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (convert != null) queryParams["convert"] = convert;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (ocr != null) queryParams["ocr"] = ocr;
    if (ocrLanguage != null) queryParams["ocrLanguage"] = ocrLanguage;
    if (pinned != null) queryParams["pinned"] = pinned;
    if (timedTextLanguage != null) queryParams["timedTextLanguage"] = timedTextLanguage;
    if (timedTextTrackName != null) queryParams["timedTextTrackName"] = timedTextTrackName;
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
    response = _client.request(url, "POST", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new File.fromJson(data));
  }

  /**
   * Permanently deletes a file by ID. Skips the trash.
   *
   * [fileId] - The ID of the file to delete.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<core.Map> delete(core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "DELETE", urlParams: urlParams, queryParams: queryParams);
    return response;
  }

  /**
   * Gets a file's metadata by ID.
   *
   * [fileId] - The ID for the file in question.
   *
   * [projection] - This parameter is deprecated and has no function.
   *   Allowed values:
   *     BASIC - Deprecated
   *     FULL - Deprecated
   *
   * [updateViewedDate] - Whether to update the view date after successfully retrieving the file.
   *   Default: false
   *
   * [optParams] - Additional query parameters
   */
  async.Future<File> get(core.String fileId, {core.String projection, core.bool updateViewedDate, core.Map optParams}) {
    var url = "files/{fileId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (projection != null && !["BASIC", "FULL"].contains(projection)) {
      paramErrors.add("Allowed values for projection: BASIC, FULL");
    }
    if (projection != null) queryParams["projection"] = projection;
    if (updateViewedDate != null) queryParams["updateViewedDate"] = updateViewedDate;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new File.fromJson(data));
  }

  /**
   * Insert a new file.
   *
   * [request] - File to send in this request
   *
   * [content] - Base64 Data of the file content to be uploaded
   *
   * [contentType] - MimeType of the file to be uploaded
   *
   * [convert] - Whether to convert this file to the corresponding Google Docs format.
   *   Default: false
   *
   * [ocr] - Whether to attempt OCR on .jpg, .png, .gif, or .pdf uploads.
   *   Default: false
   *
   * [ocrLanguage] - If ocr is true, hints at the language to use. Valid values are ISO 639-1 codes.
   *
   * [pinned] - Whether to pin the head revision of the uploaded file.
   *   Default: false
   *
   * [timedTextLanguage] - The language of the timed text.
   *
   * [timedTextTrackName] - The timed text track name.
   *
   * [useContentAsIndexableText] - Whether to use the content as indexable text.
   *   Default: false
   *
   * [optParams] - Additional query parameters
   */
  async.Future<File> insert(File request, {core.String content, core.String contentType, core.bool convert, core.bool ocr, core.String ocrLanguage, core.bool pinned, core.String timedTextLanguage, core.String timedTextTrackName, core.bool useContentAsIndexableText, core.Map optParams}) {
    var url = "files";
    var uploadUrl = "/upload/drive/v2/files";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (convert != null) queryParams["convert"] = convert;
    if (ocr != null) queryParams["ocr"] = ocr;
    if (ocrLanguage != null) queryParams["ocrLanguage"] = ocrLanguage;
    if (pinned != null) queryParams["pinned"] = pinned;
    if (timedTextLanguage != null) queryParams["timedTextLanguage"] = timedTextLanguage;
    if (timedTextTrackName != null) queryParams["timedTextTrackName"] = timedTextTrackName;
    if (useContentAsIndexableText != null) queryParams["useContentAsIndexableText"] = useContentAsIndexableText;
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
    if (content != null) {
      response = _client.upload(uploadUrl, "POST", request.toString(), content, contentType, urlParams: urlParams, queryParams: queryParams);
    } else {
      response = _client.request(url, "POST", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    }
    return response
      .then((data) => new File.fromJson(data));
  }

  /**
   * Lists the user's files.
   *
   * [maxResults] - Maximum number of files to return.
   *   Default: 100
   *   Minimum: 0
   *
   * [pageToken] - Page token for files.
   *
   * [projection] - This parameter is deprecated and has no function.
   *   Allowed values:
   *     BASIC - Deprecated
   *     FULL - Deprecated
   *
   * [q] - Query string for searching files.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<FileList> list({core.int maxResults, core.String pageToken, core.String projection, core.String q, core.Map optParams}) {
    var url = "files";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (maxResults != null) queryParams["maxResults"] = maxResults;
    if (pageToken != null) queryParams["pageToken"] = pageToken;
    if (projection != null && !["BASIC", "FULL"].contains(projection)) {
      paramErrors.add("Allowed values for projection: BASIC, FULL");
    }
    if (projection != null) queryParams["projection"] = projection;
    if (q != null) queryParams["q"] = q;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new FileList.fromJson(data));
  }

  /**
   * Updates file metadata and/or content. This method supports patch semantics.
   *
   * [request] - File to send in this request
   *
   * [fileId] - The ID of the file to update.
   *
   * [convert] - Whether to convert this file to the corresponding Google Docs format.
   *   Default: false
   *
   * [newRevision] - Whether a blob upload should create a new revision. If not set or false, the blob data in the current head revision is replaced. If true, a new blob is created as head revision, and previous revisions are preserved (causing increased use of the user's data storage quota).
   *   Default: true
   *
   * [ocr] - Whether to attempt OCR on .jpg, .png, .gif, or .pdf uploads.
   *   Default: false
   *
   * [ocrLanguage] - If ocr is true, hints at the language to use. Valid values are ISO 639-1 codes.
   *
   * [pinned] - Whether to pin the new revision.
   *   Default: false
   *
   * [setModifiedDate] - Whether to set the modified date with the supplied modified date.
   *   Default: false
   *
   * [timedTextLanguage] - The language of the timed text.
   *
   * [timedTextTrackName] - The timed text track name.
   *
   * [updateViewedDate] - Whether to update the view date after successfully updating the file.
   *   Default: true
   *
   * [useContentAsIndexableText] - Whether to use the content as indexable text.
   *   Default: false
   *
   * [optParams] - Additional query parameters
   */
  async.Future<File> patch(File request, core.String fileId, {core.bool convert, core.bool newRevision, core.bool ocr, core.String ocrLanguage, core.bool pinned, core.bool setModifiedDate, core.String timedTextLanguage, core.String timedTextTrackName, core.bool updateViewedDate, core.bool useContentAsIndexableText, core.Map optParams}) {
    var url = "files/{fileId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (convert != null) queryParams["convert"] = convert;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (newRevision != null) queryParams["newRevision"] = newRevision;
    if (ocr != null) queryParams["ocr"] = ocr;
    if (ocrLanguage != null) queryParams["ocrLanguage"] = ocrLanguage;
    if (pinned != null) queryParams["pinned"] = pinned;
    if (setModifiedDate != null) queryParams["setModifiedDate"] = setModifiedDate;
    if (timedTextLanguage != null) queryParams["timedTextLanguage"] = timedTextLanguage;
    if (timedTextTrackName != null) queryParams["timedTextTrackName"] = timedTextTrackName;
    if (updateViewedDate != null) queryParams["updateViewedDate"] = updateViewedDate;
    if (useContentAsIndexableText != null) queryParams["useContentAsIndexableText"] = useContentAsIndexableText;
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
    response = _client.request(url, "PATCH", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new File.fromJson(data));
  }

  /**
   * Set the file's updated time to the current server time.
   *
   * [fileId] - The ID of the file to update.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<File> touch(core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/touch";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "POST", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new File.fromJson(data));
  }

  /**
   * Moves a file to the trash.
   *
   * [fileId] - The ID of the file to trash.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<File> trash(core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/trash";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "POST", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new File.fromJson(data));
  }

  /**
   * Restores a file from the trash.
   *
   * [fileId] - The ID of the file to untrash.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<File> untrash(core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/untrash";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "POST", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new File.fromJson(data));
  }

  /**
   * Updates file metadata and/or content.
   *
   * [request] - File to send in this request
   *
   * [fileId] - The ID of the file to update.
   *
   * [content] - Base64 Data of the file content to be uploaded
   *
   * [contentType] - MimeType of the file to be uploaded
   *
   * [convert] - Whether to convert this file to the corresponding Google Docs format.
   *   Default: false
   *
   * [newRevision] - Whether a blob upload should create a new revision. If not set or false, the blob data in the current head revision is replaced. If true, a new blob is created as head revision, and previous revisions are preserved (causing increased use of the user's data storage quota).
   *   Default: true
   *
   * [ocr] - Whether to attempt OCR on .jpg, .png, .gif, or .pdf uploads.
   *   Default: false
   *
   * [ocrLanguage] - If ocr is true, hints at the language to use. Valid values are ISO 639-1 codes.
   *
   * [pinned] - Whether to pin the new revision.
   *   Default: false
   *
   * [setModifiedDate] - Whether to set the modified date with the supplied modified date.
   *   Default: false
   *
   * [timedTextLanguage] - The language of the timed text.
   *
   * [timedTextTrackName] - The timed text track name.
   *
   * [updateViewedDate] - Whether to update the view date after successfully updating the file.
   *   Default: true
   *
   * [useContentAsIndexableText] - Whether to use the content as indexable text.
   *   Default: false
   *
   * [optParams] - Additional query parameters
   */
  async.Future<File> update(File request, core.String fileId, {core.String content, core.String contentType, core.bool convert, core.bool newRevision, core.bool ocr, core.String ocrLanguage, core.bool pinned, core.bool setModifiedDate, core.String timedTextLanguage, core.String timedTextTrackName, core.bool updateViewedDate, core.bool useContentAsIndexableText, core.Map optParams}) {
    var url = "files/{fileId}";
    var uploadUrl = "/upload/drive/v2/files/{fileId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (convert != null) queryParams["convert"] = convert;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (newRevision != null) queryParams["newRevision"] = newRevision;
    if (ocr != null) queryParams["ocr"] = ocr;
    if (ocrLanguage != null) queryParams["ocrLanguage"] = ocrLanguage;
    if (pinned != null) queryParams["pinned"] = pinned;
    if (setModifiedDate != null) queryParams["setModifiedDate"] = setModifiedDate;
    if (timedTextLanguage != null) queryParams["timedTextLanguage"] = timedTextLanguage;
    if (timedTextTrackName != null) queryParams["timedTextTrackName"] = timedTextTrackName;
    if (updateViewedDate != null) queryParams["updateViewedDate"] = updateViewedDate;
    if (useContentAsIndexableText != null) queryParams["useContentAsIndexableText"] = useContentAsIndexableText;
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
    if (content != null) {
      response = _client.upload(uploadUrl, "PUT", request.toString(), content, contentType, urlParams: urlParams, queryParams: queryParams);
    } else {
      response = _client.request(url, "PUT", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    }
    return response
      .then((data) => new File.fromJson(data));
  }
}

class ParentsResource_ extends Resource {

  ParentsResource_(Client client) : super(client) {
  }

  /**
   * Removes a parent from a file.
   *
   * [fileId] - The ID of the file.
   *
   * [parentId] - The ID of the parent.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<core.Map> delete(core.String fileId, core.String parentId, {core.Map optParams}) {
    var url = "files/{fileId}/parents/{parentId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (parentId == null) paramErrors.add("parentId is required");
    if (parentId != null) urlParams["parentId"] = parentId;
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
    response = _client.request(url, "DELETE", urlParams: urlParams, queryParams: queryParams);
    return response;
  }

  /**
   * Gets a specific parent reference.
   *
   * [fileId] - The ID of the file.
   *
   * [parentId] - The ID of the parent.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<ParentReference> get(core.String fileId, core.String parentId, {core.Map optParams}) {
    var url = "files/{fileId}/parents/{parentId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (parentId == null) paramErrors.add("parentId is required");
    if (parentId != null) urlParams["parentId"] = parentId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new ParentReference.fromJson(data));
  }

  /**
   * Adds a parent folder for a file.
   *
   * [request] - ParentReference to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<ParentReference> insert(ParentReference request, core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/parents";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "POST", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new ParentReference.fromJson(data));
  }

  /**
   * Lists a file's parents.
   *
   * [fileId] - The ID of the file.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<ParentList> list(core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/parents";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new ParentList.fromJson(data));
  }
}

class PermissionsResource_ extends Resource {

  PermissionsResource_(Client client) : super(client) {
  }

  /**
   * Deletes a permission from a file.
   *
   * [fileId] - The ID for the file.
   *
   * [permissionId] - The ID for the permission.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<core.Map> delete(core.String fileId, core.String permissionId, {core.Map optParams}) {
    var url = "files/{fileId}/permissions/{permissionId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (permissionId == null) paramErrors.add("permissionId is required");
    if (permissionId != null) urlParams["permissionId"] = permissionId;
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
    response = _client.request(url, "DELETE", urlParams: urlParams, queryParams: queryParams);
    return response;
  }

  /**
   * Gets a permission by ID.
   *
   * [fileId] - The ID for the file.
   *
   * [permissionId] - The ID for the permission.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Permission> get(core.String fileId, core.String permissionId, {core.Map optParams}) {
    var url = "files/{fileId}/permissions/{permissionId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (permissionId == null) paramErrors.add("permissionId is required");
    if (permissionId != null) urlParams["permissionId"] = permissionId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Permission.fromJson(data));
  }

  /**
   * Inserts a permission for a file.
   *
   * [request] - Permission to send in this request
   *
   * [fileId] - The ID for the file.
   *
   * [emailMessage] - A custom message to include in notification emails.
   *
   * [sendNotificationEmails] - Whether to send notification emails when sharing to users or groups.
   *   Default: true
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Permission> insert(Permission request, core.String fileId, {core.String emailMessage, core.bool sendNotificationEmails, core.Map optParams}) {
    var url = "files/{fileId}/permissions";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (emailMessage != null) queryParams["emailMessage"] = emailMessage;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (sendNotificationEmails != null) queryParams["sendNotificationEmails"] = sendNotificationEmails;
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
    response = _client.request(url, "POST", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Permission.fromJson(data));
  }

  /**
   * Lists a file's permissions.
   *
   * [fileId] - The ID for the file.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<PermissionList> list(core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/permissions";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new PermissionList.fromJson(data));
  }

  /**
   * Updates a permission. This method supports patch semantics.
   *
   * [request] - Permission to send in this request
   *
   * [fileId] - The ID for the file.
   *
   * [permissionId] - The ID for the permission.
   *
   * [transferOwnership] - Whether changing a role to 'owner' should also downgrade the current owners to writers.
   *   Default: false
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Permission> patch(Permission request, core.String fileId, core.String permissionId, {core.bool transferOwnership, core.Map optParams}) {
    var url = "files/{fileId}/permissions/{permissionId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (permissionId == null) paramErrors.add("permissionId is required");
    if (permissionId != null) urlParams["permissionId"] = permissionId;
    if (transferOwnership != null) queryParams["transferOwnership"] = transferOwnership;
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
    response = _client.request(url, "PATCH", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Permission.fromJson(data));
  }

  /**
   * Updates a permission.
   *
   * [request] - Permission to send in this request
   *
   * [fileId] - The ID for the file.
   *
   * [permissionId] - The ID for the permission.
   *
   * [transferOwnership] - Whether changing a role to 'owner' should also downgrade the current owners to writers.
   *   Default: false
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Permission> update(Permission request, core.String fileId, core.String permissionId, {core.bool transferOwnership, core.Map optParams}) {
    var url = "files/{fileId}/permissions/{permissionId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (permissionId == null) paramErrors.add("permissionId is required");
    if (permissionId != null) urlParams["permissionId"] = permissionId;
    if (transferOwnership != null) queryParams["transferOwnership"] = transferOwnership;
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
    response = _client.request(url, "PUT", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Permission.fromJson(data));
  }
}

class PropertiesResource_ extends Resource {

  PropertiesResource_(Client client) : super(client) {
  }

  /**
   * Deletes a property.
   *
   * [fileId] - The ID of the file.
   *
   * [propertyKey] - The key of the property.
   *
   * [visibility] - The visibility of the property.
   *   Default: private
   *
   * [optParams] - Additional query parameters
   */
  async.Future<core.Map> delete(core.String fileId, core.String propertyKey, {core.String visibility, core.Map optParams}) {
    var url = "files/{fileId}/properties/{propertyKey}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (propertyKey == null) paramErrors.add("propertyKey is required");
    if (propertyKey != null) urlParams["propertyKey"] = propertyKey;
    if (visibility != null) queryParams["visibility"] = visibility;
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
    response = _client.request(url, "DELETE", urlParams: urlParams, queryParams: queryParams);
    return response;
  }

  /**
   * Gets a property by its key.
   *
   * [fileId] - The ID of the file.
   *
   * [propertyKey] - The key of the property.
   *
   * [visibility] - The visibility of the property.
   *   Default: private
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Property> get(core.String fileId, core.String propertyKey, {core.String visibility, core.Map optParams}) {
    var url = "files/{fileId}/properties/{propertyKey}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (propertyKey == null) paramErrors.add("propertyKey is required");
    if (propertyKey != null) urlParams["propertyKey"] = propertyKey;
    if (visibility != null) queryParams["visibility"] = visibility;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Property.fromJson(data));
  }

  /**
   * Adds a property to a file.
   *
   * [request] - Property to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Property> insert(Property request, core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/properties";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "POST", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Property.fromJson(data));
  }

  /**
   * Lists a file's properties.
   *
   * [fileId] - The ID of the file.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<PropertyList> list(core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/properties";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new PropertyList.fromJson(data));
  }

  /**
   * Updates a property. This method supports patch semantics.
   *
   * [request] - Property to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [propertyKey] - The key of the property.
   *
   * [visibility] - The visibility of the property.
   *   Default: private
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Property> patch(Property request, core.String fileId, core.String propertyKey, {core.String visibility, core.Map optParams}) {
    var url = "files/{fileId}/properties/{propertyKey}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (propertyKey == null) paramErrors.add("propertyKey is required");
    if (propertyKey != null) urlParams["propertyKey"] = propertyKey;
    if (visibility != null) queryParams["visibility"] = visibility;
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
    response = _client.request(url, "PATCH", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Property.fromJson(data));
  }

  /**
   * Updates a property.
   *
   * [request] - Property to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [propertyKey] - The key of the property.
   *
   * [visibility] - The visibility of the property.
   *   Default: private
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Property> update(Property request, core.String fileId, core.String propertyKey, {core.String visibility, core.Map optParams}) {
    var url = "files/{fileId}/properties/{propertyKey}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (propertyKey == null) paramErrors.add("propertyKey is required");
    if (propertyKey != null) urlParams["propertyKey"] = propertyKey;
    if (visibility != null) queryParams["visibility"] = visibility;
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
    response = _client.request(url, "PUT", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Property.fromJson(data));
  }
}

class RepliesResource_ extends Resource {

  RepliesResource_(Client client) : super(client) {
  }

  /**
   * Deletes a reply.
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [replyId] - The ID of the reply.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<core.Map> delete(core.String fileId, core.String commentId, core.String replyId, {core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}/replies/{replyId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (replyId == null) paramErrors.add("replyId is required");
    if (replyId != null) urlParams["replyId"] = replyId;
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
    response = _client.request(url, "DELETE", urlParams: urlParams, queryParams: queryParams);
    return response;
  }

  /**
   * Gets a reply.
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [replyId] - The ID of the reply.
   *
   * [includeDeleted] - If set, this will succeed when retrieving a deleted reply.
   *   Default: false
   *
   * [optParams] - Additional query parameters
   */
  async.Future<CommentReply> get(core.String fileId, core.String commentId, core.String replyId, {core.bool includeDeleted, core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}/replies/{replyId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (includeDeleted != null) queryParams["includeDeleted"] = includeDeleted;
    if (replyId == null) paramErrors.add("replyId is required");
    if (replyId != null) urlParams["replyId"] = replyId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new CommentReply.fromJson(data));
  }

  /**
   * Creates a new reply to the given comment.
   *
   * [request] - CommentReply to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<CommentReply> insert(CommentReply request, core.String fileId, core.String commentId, {core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}/replies";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "POST", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new CommentReply.fromJson(data));
  }

  /**
   * Lists all of the replies to a comment.
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [includeDeleted] - If set, all replies, including deleted replies (with content stripped) will be returned.
   *   Default: false
   *
   * [maxResults] - The maximum number of replies to include in the response, used for paging.
   *   Default: 20
   *   Minimum: 0
   *   Maximum: 100
   *
   * [pageToken] - The continuation token, used to page through large result sets. To get the next page of results, set this parameter to the value of "nextPageToken" from the previous response.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<CommentReplyList> list(core.String fileId, core.String commentId, {core.bool includeDeleted, core.int maxResults, core.String pageToken, core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}/replies";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (includeDeleted != null) queryParams["includeDeleted"] = includeDeleted;
    if (maxResults != null) queryParams["maxResults"] = maxResults;
    if (pageToken != null) queryParams["pageToken"] = pageToken;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new CommentReplyList.fromJson(data));
  }

  /**
   * Updates an existing reply. This method supports patch semantics.
   *
   * [request] - CommentReply to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [replyId] - The ID of the reply.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<CommentReply> patch(CommentReply request, core.String fileId, core.String commentId, core.String replyId, {core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}/replies/{replyId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (replyId == null) paramErrors.add("replyId is required");
    if (replyId != null) urlParams["replyId"] = replyId;
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
    response = _client.request(url, "PATCH", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new CommentReply.fromJson(data));
  }

  /**
   * Updates an existing reply.
   *
   * [request] - CommentReply to send in this request
   *
   * [fileId] - The ID of the file.
   *
   * [commentId] - The ID of the comment.
   *
   * [replyId] - The ID of the reply.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<CommentReply> update(CommentReply request, core.String fileId, core.String commentId, core.String replyId, {core.Map optParams}) {
    var url = "files/{fileId}/comments/{commentId}/replies/{replyId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (commentId == null) paramErrors.add("commentId is required");
    if (commentId != null) urlParams["commentId"] = commentId;
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (replyId == null) paramErrors.add("replyId is required");
    if (replyId != null) urlParams["replyId"] = replyId;
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
    response = _client.request(url, "PUT", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new CommentReply.fromJson(data));
  }
}

class RevisionsResource_ extends Resource {

  RevisionsResource_(Client client) : super(client) {
  }

  /**
   * Removes a revision.
   *
   * [fileId] - The ID of the file.
   *
   * [revisionId] - The ID of the revision.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<core.Map> delete(core.String fileId, core.String revisionId, {core.Map optParams}) {
    var url = "files/{fileId}/revisions/{revisionId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (revisionId == null) paramErrors.add("revisionId is required");
    if (revisionId != null) urlParams["revisionId"] = revisionId;
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
    response = _client.request(url, "DELETE", urlParams: urlParams, queryParams: queryParams);
    return response;
  }

  /**
   * Gets a specific revision.
   *
   * [fileId] - The ID of the file.
   *
   * [revisionId] - The ID of the revision.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Revision> get(core.String fileId, core.String revisionId, {core.Map optParams}) {
    var url = "files/{fileId}/revisions/{revisionId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (revisionId == null) paramErrors.add("revisionId is required");
    if (revisionId != null) urlParams["revisionId"] = revisionId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Revision.fromJson(data));
  }

  /**
   * Lists a file's revisions.
   *
   * [fileId] - The ID of the file.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<RevisionList> list(core.String fileId, {core.Map optParams}) {
    var url = "files/{fileId}/revisions";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
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
    response = _client.request(url, "GET", urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new RevisionList.fromJson(data));
  }

  /**
   * Updates a revision. This method supports patch semantics.
   *
   * [request] - Revision to send in this request
   *
   * [fileId] - The ID for the file.
   *
   * [revisionId] - The ID for the revision.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Revision> patch(Revision request, core.String fileId, core.String revisionId, {core.Map optParams}) {
    var url = "files/{fileId}/revisions/{revisionId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (revisionId == null) paramErrors.add("revisionId is required");
    if (revisionId != null) urlParams["revisionId"] = revisionId;
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
    response = _client.request(url, "PATCH", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Revision.fromJson(data));
  }

  /**
   * Updates a revision.
   *
   * [request] - Revision to send in this request
   *
   * [fileId] - The ID for the file.
   *
   * [revisionId] - The ID for the revision.
   *
   * [optParams] - Additional query parameters
   */
  async.Future<Revision> update(Revision request, core.String fileId, core.String revisionId, {core.Map optParams}) {
    var url = "files/{fileId}/revisions/{revisionId}";
    var urlParams = new core.Map();
    var queryParams = new core.Map();

    var paramErrors = new core.List();
    if (fileId == null) paramErrors.add("fileId is required");
    if (fileId != null) urlParams["fileId"] = fileId;
    if (revisionId == null) paramErrors.add("revisionId is required");
    if (revisionId != null) urlParams["revisionId"] = revisionId;
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
    response = _client.request(url, "PUT", body: request.toString(), urlParams: urlParams, queryParams: queryParams);
    return response
      .then((data) => new Revision.fromJson(data));
  }
}

