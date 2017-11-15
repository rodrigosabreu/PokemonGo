//
//  PokemonAnotacao.swift
//  PokemonGo
//
//  Created by Rodrigo Abreu on 15/11/2017.
//  Copyright © 2017 Rodrigo Abreu. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnotacao: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordenadas: CLLocationCoordinate2D){
        self.coordinate = coordenadas
    }
    
}
