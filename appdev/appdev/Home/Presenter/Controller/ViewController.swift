//
//  ViewController.swift
//  appdev
//
//  Created by JIDTP1408 on 23/01/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var CameraCollection: UICollectionView!
    
    @IBOutlet weak var addBTBtn : UIButton!
    
    var selectedMedia: [Media] = []
    var allMedia: [Media] = []
    
    //BT Manager
    // Bluetooth Manager and Peripherals List
    var centralManager: CBCentralManager!
    var peripherals: [CBPeripheral] = []
    
    // TableView and Popup View for displaying peripherals
    var tableView: UITableView!

    var popupView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CameraCollection.dataSource = self
        CameraCollection.delegate = self
        CameraCollection.showsHorizontalScrollIndicator = false
        CameraCollection.register(CollectionViewCell().NibName(), forCellWithReuseIdentifier: CollectionViewCell().idendifier())

        CameraCollection.register(SectionHeader().NibName(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader().identy())

        selectedMedia = [
                   Media(name: "Image 1", image: UIImage(named: "image1")!),
                   Media(name: "Image 2", image: UIImage(named: "image2")!),
                   Media(name: "Image 5", image: UIImage(named: "image2")!),
                   Media(name: "Image 6", image: UIImage(named: "image2")!)
               ]
               
               allMedia = [
                   Media(name: "Image 3", image: UIImage(named: "image1")!),
                   Media(name: "Image 4", image: UIImage(named: "image2")!),
                   Media(name: "Image 7", image: UIImage(named: "image2")!),
                   Media(name: "Image 8", image: UIImage(named: "image2")!)
               ]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func AddCameraBtnAction(_sender:Any){
//        self.indicator()
//        DispatchQueue.main.async {
//            self.CameraCollection.reloadData()
//        }
    
        // BT Working ******
        //BTManager()
        
        // Wifi not connected *****
       // connectToWiFi(ssid: "siva", password: "12345678")
        
        // WebView *****
        self.addWebViewWithURL(urlString: "https://www.apple.com")

    }
    
    func addWebViewWithURL(urlString:String){
        
        let storyboard = UIStoryboard(name: "WebView", bundle: nil) // Replace "YourStoryboardName"
        if let webVC = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController { // Replace with your Storyboard ID
            webVC.urlString = urlString
            navigationController?.pushViewController(webVC, animated: true)
        }
       
    }

    func indicator(){
        // Show loading indicator with a custom message
        LoadingIndicator.shared.show(on: self.view, message: "Fetching data...")
        
        // Simulate a delay and hide loading indicator
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            LoadingIndicator.shared.hide()
        }
    }
    // Function to check if we are running on a simulator
       func isRunningOnSimulator() -> Bool {
           #if targetEnvironment(simulator)
           return true
           #else
           return false
           #endif
       }

}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return selectedMedia.count
        case 1:
            return allMedia.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell().idendifier(), for: indexPath) as! CollectionViewCell
        
        switch indexPath.section {
        case 0 :
            cell.configure(with: selectedMedia[indexPath.row])
        case 1:
            cell.configure(with: allMedia[indexPath.row])
        default:
            cell.configure(with: allMedia[indexPath.row])
        }
       
        return cell
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           
//           let fixedWidth = collectionView.bounds.width/2
//           
//           let dynamicHeight: CGFloat = CGFloat(100 + (indexPath.row * 30))  // Increasing height for each row
//           
//           return CGSize(width: fixedWidth, height: dynamicHeight)
//       }
    
    // MARK: - Section Header
        
        // This method is for configuring the section header
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            // Only configure header for the section
            guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
            
            // Dequeue the section header view
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader().identy(), for: indexPath) as! SectionHeader
            
            // Set the title for the section header
            if indexPath.section == 0 {
                headerView.configure(with: "Selected Media")
            } else {
                headerView.configure(with: "All Media")
            }
            
            return headerView
        }
        
        // MARK: - Section Header Size
        
        // This method sets the size for the section header
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: 50) // Fixed height for the section header
        }
    
}

