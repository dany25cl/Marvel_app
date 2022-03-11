//
//  MainListView.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//  
//

import Foundation
import UIKit
import SDWebImage

class MainListView: UIViewController {

    // MARK: Properties
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var filterName: UITextField!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var vHeader: UIView!
    
    // Paginator
    @IBOutlet weak var vPaginator: UIView!
    @IBOutlet weak var btnFisrt: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btnLast: UIButton!

    @IBAction func paginatorAction(_ sender: UIButton) {
        if (sender == btnFisrt){
            if (actualPage > 1){
                actualPage = 1
                filter()
            }
        }
        else if (sender == btnLast){
            if (actualPage < totalPages){
                actualPage = totalPages
                filter()
            }
        }
        else
        {
            if let newPage = Int(sender.titleLabel?.text ?? ""){
                actualPage = newPage;
                filter()
            }
        }
    }
    
    var presenter: MainListPresenterProtocol?
    var tableData: [MainListModel] = []
    var actualPage: Int = 1
    var totalPages: Int = 1
    var nameFilter: String?
    
    @IBAction func filter(_ sender: Any) {
        filter()
    }
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // The Logic must be in the presenter
        presenter?.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(rgb: Utils.MARVEL_COLORS.RED.rawValue)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Marvel", size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .bold)]
        
        self.title = "MARVEL"
        self.view.backgroundColor = UIColor.init(rgb: Utils.MARVEL_COLORS.RED.rawValue)
        
        vHeader.backgroundColor = UIColor.init(rgb: Utils.MARVEL_COLORS.BLUE.rawValue)
        
        btnFilter.layer.cornerRadius = 6
        btnFilter.backgroundColor = UIColor.init(rgb: Utils.MARVEL_COLORS.RED.rawValue)
        
        table.register(UINib(nibName: "MainListCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
        table.backgroundColor = UIColor.init(rgb: Utils.MARVEL_COLORS.BLUE.rawValue)
        
        //self.table.refreshControl?.beginRefreshing()
        //self.table.refreshControl?.isHidden = false
        paginatorInitialConfig()
        
        presenter?.reloadData(page: 1, name: nil)
    }
    
    @objc func callPullToRefresh(){
        self.reloadData();
    }
    
    func filter(){
        let lastFilteredName = nameFilter;
        
        self.nameFilter = filterName.hasText ? filterName.text : nil;
        
        if (nameFilter != lastFilteredName){
            actualPage = 1
        }
        
        self.reloadData()
    }
    
    func reloadData(){
        filterName.resignFirstResponder()
        presenter?.reloadData(page: actualPage, name: nameFilter)
    }
    
    func paginatorInitialConfig(){
        let buttons = [btn1, btn2, btn3, btn4, btn5]
        
        buttons.forEach { $0?.layer.cornerRadius = 20 }
        
        configPaginator()
    }
    
    func configPaginator(){
        let buttons = [btn1, btn2, btn3, btn4, btn5]
        
        buttons.forEach {
            $0?.backgroundColor = UIColor.clear
            $0?.setTitleColor(UIColor.black, for: .normal)
            $0?.isEnabled = true
        }
        
        let initialValue = actualPage <= 3 ? 1 : actualPage >= totalPages - 2 ? max(totalPages - 4, 1) : actualPage - 2
        
        var i = initialValue
        for btn in buttons {
            btn?.setTitle("\(i)", for: .normal)
            if (i > totalPages){
                btn?.isEnabled = false;
            }
            if(i == actualPage){
                btn?.backgroundColor = UIColor(rgb:Utils.MARVEL_COLORS.RED.rawValue)
                btn?.setTitleColor(UIColor.white, for: .normal)
            }
            i += 1
        }
    }
}

extension MainListView: MainListViewProtocol {
    func didReceivedError(_ error: Error) {
        print(error)
        self.showAlert()
    }    
    
    func loadCharacters(_ data: [MainListModel], actualPage: Int, totalPages: Int) {
        self.tableData = data;
        self.actualPage = actualPage
        self.totalPages = totalPages;
        
        DispatchQueue.main.async {
            self.configPaginator()
            self.table.reloadData()
        }
    }
    
    func startActivityAnimation(){
        DispatchQueue.main.async {
            self.table.refreshControl?.beginRefreshing()
            self.table.refreshControl?.isHidden = false
        }
    }
    
    func stopActivityAnimation(){
        DispatchQueue.main.async {
            self.table.refreshControl?.endRefreshing()
            self.table.refreshControl?.isHidden = true
        }
    }
}

extension MainListView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.filter()
        return false
    }
}

extension MainListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? MainListTableViewCell else{
            fatalError("The dequed cell is not an instance of MainListTableViewCell")
        }
        
        let data = tableData[indexPath.row]
        
        cell.lbl_name.text = data.name;
        cell.imgThumbnail.sd_setImage(with: URL(string: data.imgPath), placeholderImage: UIImage(named: "UnknownUser"))
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.presentDetailView(with: tableData[indexPath.row].id)
    }
}
