//
//  CoreDataPokemon.swift
//  PokemonGo
//
//  Created by Rodrigo Abreu on 15/11/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import CoreData

class CoreDataPokemon{
    
    //recuperar o contexto
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
    }
    
    func recuperarTodosPokemons() -> [Pokemon]{
        
        let context = self.getContext()
        
        do{
            
            let pokemons = try context.fetch( Pokemon.fetchRequest() ) as! [Pokemon]
            
            if pokemons.count == 0{
                self.adicionarTodosPokemons()
                return self.recuperarTodosPokemons()
            }
            
            return pokemons
            
        }catch{}
        
        return []
    }
    
    
    //adicionar todos os pokemons
    func adicionarTodosPokemons(){
        
        let context = self.getContext()
        
        self.criarPokemon(nome: "Abra", nomeImagem: "abra", capturado: false)
        self.criarPokemon(nome: "Bellsprout", nomeImagem: "bellsprout", capturado: false)
        self.criarPokemon(nome: "Bullbasaur", nomeImagem: "bullbasaur", capturado: false)
        self.criarPokemon(nome: "Charmander", nomeImagem: "charmander", capturado: false)
        self.criarPokemon(nome: "Dratini", nomeImagem: "dratini", capturado: false)
        self.criarPokemon(nome: "Eeve", nomeImagem: "eeve", capturado: false)
        self.criarPokemon(nome: "Mankey", nomeImagem: "mankey", capturado: false)
        self.criarPokemon(nome: "Meowth", nomeImagem: "meowth", capturado: false)
        self.criarPokemon(nome: "Mew", nomeImagem: "mew", capturado: false)
        self.criarPokemon(nome: "Pidgey", nomeImagem: "pidgey", capturado: false)
        self.criarPokemon(nome: "Pikachu", nomeImagem: "pikachu-2", capturado: true)
        self.criarPokemon(nome: "Psyduck", nomeImagem: "psyduck", capturado: false)
        self.criarPokemon(nome: "Rattata", nomeImagem: "rattata", capturado: false)
        self.criarPokemon(nome: "Snorlax", nomeImagem: "snorlax", capturado: false)
        self.criarPokemon(nome: "Squirtle", nomeImagem: "squirtle", capturado: false)
        self.criarPokemon(nome: "Venonat", nomeImagem: "venonat", capturado: false)
        self.criarPokemon(nome: "Weedle", nomeImagem: "weedle", capturado: false)
        self.criarPokemon(nome: "Zubat", nomeImagem: "zubat", capturado: false)
        
        do{
            try context.save()
        }catch{}
        
    }
    
    
    //criar os pokemons
    func criarPokemon(nome:String, nomeImagem:String, capturado:Bool){
        
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeImagem = nomeImagem
        pokemon.capturado = capturado
        
    }
    
    
    
    
    
    
}