// WIFI Connection
import NetworkExtension
extension ViewController {
    // Function to connect to Wi-Fi using NEHotspotConfigurationManager
    func connectToWiFi(ssid: String, password: String) {
        // Create a Hotspot Configuration object
        let configuration = NEHotspotConfiguration(ssid: ssid, passphrase: password, isWEP: false)
        
        // Apply the Wi-Fi configuration to connect
        NEHotspotConfigurationManager.shared.apply(configuration) { error in
            if let error = error {
                // Handle error
                print("Failed to connect to Wi-Fi: \(error.localizedDescription)")
            } else {
                // Successfully connected
                print("Successfully connected to Wi-Fi: \(ssid)")
            }
        }
    }	

}

import CoreBluetooth

extension ViewController : CBCentralManagerDelegate, UITableViewDataSource, UITableViewDelegate {
   
     func BTManager() {
         
         if isRunningOnSimulator() {
             let alertController = UIAlertController(title: "Bluetooth Connection", message: "Physical device only Have Connection", preferredStyle: .alert)
             
                    // Add a "Cancel" button to dismiss the alert
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                        print("Canceled")
                    }
                    alertController.addAction(cancelAction)
                    
                    // Present the alert
                    self.present(alertController, animated: true, completion: nil)
         }else{
             // Set up the central manager for Bluetooth scanning
             centralManager = CBCentralManager(delegate: self, queue: nil)
             
             // Set up the main view and UI components
             setupUI()
         }
      
    }
    
    // MARK: - Bluetooth Scanning Methods
    
    // Called when the Bluetooth state changes (e.g., powered on)
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            // Start scanning for peripherals if Bluetooth is powered on
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        case .poweredOff:
            print("Bluetooth is powered off.")
        case .resetting:
            print("Bluetooth is resetting.")
        case .unauthorized:
            print("Bluetooth is unauthorized.")
        case .unknown:
            print("Bluetooth state is unknown.")
        case .unsupported:
            print("Bluetooth is unsupported.")
        @unknown default:
            break
        }
    }
    
    // Called when a peripheral is discovered
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Only add peripherals that have a name to the list
        
              if let peripheralName = peripheral.name, !peripheralName.isEmpty {
                  // Avoid adding duplicate peripherals to the list
                  if !peripherals.contains(peripheral) {
                      peripherals.append(peripheral)
                      print(peripheral)
                      tableView.reloadData() // Reload the table view with the new peripheral
                  }
              }
    }
    
    // Called when the connection to a peripheral is successful
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to peripheral: \(peripheral.name ?? "Unknown")")
    }
    
    // MARK: - TableView Methods
    
    // Set up the popup view with a table view for displaying the peripherals
    func setupUI() {
        // Set up the main view and background
        view.backgroundColor = .white
        
        // Create the popup view that will hold the table view
                popupView = UIView()
        popupView.frame = CGRect(x: addBTBtn.layer.position.x, y: addBTBtn.layer.position.y + addBTBtn.frame.height + 10, width: self.view.frame.size.width * 3/4, height: self.view.frame.size.height * 3/4)
        popupView.center = self.view.center

                popupView.backgroundColor = .white
                popupView.layer.cornerRadius = 12
                popupView.layer.shadowColor = UIColor.black.cgColor
                popupView.layer.shadowOpacity = 0.3
                popupView.layer.shadowOffset = CGSize(width: 0, height: 4)
                popupView.layer.shadowRadius = 6
                
                // Add a close button to the popup view
        let closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
                closeButton.setTitle("Close", for: .normal)
                closeButton.setTitleColor(.black, for: .normal)
                closeButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
                popupView.addSubview(closeButton)
                
                // Create and set up the table view inside the popup view
        tableView = UITableView(frame: CGRect(x: 10, y: 40, width: popupView.frame.size.width -  40, height: popupView.frame.size.height - 100 ), style: .plain)
                tableView.dataSource = self
                tableView.delegate = self
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PeripheralCell")
                popupView.addSubview(tableView)
                
                // Add the popup view to the main view
                self.view.addSubview(popupView)
    }
    
    // MARK: - TableView DataSource and Delegate Methods
    
    // Number of rows in the table view (one row per peripheral)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }

    // Set up each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeripheralCell", for: indexPath)
        let peripheral = peripherals[indexPath.row]
        cell.textLabel?.text = peripheral.name ?? "Unnamed Peripheral"
        return cell
    }

    // Handle the selection of a peripheral in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = peripherals[indexPath.row]
        // Attempt to connect to the selected peripheral
        centralManager.connect(peripheral, options: nil)
    }
    
    // Called when the user taps the close button
    @objc func closePopup() {
        popupView.removeFromSuperview() // Remove the popup view
    }
}

