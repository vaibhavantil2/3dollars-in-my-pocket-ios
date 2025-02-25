import UIKit

import Common
import Model
import Log

public final class FaqViewController: BaseViewController {
    public override var screenName: ScreenName {
        return viewModel.output.screenName
    }
    
    private let faqView = FaqView()
    private let viewModel: FaqViewModel
    
    init(viewModel: FaqViewModel = FaqViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = faqView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.input.load.send(())
    }
    
    public override func bindEvent() {
        faqView.backButton.controlPublisher(for: .touchUpInside)
            .receive(on: DispatchQueue.main)
            .withUnretained(self)
            .sink { (owner: FaqViewController, _) in
                owner.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
    }
    
    public override func bindViewModelInput() {
        faqView.categoryView.didSelectCategory
            .subscribe(viewModel.input.filterCategory)
            .store(in: &cancellables)
    }
    
    public override func bindViewModelOutput() {
        viewModel.output.faqCategory
            .dropFirst()
            .withUnretained(self)
            .main
            .sink { (owner: FaqViewController, categories: [FaqCategoryResponse]) in
                owner.faqView.categoryView.bind(categories: categories)
                owner.faqView.updateCategoryViewHeight(categories: categories)
            }
            .store(in: &cancellables)
        
        viewModel.output.faqSections
            .dropFirst()
            .withUnretained(self)
            .main
            .sink { (owner: FaqViewController, faqs: [[FaqResponse]]) in
                owner.faqView.faqCollectionView.bind(faqs)
            }
            .store(in: &cancellables)
    }
}
