//
//  ProductTableViewCell.swift
//  OPN-Challenge
//
//  Created by A667209 A667209 on 12/5/2567 BE.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    static let identifier = "ProductTableViewCell"
    
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var menuImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var removeProductButton: UIButton!
    @IBOutlet private weak var addProductButton: UIButton!
    
    private var addProduct: (() -> ())?
    private var removeProduct: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        cellView.roundCorner(cornerRadius: 8)
        cellView.addShadow(
            withCornerRadius: 12,
            shadowRadius: 4,
            masksToBounds: false
        )
        menuImageView.roundCorner(cornerRadius: 8)
    }
    
    public func configureCell(product: HomeProduct.Product, addProduct: (() -> ())?, removeProduct: (() -> ())?) {
        titleLabel.text = product.name
        priceLabel.text = "฿\(product.price)"
        ImageUtils.setImageWithUrl(
            imageView: menuImageView,
            url: product.imageUrl
        )
        amountLabel.text = "\(product.amount)"
        self.addProduct = addProduct
        self.removeProduct = removeProduct
        
        addProductButton.tintColor = .systemGreen
        
        if product.amount > 0 {
            removeProductButton.tintColor = .systemRed
        }
        
        if product.amount == 0 {
            removeProductButton.tintColor = .lightGray
        } else if product.amount == 99 {
            addProductButton.tintColor = .lightGray
        }
    }
    
    @IBAction func onTappedRemoveProduct(_ sender: Any) {
        guard let action = removeProduct else {
            return
        }
        action()
    }
    @IBAction func onTappedAddProduct(_ sender: Any) {
        guard let action = addProduct else {
            return
        }
        action()
    }
    
}
