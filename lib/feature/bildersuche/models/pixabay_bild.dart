// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

// Interne Bild Klasse für leichtere Verwendung
//
// Könnte auch verallgemeinert werden, falls mehrere APIs verwendet werden
class PixabayBild {
  final int id;
  final String pageURL;
  final String type;
  final List<String> tags;
  final String previewURL;
  final int previewWidth;
  final int previewHeight;
  final String webformatURL;
  final int webformatWidth;
  final int webformatHeight;
  final String largeImageURL;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int views;
  final int downloads;
  final int collections;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImageURL;

  const PixabayBild({
    required this.id,
    required this.pageURL,
    required this.type,
    required this.tags,
    required this.previewURL,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatURL,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageURL,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.collections,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageURL,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pageURL': pageURL,
      'type': type,
      'tags': tags.join(", "),
      'previewURL': previewURL,
      'previewWidth': previewWidth,
      'previewHeight': previewHeight,
      'webformatURL': webformatURL,
      'webformatWidth': webformatWidth,
      'webformatHeight': webformatHeight,
      'largeImageURL': largeImageURL,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight,
      'imageSize': imageSize,
      'views': views,
      'downloads': downloads,
      'collections': collections,
      'likes': likes,
      'comments': comments,
      'user_id': userId,
      'user': user,
      'userImageURL': userImageURL,
    };
  }

  factory PixabayBild.fromMap(Map<String, dynamic> map) {
    return PixabayBild(
      id: map['id'] as int,
      pageURL: map['pageURL'] as String,
      type: map['type'] as String,
      tags: (map['tags'] as String).split(", "),
      previewURL: map['previewURL'] as String,
      previewWidth: map['previewWidth'] as int,
      previewHeight: map['previewHeight'] as int,
      webformatURL: map['webformatURL'] as String,
      webformatWidth: map['webformatWidth'] as int,
      webformatHeight: map['webformatHeight'] as int,
      largeImageURL: map['largeImageURL'] as String,
      imageWidth: map['imageWidth'] as int,
      imageHeight: map['imageHeight'] as int,
      imageSize: map['imageSize'] as int,
      views: map['views'] as int,
      downloads: map['downloads'] as int,
      collections: map['collections'] as int,
      likes: map['likes'] as int,
      comments: map['comments'] as int,
      userId: map['user_id'] as int,
      user: map['user'] as String,
      userImageURL: map['userImageURL'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PixabayBild.fromJson(String source) =>
      PixabayBild.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PixabayBild(id: $id, pageURL: $pageURL, type: $type, tags: $tags, previewURL: $previewURL, previewWidth: $previewWidth, previewHeight: $previewHeight, webformatURL: $webformatURL, webformatWidth: $webformatWidth, webformatHeight: $webformatHeight, largeImageURL: $largeImageURL, imageWidth: $imageWidth, imageHeight: $imageHeight, imageSize: $imageSize, views: $views, downloads: $downloads, collections: $collections, likes: $likes, comments: $comments, user_id: $userId, user: $user, userImageURL: $userImageURL)';
  }

  @override
  bool operator ==(covariant PixabayBild other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pageURL == pageURL &&
        other.type == type &&
        listEquals(other.tags, tags) &&
        other.previewURL == previewURL &&
        other.previewWidth == previewWidth &&
        other.previewHeight == previewHeight &&
        other.webformatURL == webformatURL &&
        other.webformatWidth == webformatWidth &&
        other.webformatHeight == webformatHeight &&
        other.largeImageURL == largeImageURL &&
        other.imageWidth == imageWidth &&
        other.imageHeight == imageHeight &&
        other.imageSize == imageSize &&
        other.views == views &&
        other.downloads == downloads &&
        other.collections == collections &&
        other.likes == likes &&
        other.comments == comments &&
        other.userId == userId &&
        other.user == user &&
        other.userImageURL == userImageURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pageURL.hashCode ^
        type.hashCode ^
        tags.hashCode ^
        previewURL.hashCode ^
        previewWidth.hashCode ^
        previewHeight.hashCode ^
        webformatURL.hashCode ^
        webformatWidth.hashCode ^
        webformatHeight.hashCode ^
        largeImageURL.hashCode ^
        imageWidth.hashCode ^
        imageHeight.hashCode ^
        imageSize.hashCode ^
        views.hashCode ^
        downloads.hashCode ^
        collections.hashCode ^
        likes.hashCode ^
        comments.hashCode ^
        userId.hashCode ^
        user.hashCode ^
        userImageURL.hashCode;
  }
}
