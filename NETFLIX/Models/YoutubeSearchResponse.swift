
// Определяем структуру данных для обраб результ поиска видео на YT, кот возвращаются в формате JSON. Структуры используются для декодирования JSON-ответа от API YouTube и извлечения необходимых нам данных

import Foundation


/*
 items =     (
             {
         etag = "nokcGt9OrQ0QycurR_Z6fJV5eFQ";
         id =             {
             kind = "youtube#video";
             videoId = LbKIKjgfT90;
         };
         kind = "youtube#searchResult";
     },
*/

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
