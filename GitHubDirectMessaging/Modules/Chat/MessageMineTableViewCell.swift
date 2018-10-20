import Foundation
import UIKit

final class MessageMineTableViewCell: UITableViewCell {

    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()




    private let textMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        mainView.addSubview(textMessageLabel)

        contentView.addSubview(mainView)
        layoutComponents()
    }

    private func layoutComponents() {
        mainView.backgroundColor = .red
        textMessageLabel.backgroundColor = .green
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 999, height: 999))
        NSLayoutConstraint.activate([


            //textMessageLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            //textMessageLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant: 5),
            //textMessageLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 5),
           // textMessageLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),

           // mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            //mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 5),
            //mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
          //  mainView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20)

            ])
    }

    func configure(message: Message) {

        textLabel?.text = message.body

    }
}
