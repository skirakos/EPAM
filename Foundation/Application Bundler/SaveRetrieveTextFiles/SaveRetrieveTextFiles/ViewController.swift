//
//  ViewController.swift
//  SaveRetrieveTextFiles
//
//  Created by Seda Kirakosyan on 11.07.25.
//

import UIKit


class ViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Save & Retrieve Text"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter text to save"
        return tf
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return button
    }()

    private let retrieveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retrieve", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return button
    }()

    private let outputView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .label
        textView.backgroundColor = UIColor.systemGray6
        textView.layer.cornerRadius = 8
        textView.isEditable = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(saveButton)
        view.addSubview(retrieveButton)
        view.addSubview(outputView)

        setupUI()
    }

    func setupUI() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            saveButton.widthAnchor.constraint(equalTo: textField.widthAnchor, multiplier: 0.45),

            retrieveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            retrieveButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            retrieveButton.widthAnchor.constraint(equalTo: textField.widthAnchor, multiplier: 0.45),

            outputView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 24),
            outputView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            outputView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            outputView.heightAnchor.constraint(equalToConstant: 200)
        ])

        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        retrieveButton.addTarget(self, action: #selector(retrieve), for: .touchUpInside)
    }

    @objc func save() {
        guard let text = textField.text, !text.isEmpty else {
            print("No text to save")
            return
        }

        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not find documents directory")
            return
        }

        let fileURL = documentsURL.appendingPathComponent("savedText.txt")
        let newText = text + "\n"

        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let fileHandle = try FileHandle(forWritingTo: fileURL)
                defer { fileHandle.closeFile() }
                if let data = newText.data(using: .utf8) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                }
            } else {
                try newText.write(to: fileURL, atomically: true, encoding: .utf8)
            }

            print("Appended text to \(fileURL.path)")
            textField.text = ""
        } catch {
            print("Error saving file: \(error)")
        }
    }


    @objc func retrieve() {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                outputView.text = "Unable to locate documents directory"
                return
            }

        let fileURL = documentsURL.appendingPathComponent("savedText.txt")

        do {
            let text = try String(contentsOf: fileURL, encoding: .utf8)
            outputView.text = text
        } catch {
            outputView.text = "No file found or failed to load"
            print("Couldn't read file: \(error)")
        }
    }
}


#Preview {
    ViewController()
}
