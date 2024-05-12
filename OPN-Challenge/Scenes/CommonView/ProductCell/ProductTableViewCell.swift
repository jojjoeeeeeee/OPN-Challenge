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
    @IBOutlet private weak var quantityEditStackView: UIStackView!
    @IBOutlet private weak var quantityView: UIView!
    @IBOutlet private weak var quantityViewLabel: UILabel!
    @IBOutlet private weak var totalProductPriceLabel: UILabel!
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
        quantityView.roundCorner(cornerRadius: 8)
        quantityView.layer.borderWidth = 1
        quantityView.layer.borderColor = UIColor.lightGreyPrimary.cgColor
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
        
        quantityEditStackView.isHidden = false
        priceLabel.isHidden = false
        quantityView.isHidden = true
        totalProductPriceLabel.isHidden = true
    }
    
    public func configureCellSummary(product: HomeProduct.Product) {
        titleLabel.text = product.name
        priceLabel.text = "฿\(product.price)"
        ImageUtils.setImageWithUrl(
            imageView: menuImageView,
            url: product.imageUrl
        )
        amountLabel.text = "\(product.amount)"
        quantityEditStackView.isHidden = true
        priceLabel.isHidden = true
        quantityView.isHidden = false
        totalProductPriceLabel.isHidden = false
        quantityViewLabel.text = "\(product.amount)"
        totalProductPriceLabel.text = "฿\(product.price * product.amount)"
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
