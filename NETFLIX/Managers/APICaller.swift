import Foundation

// Структура для хранения констант - Апи Ключей к информации
struct Constants {
    static let API_KEY = "bc4fa982438ce18135272da2ffe60718" // КлючAPI доступ к сервису The Movie Database
    static let baseURL = "https://api.themoviedb.org" // Базовый URL для API The Movie Database
    static let YoutubeAPI_KEY = "AIzaSyAY9XmbRdSH2GIAhtDtQ7QH2hKMdyc0_T0"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

// Перечисление для обработки ошибок API
enum APIError: Error {
    case failedToGetData
}

// Класс для выполнения API вызовов
class APICaller {
    static let shared = APICaller()
    
    // Функция для получения списка трендовых фильмов
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                // Возвращаем ошибку, если не удалось получить данные
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))  // Возвращаем успешный результат с массивом фильмов
                
            } catch {
                completion(.failure(APIError.failedToGetData)) // Возвращаем ошибку, если не удалось получить данные
            }
        }
        
        task.resume()
    }
    
    // Функция для получения списка трендовых сериалов
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                // Возвращаем ошибку, если не удалось получить данные
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))  // Возвращаем успешный результат с массивом сериалов
            } catch {
                completion(.failure(APIError.failedToGetData)) // Возвращаем ошибку, если не удалось получить данные
            }
        }
        
        task.resume()
    }
    
    // Функция для получения списка предстоящих фильмов
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                // Возвращаем ошибку, если не удалось получить данные
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))  // Возвращаем успешный результат с массивом предстоящих фильмов
            } catch {
                completion(.failure(APIError.failedToGetData)) // Возвращаем ошибку, если не удалось получить данные
            }
        }
        
        task.resume()
    }
    
    // Функция для получения списка популярных фильмов
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                // Возвращаем ошибку, если не удалось получить данные
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))  // Возвращаем успешный результат с массивом популярных фильмов
            } catch {
                completion(.failure(APIError.failedToGetData)) // Возвращаем ошибку, если не удалось получить данные
            }
        }
        
        task.resume()
    }
    
    // Функция для получения списка фильмов с высоким рейтингом
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                // Возвращаем ошибку, если не удалось получить данные
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))  // Возвращаем успешный результат с массивом фильмов с высоким рейтингом
            } catch {
                completion(.failure(APIError.failedToGetData)) // Возвращаем ошибку, если не удалось получить данные
            }
        }
        
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                
                // Возвращаем ошибку, если не удалось получить данные
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))  // Возвращаем успешный результат с массивом фильмов с высоким рейтингом
            } catch {
                completion(.failure(APIError.failedToGetData)) // Возвращаем ошибку, если не удалось получить данные
            }
        }
        
        task.resume()
    }
        
    // Функция для Get Discover Movies (чтобы в окне с поиском было то что ищем)
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let quary = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        // это для того чтобы ОТОБРАЖАЛСЯ фильм который ищешь
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                
                // Возвращаем ошибку, если не удалось получить данные
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))  // Возвращаем успешный результат с массивом фильмов с высоким рейтингом
            } catch {
                completion(.failure(APIError.failedToGetData)) // Возвращаем ошибку, если не удалось получить данные
            }
        }
        
        task.resume()
    }
    
    func getMovie(with query: String) {
        let url = URL(string: "\(Constants.YoutubeBaseURL)q=Harry&key=[YOUR_API_KEY]") // Constants - это структура
    }
    
    
}

