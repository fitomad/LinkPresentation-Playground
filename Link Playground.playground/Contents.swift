//: A UIKit based Playground for presenting user interface
  
import UIKit
import LinkPresentation

import PlaygroundSupport

class MyViewController : UIViewController
{
    let websitesURI = [
        "https://www.apple.com",
        "https://www.youtube.com/watch?v=3x7_w9Oz8lQ",
        "http://desappstre.com"
    ]
    
    override func loadView()
    {
        let container = UIView()
        container.backgroundColor = .white
        self.view = container
        
        // Vamos a añadir la vista...
        self.makeLinkPreview() { (linkView: UIView?) -> Void in
            if let linkView = linkView
            {
                // Se ha podido crear la vista previa.
                
                linkView.frame = CGRect(x: 0.0, y:0.0, width: 300.0, height: 200.0)
                linkView.center = self.view.center
                
                self.view.addSubview(linkView)
            }
        }
    }
    
    /**
        Genera un `LPLinkPreview` a partir de una `URL`.
     
        Lo devolvemos en un *closure* para añadirlo a la vista.
     */
    private func makeLinkPreview(_ handler: @escaping ((_ linkView: UIView?) -> Void)) -> Void
    {
        guard let videoURL = URL(string: "http://desappstre.com") else
        {
            handler(nil)
            return
        }
        
        let metadataProvider = LPMetadataProvider()
        
        metadataProvider.startFetchingMetadata(for: videoURL, completionHandler: { (metadata: LPLinkMetadata?, error: Error?) -> Void in
            if let desappstreMetadata = metadata
            {
                let linkView = LPLinkView(metadata: desappstreMetadata)
                handler(linkView)
            }
        })
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

