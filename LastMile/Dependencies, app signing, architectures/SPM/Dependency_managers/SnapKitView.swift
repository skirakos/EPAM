//
//  SnapKitView.swift
//  Dependency_managers
//
//  Created by Vadzim Mikalayeu on 26/03/2025.
//

import SwiftUI
import SnapKit

struct SnapKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = "Hello from SnapKit"
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.textColor = .white

        container.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

