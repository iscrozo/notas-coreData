//
//  Home.swift
//  NotasBD
//
//  Created by Camilo Rozo on 12/09/21.
//

import UIKit
import CoreData

class Home: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tabla: UITableView!
    var notas = [Notas]()
    var fetchResultController: NSFetchedResultsController<Notas>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        mostrarNotas()
    }
    
    // NSFetchResult
    // codigo para mostra los datos
    func mostrarNotas() {
        let contexto = Modelo.shared.contexto()
        let fetchRequest: NSFetchRequest<Notas> = Notas.fetchRequest()
        let order = NSSortDescriptor(key: "titulo", ascending: true)
        fetchRequest.sortDescriptors = [order]
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try  fetchResultController.performFetch()
            notas = fetchResultController.fetchedObjects!
        } catch let aobError {
            print("Error en \(aobError.localizedDescription)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tabla.beginUpdates() // busca las actualizaciones
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tabla.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tabla.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.tabla.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.tabla.reloadRows(at: [indexPath!], with: .fade)
        default:
            self.tabla.reloadData()
        }
        self.notas = controller.fetchedObjects as! [Notas]
    }
}
//MARK: - UITableViewDelegate
extension Home: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
//MARK: -UITableViewDataSource
extension Home: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDefault = UITableViewCell()
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let notas = notas[indexPath.row]
        cell.textLabel?.text = notas.titulo
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale.current
        cell.detailTextLabel?.text = dateFormatter.string(from: notas.fecha ?? Date())
        return cell
        
    }
}
