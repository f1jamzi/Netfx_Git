import UIKit

class UpcomingViewController: UIViewController {

    private var titles: [Title] = [Title]() // Созд пуст массив обьектов типа Тайтл
    
    // Создаем и настраиваетм таблицу - upcomingTable
    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier) // Айдентиф - для регистрац повторного использ ячейк табл
        return table
    }()
    
    override func viewDidLoad() { // ставим Вью Дид Лоад
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true // Устан предпочтения большого заголовка
        navigationItem.largeTitleDisplayMode = .always // Установка режима отображения большого заголовка для текущего view controller
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming() // метод для получ данных с помощ API
    }
    
    override func viewDidLayoutSubviews() { // Расчерчиваем таблицу для каждой строки
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcoming() { //  Настраиваем API. Приватн - доступен только внутри класса.
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData() // обновл таблицы с новыми данными
                }
            case .failure(let error):
                print(error.localizedDescription) // Печатает подробное описание ошибки
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? title.original_name ?? "Unknown Title Name"
        let posterURL = title.poster_path ?? ""
        
        let titleViewModel = TitleViewModel(titleName: titleName, posterURL: posterURL)
        cell.configure(with: titleViewModel)
        
        return cell
    }
    
    // Метод для установки высоты ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 // Укажите желаемую высоту ячейки
        
    }
}
