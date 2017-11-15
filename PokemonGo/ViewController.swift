//
//  ViewController.swift
//  PokemonGo
//
//  Created by Rodrigo Abreu on 15/11/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var contador = 0
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        //pedindo autorização de lozalização ao usuário
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        //recuperar pokemons
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recuperarTodosPokemons()
        
        //Exibir pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate{
                
                let totalPokemons = UInt32(self.pokemons.count)
                let indicePokemonAleatorio = arc4random_uniform( totalPokemons )
                
                let pokemon = self.pokemons[ Int(indicePokemonAleatorio) ]
                
                //let anotacao = MKPointAnnotation()
                let anotacao = PokemonAnotacao(coordenadas: coordenadas)
                
                let latAleatoria = (Double( arc4random_uniform(400) ) - 200) / 100000.0
                let lonAleatoria = (Double( arc4random_uniform(400) ) - 200) / 100000.0
                
                //anotacao.coordinate = coordenadas
                anotacao.coordinate.latitude += latAleatoria
                anotacao.coordinate.longitude += lonAleatoria
                
                self.mapa.addAnnotation(anotacao)
            }
            
        }
        
    }
    
    //exibir anotacoes como outras imagens
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation{
            anotacaoView.image = #imageLiteral(resourceName: "player")
        }else{
            anotacaoView.image = #imageLiteral(resourceName: "pikachu-2")
        }
        
        var frame = anotacaoView.frame
        frame.size.height = 40
        frame.size.width = 40
        
        anotacaoView.frame = frame
        
        return anotacaoView
    }
    
    
    //tratando quando o usuario nega a autorização de localização
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse && status != .notDetermined{
            //alerta
            let alertController = UIAlertController(
                title: "Permissão de localização",
                message: "Para que você possa caçar pokemons, precisamos da sua lozalização! Por favor habilite.",
                preferredStyle: .alert)
            
            let acaoConfiguracoes = UIAlertAction(
                title: "Abrir Configurações",
                style: .default,
                handler: { (alertaConfiguracoes) in
                    
                    if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString){
                        UIApplication.shared.open(configuracoes as URL)
                    }
            })
            
            let acaoCancelar = UIAlertAction(
                title: "Cancelar",
                style: .default,
                handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    //centralizar o usuario no mapa e deixar o mapa livre para movimentação
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if contador < 3{
            
            self.centralizar()
            contador += 1
            
        }else{
            gerenciadorLocalizacao.stopUpdatingLocation()
        }
        
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func centralizar()
    {
        if let coordenadas = gerenciadorLocalizacao.location?.coordinate{
            let regiao = MKCoordinateRegionMakeWithDistance(coordenadas, 200, 200)
            mapa.setRegion(regiao, animated: true)
        }
    }
    
    @IBAction func centralizarJogador(_ sender: Any) {
        self.centralizar()
    }
    
    
    @IBAction func abrirPokedex(_ sender: Any) {
    }
    
    
}

