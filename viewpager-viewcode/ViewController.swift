//
//  ViewController.swift
//  viewpager-viewcode
//
//  Created by Wallace Baldenebre on 27/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openDialogPressed(_ sender: Any) {
        var listPages = Array<PageModel>()
        
        var pageModel1 = PageModel()
        pageModel1.icon = UIImage(named: "squirtle_image")
        pageModel1.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        pageModel1.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce interdum elit eu velit pellentesque, sed consectetur est rhoncus. Vestibulum rutrum, ante vitae dictum posuere, nunc neque ornare augue, quis faucibus diam odio a ex. Suspendisse potenti. Nulla a dui erat. Aenean feugiat leo iaculis nulla sodales pulvinar eu id sapien. Aliquam quis purus urna. Integer risus enim, sagittis sed laoreet ut, dictum ut tellus. Vestibulum fringilla at libero ut mollis. Nam magna felis, lacinia a mollis vel, tincidunt sed mi."
        pageModel1.titleButton = "Botao 1"
        pageModel1.actionButton = { print("BOTAO 1") }
        
        var pageModel2 = PageModel()
        pageModel2.icon = UIImage(named: "wartotle_image")
        pageModel2.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        pageModel2.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce interdum elit eu velit pellentesque, sed consectetur est rhoncus. Vestibulum rutrum, ante vitae dictum posuere, nunc neque ornare augue, quis faucibus diam odio a ex. Suspendisse potenti. Nulla a dui erat. Aenean feugiat leo iaculis nulla sodales pulvinar eu id sapien."
        pageModel2.titleButton = "Botao 2"
        pageModel2.actionButton = { print("BOTAO 2") }
        
        var pageModel3 = PageModel()
        pageModel3.icon = UIImage(named: "blastoise_image")
        pageModel3.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        pageModel3.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        pageModel3.titleButton = "Botao 3"
        pageModel3.actionButton = { print("BOTAO 3") }
        
        listPages.append(pageModel1)
        listPages.append(pageModel2)
        listPages.append(pageModel3)
        
        bottomsheet(listPages)
    }
    
    private func bottomsheet(_ listPages: Array<PageModel>) {
        let dialog = PagerViewController(pages: listPages, titleJumpButton: "Ok, entendi")!
        dialog.modalPresentationStyle = .overCurrentContext
        self.present(dialog, animated: false)
    }

}

