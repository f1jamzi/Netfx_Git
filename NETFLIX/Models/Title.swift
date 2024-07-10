
import Foundation

// Структура для хранения инфо о фильмах 
struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

/*
 
 {
adult = 0;
"backdrop_path" = "/nv6F6tz7r61DUhE7zgHwLJFcTYp.jpg";
"genre_ids" =             (
 35,
 80,
 10749
);
id = 974635;
"media_type" = movie;
"original_language" = en;
"original_title" = "Hit Man";
overview = "A mild-mannered professor moonlighting as a fake hit man in police stings ignites a chain reaction of trouble when he falls for a potential client.";
popularity = "231.388";
"poster_path" = "/1126gjlBf4hTm9Sgf0ox3LGVEBt.jpg";
"release_date" = "2024-05-16";
title = "Hit Man";
video = 0;
"vote_average" = "7.1";
"vote_count" = 99;
 
 */
