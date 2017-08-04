//
//  ViewController.swift
//  Rana Come Moscas
//
//  Created by Camilo Soto  on 26/12/16.
//  Copyright © 2016 Camilo Andres Soto Herrera. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var gusano: UIImageView!
    @IBOutlet weak var rana: UIImageView!
    @IBOutlet weak var puntaje: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    var beep: AVAudioPlayer?
    
    var ancho = 0
    var alto = 0
    let tamano = 35
    var points = 0
    // Limites de la margen del tablero
    var limUp = 0
    var limLeft = 0
    var limRigth = 0
    var limDown = 0
    
    // Posicion de Origen
    var ranaOrigX = 120
    var ranaOrigY = 130
    var gusOrigX = 50
    var gusOrigY = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initParametes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnArriba(_ sender: UIButton) {
        guard ranaOrigY > limUp else {return}
        ranaOrigY = ranaOrigY - 10
        let rectRana = CGRect(x: ranaOrigX, y: ranaOrigY, width: tamano, height: tamano)
        rana.frame = rectRana
        compareCoord()
    }

    @IBAction func btnDerecha(_ sender: UIButton) {
        guard ranaOrigX < limRigth else {return}
        ranaOrigX = ranaOrigX + 10
        let rectRana = CGRect(x: ranaOrigX, y: ranaOrigY, width: tamano, height: tamano)
        rana.frame = rectRana
        compareCoord()
    }
    
    @IBAction func btnAbajo(_ sender: UIButton) {
        guard ranaOrigY < limDown else {return}
        ranaOrigY = ranaOrigY + 10
        let rectRana = CGRect(x: ranaOrigX, y: ranaOrigY, width: tamano, height: tamano)
        rana.frame = rectRana
        compareCoord()
    }
    
    @IBAction func btnIzquierda(_ sender: UIButton) {
        guard ranaOrigX > limLeft else {return}
        ranaOrigX = ranaOrigX - 10
        let rectRana = CGRect(x: ranaOrigX, y: ranaOrigY, width: tamano, height: tamano)
        
        rana.frame = rectRana
        compareCoord()
    }
    
    // Parametros iniciales de posicion
    func initParametes () {
        let bounds = UIScreen.main.bounds
        ancho = Int(bounds.width)
        alto = Int(bounds.height)
        
        limUp = 30
        limDown = alto - 200
        limLeft = 30
        limRigth = ancho - 60
        
        let rect = CGRect(x: gusOrigX, y: gusOrigY, width: tamano - 10, height: tamano - 10)
        let rectRana = CGRect(x: ranaOrigX, y: ranaOrigY, width: tamano, height: tamano)
        
        gusano.frame = rect
        rana.frame = rectRana
    }
    
    func compareCoord () {
        
        guard gusOrigX == ranaOrigX else{return}
        guard gusOrigY == ranaOrigY else {return}
        points = points + 1
        puntaje.text = "\(points)"
        
        let limX = limRigth - 30
        let limY = limDown - 30
        
        let randX = arc4random_uniform(UInt32(limX))
        let randY = arc4random_uniform(UInt32(limY))
        
        let roundX = Int(randX) - (Int(randX) % 10)
        let roundY = Int(randY) - (Int(randY) % 10)
        
        gusOrigX = roundX + 30
        gusOrigY = roundY + 30
        
        print("+++++ \(gusOrigX),     \(gusOrigY)   \(roundX)     \(roundY)")
        
        let rectGus = CGRect(x: gusOrigX, y: gusOrigY, width: tamano, height: tamano)
        gusano.frame = rectGus
        
        playSound()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "robot_beep", withExtension: "mp3")!
        
        do {
            beep = try AVAudioPlayer(contentsOf: url)
            guard let player = beep else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

