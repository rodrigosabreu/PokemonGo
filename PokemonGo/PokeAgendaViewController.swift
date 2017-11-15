//
//  PokeAgendaViewController.swift
//  PokemonGo
//
//  Created by Rodrigo Abreu on 15/11/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit

class PokeAgendaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCapturados: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let coreData = CoreDataPokemon()
        
        self.pokemonsCapturados = coreData.recuperarPokemonsCapturados(capturado: true)
        self.pokemonsNaoCapturados = coreData.recuperarPokemonsCapturados(capturado: false)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //criando sessoes na table view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            return "Capturados"
        }else{
            return "Não Capturados"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return self.pokemonsCapturados.count
        }else{
            return self.pokemonsNaoCapturados.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon: Pokemon
        if indexPath.section == 0{
            pokemon = self.pokemonsCapturados[ indexPath.row ]
        }else{
            pokemon = self.pokemonsNaoCapturados[ indexPath.row ]
        }
        
        let celula = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ceula")
        celula.textLabel?.text = pokemon.nome
        celula.imageView?.image = UIImage(named: pokemon.nomeImagem!)
        
        return celula
        
    }
    
    
    @IBAction func voltarMapa(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
