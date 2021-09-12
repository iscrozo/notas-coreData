//
//  Modelo.swift
//  NotasBD
//
//  Created by Camilo Rozo on 12/09/21.
//

import Foundation
import CoreData
import UIKit

class Modelo {
    
    public static let shared = Modelo()
    
    func contexto() -> NSManagedObjectContext {
        // contexto o conexion con la BD
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    func saveData(titulo: String, nota: String, fecha: Date) {
        let context = contexto()
        var entityNotas = NSEntityDescription.insertNewObject(forEntityName: "Notas", into: context) as! Notas
        entityNotas.titulo = titulo
        entityNotas.nota = nota
        entityNotas.fecha = fecha
        do {
            try context.save()
            print("Guardo registro ")
        } catch let error as NSError {
            print("Error en SaveData -> no guardo, \(error.localizedDescription)")
        }
    }
    
    
}
