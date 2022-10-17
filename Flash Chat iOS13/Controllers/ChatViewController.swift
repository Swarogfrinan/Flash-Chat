import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var  messages: [Message] = []
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "⚡️FlashChat"
        setTableView()
        loadMessages()
        navigationItem.hidesBackButton = true
    }
    // MARK: - Action
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if  let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField : Date().timeIntervalSince1970
            ]) {
                (error) in
                if let e = error {
                    print("There was an issue saving data to firestore. \(e)")
                } else {
                    print("Succesfully saved data")
                }
            }
        }
    }
    
    
    @IBAction func logOutBarButtonPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOurError as NSError {
            print("Error signing out: %@", signOurError)
        }
    }
}

    // MARK: - Private methods

    private extension ChatViewController {
        func loadMessages() {
            
            db.collection(K.FStore.collectionName)
                .order(by: K.FStore.dateField)
                .addSnapshotListener { querySnapshot, error in
                self.messages = []
                if let e = error {
                    print("There was an issue retrieving data from Firestore, \(e)" )
                } else {
                    if let  snapshotDocuments = querySnapshot?.documents {
                        for documents in snapshotDocuments {
                            let data = documents.data()
                            if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
        
        func setTableView() {
            tableView.dataSource = self
            tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        }
    }

// MARK: - UITableViewDataSource

extension ChatViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
}

// MARK: - UITableViewDataSource

extension ChatViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
