//
//  CarruselPoster.swift
//  Toolbox Test
//
//  Created by Edward Pizzurro Fortun on 2/11/21.
//

import UIKit
import Foundation

class CarruselCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        drawTriangleLeft()
        drawTriangleRight()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
        iv.clipsToBounds = false
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.text = "JOJOJO"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerViewLeft: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerViewRight: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func drawTriangleLeft() {
            
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.opacity = 0.6
        
        containerViewRight.layer.addSublayer(shapeLayer)
    }
    
    func drawTriangleRight() {
            
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.opacity = 0.6
        
        containerViewLeft.layer.addSublayer(shapeLayer)
    }

    
    
    func setupViews() {
        
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(containerViewLeft)
        containerViewLeft.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerViewLeft.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerViewLeft.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerViewLeft.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(containerViewRight)
        containerViewRight.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerViewRight.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerViewRight.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerViewRight.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

