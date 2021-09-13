//
//  addView.swift
//  NotasBD
//
//  Created by Camilo Rozo on 12/09/21.
//

import UIKit

class addView: UIViewController {
    
    //MARK: - references outlets
    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var nota: UITextView!
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var boton: UIButton!
    
    var notas: Notas!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = notas != nil ? "Editar Nota" : "Crear Nota"
        titulo.text = notas?.titulo
        nota.text = notas?.nota
        fecha.date = notas?.fecha ?? Date()
    }
    
    //MARK: - references actions
    @IBAction func guardar (_ sender: UIButton) {
        Modelo.shared.saveData(titulo: titulo.text ?? "", nota: nota.text, fecha: fecha.date)
        navigationController?.popViewController(animated: true)
    }

}
