import UIKit

extension HomeProductViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productCart.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        
        cell.configureCell(
            product: productCart[index],
            addProduct: { [weak self] in
                self?.updateProduct(cellIndex: index)
            },
            removeProduct: { [weak self] in
                self?.updateProduct(cellIndex: index, isAdd: false)
            }
        )
        return cell
    }
    
}
