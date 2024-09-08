//
//  MainViewController.swift
//  AppWithMiniApps
//
//  Created by Полина Голодаевская on 03.09.2024.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum MiniAppType {
        case weather
        case city
        case ticTacToe
    }
    
    enum DisplayMode {
        case small // 1/8 высоты
        case medium // 1/2 высоты экрана
        case fullScreen // весь экран
    }

    struct MiniApp {
        let type: MiniAppType
        var displayMode: DisplayMode
    }

    // Массив мини-приложений
    var miniApps: [MiniApp] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        // Регистрируем ячейку для использования
        collectionView.register(MiniAppCell.self, forCellWithReuseIdentifier: "MiniAppCell")

        // Инициализация мини-приложений
        miniApps = [
                    MiniApp(type: .weather, displayMode: .small),
                    MiniApp(type: .city, displayMode: .small),
                    MiniApp(type: .ticTacToe, displayMode: .small),
                    MiniApp(type: .weather, displayMode: .medium),
                    MiniApp(type: .city, displayMode: .medium),
                    MiniApp(type: .ticTacToe, displayMode: .medium),
                    MiniApp(type: .weather, displayMode: .fullScreen),
                    MiniApp(type: .city, displayMode: .fullScreen),
                    MiniApp(type: .ticTacToe, displayMode: .fullScreen),
                    MiniApp(type: .weather, displayMode: .fullScreen),
                ]
    }

    // Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return miniApps.count
    }

    // Настройка ячеек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniAppCell", for: indexPath) as? MiniAppCell else { return UICollectionViewCell() }
        
        let miniApp = miniApps[indexPath.row]

        switch miniApp.type {
            case .weather:
                cell.backgroundColor = .systemBlue
                cell.titleLabel.text = "Weather"
            case .city:
                cell.backgroundColor = .blue
                cell.titleLabel.text = "City"
            case .ticTacToe:
                cell.backgroundColor = .lightGray
                cell.titleLabel.text = "Tic Tac Toe"
        }
        return cell
    }

    // Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let miniApp = miniApps[indexPath.row]
        let width = collectionView.bounds.width
        let height: CGFloat
        switch miniApp.displayMode {
        case .small:
            height = collectionView.bounds.height / 8
        case .medium:
            height = collectionView.bounds.height / 2
        case .fullScreen:
            height = collectionView.bounds.height
        }
        return CGSize(width: width, height: height)
    }

    // Обработка нажатия ячееек
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let miniApp = miniApps[indexPath.row]
        
        let cellHeight: CGFloat
        switch miniApp.displayMode {
        case .small:
            cellHeight = collectionView.bounds.height / 8
        case .medium:
            cellHeight = collectionView.bounds.height / 2
        case .fullScreen:
            cellHeight = collectionView.bounds.height
        }
        
        if cellHeight > collectionView.bounds.height / 8 {
            switch miniApp.type {
                case .weather:
                    performSegue(withIdentifier: "showWeatherDetails", sender: self)
                case .city:
                    performSegue(withIdentifier: "showCityDetails", sender: self)
                case .ticTacToe:
                    performSegue(withIdentifier: "showTicTacToeDetails", sender: self)
            }
        } else {
            let alertController = UIAlertController(
                title: "Segue is impossible",
                message: "Select a larger cell",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
