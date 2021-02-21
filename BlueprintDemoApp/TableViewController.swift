//
//  TableViewController.swift
//  BlueprintDemoApp
//
//  Created by Mindy Long on 2/4/21.
//

import UIKit
import SwiftUI

class MovieTableViewController: UITableViewController {

    var movieParser = Movies()
    var movieData: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ** Let's register a UITableViewCell here
        // YOUR CODE HERE //
        self.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.cellId)
        
        // ////////////// //
        
        // Subscribing to a delegate (basically adding itself as a listener)
        movieParser.loadDelegate = self
        
        fetchData()
        reloadPage()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK (not a person): - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }

    // This function returns a type of cell that will be displayed at the given indexPath (row, column).
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // As you scroll down a tableView, the cells that appear or that will appear will be "dequed", which means that they will be processed and returned as a specific instance of a UITableViewCell.
        // It's important to note that not all cells are dequed at once. Only the cells that are about to be scrolled to/displayed on screen are dequed. This helps with performance.
        // Also note the "withIdentifier" parameter here. Each UITableViewCell will have a unique identifier, which we'll get to later in this session.
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellId, for: indexPath) as! MovieTableViewCell

        // Configure the cell...
        let index = indexPath.row
        let movie = self.movieData[index]
        cell.title.text = movie.title
        cell.overview.text = movie.overview
        cell.rating.text = movie.rating + "/10"
        cell.releaseDate.text = movie.releaseDate
        
        // load image
        let imageURL = URL(string: movie.image)!
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                let img = UIImage(data: data)
                cell.poster.contentMode = .scaleAspectFit
                cell.poster.image = img
            }
            
        }
        
        
        
        cell.setupViews()
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// Extension for fetching data
extension MovieTableViewController {
    
    func fetchData() {
        movieParser.getData()
        self.movieData = movieParser.getMovies()
        print(self.movieData.count)
    }
    
    func reloadPage() {
        self.tableView.reloadData()
    }
    
}

// Explained more in depth on "httpRequests" branch
extension MovieTableViewController: LoadDelegate {
    
    func didFinishLoadData(finished: Bool) {
        if finished {
            reloadPage()
        } else {
            resendRequest()
        }
    }
    
    func resendRequest() {
        fetchData()
        reloadPage()
    }
}

// /////////////////////////////////////// //
// Remember to setup your content preview! //
// /////////////////////////////////////// //
import SwiftUI

struct TablePreview: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(.all)
        }
    }
    
    struct ContainerView: UIViewControllerRepresentable {

            func makeUIViewController(context: UIViewControllerRepresentableContext<TablePreview.ContainerView>) -> UIViewController {
                return UINavigationController(rootViewController: MovieTableViewController())
            }

            func updateUIViewController(_ uiViewController: TablePreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TablePreview.ContainerView>) {

            }

        }
}
