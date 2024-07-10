

import UIKit

class SearchViewController: UIViewController {
    
    public var titles: [Title] = [Title]() // Созд пуст массив обьектов типа Тайтл
    
    // Устанавл таблицу под фильмы нашего Топ Поиска
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier) // Айдентиф - для регистрац повторного использ ячейк табл
        return table
    }()
    
    // Контроллер для Контроллера Поиска
    private let searchController: UISearchController = {
        
       let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or a Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    
    // Вью ДИД Лоад
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true // Устан предпочтения большого заголовка
        navigationItem.largeTitleDisplayMode = .always // Установка режима отображения большого заголовка для текущего view controller
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self // Назнач текущий SearchViewController в качестве делегата
        discoverTable.dataSource = self // Назнач текущий SearchViewController в качестве источн данных
        navigationItem.searchController = searchController // делаем строку поиска в верхней части экрана
        
        navigationController?.navigationBar.tintColor = .white
        fetchDiscoverMovies() // метод для получ данных с помощ API
        
        // Настройка обновления для поиска
        searchController.searchResultsUpdater = self
        
    }
    
    private func fetchDiscoverMovies() { //  Настраиваем API. Приватн - доступен только внутри класса.
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result { // Свич проверяет переменную result (резалт парам замык с тру/фолс)
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData() // обновл таблицы с новыми данными
                }
            case .failure(let error):
                print(error.localizedDescription) // Печатает подробное описание ошибки
            }
        }
    }
    
    // Подгонка фрейма по размеру
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {    // Метод для указания количества строк в таблице
        return titles.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknown name", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        
        return cell; // Потому что у нас пока что нет даннных
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {

                  return
        }
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let titles):
                    resultsController.titles = titles // Присв рузельт поиска
                    resultsController.searchResultsCollectionView.reloadData()

                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
