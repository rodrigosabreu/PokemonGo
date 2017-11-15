//
//  PokeAgendaViewController.swift
//  PokemonGo
//
//  Created by Rodrigo Abreu on 15/11/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit

class PokeAgendaViewController: UIViewController {

    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCapturados: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let coreData = CoreDataPokemon()
        
        self.pokemonsCapturados = coreData.recuperarPokemonsCapturados(capturado: true)
        self.pokemonsNaoCapturados = coreData.recuperarPokemonsCapturados(capturado: false)
        
                
        
    }

    @IBAction func voltarMapa(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
