
import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let vc1 = UINavigationController(rootViewController: HomeViewController()) // делаем корневКонтр->Хоум
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())

        
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house") // присваение картинок для таббарных элем
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")

        vc1.title = "Home" // Тута названия этих картинок
        vc2.title = "Coming Soon"
        vc3.title = "Top Seach"
        vc4.title = "Download"
        
        
        tabBar.tintColor = .label // цвет для иконок в таббаре 

        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true) //это установка вью контр в таб баре
        
    }


}

