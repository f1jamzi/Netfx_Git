

import UIKit

class DownloadsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true // Устан предпочтения большого заголовка
        navigationItem.largeTitleDisplayMode = .always // Установка режима отображения большого заголовка для текущего view controller
        
        view.backgroundColor = .systemBackground
    }

}
