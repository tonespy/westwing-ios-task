import UIKit
import RxSwift


/**
 The view controller responsible for listing all the campaigns. The corresponding view is the `CampaignListingView` and
 is configured in the storyboard (Main.storyboard).
 */
class CampaignListingViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet
    private(set) weak var typedView: CampaignListingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(typedView != nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Load the campaign list and display it as soon as it is available.
        self.loadCampaignData()
    }
    
    private func loadCampaignData() {
        ServiceLocator.instance.networkingService
            .createObservableResponse(request: CampaignListingRequest())
            .observeOn(MainScheduler.instance)
            .retryWhen({ (e: Observable<Error>) -> Observable<Void> in
                return e.flatMap({ [weak self] (error: Error) -> Observable<Void> in
                    guard let self = self else { return Observable.empty() }
                    // Check for any internet connectivity related errors
                    if let _ = error as? InternetConnectionError {
                        // Create and return retry observer
                        return self.retryObservable()
                    }
                    
                    // Check for networking related error
                    return Observable.empty()
                })
            })
            .subscribe(onNext: { [weak self] campaigns in
                self?.typedView.display(campaigns: campaigns)
            })
            .addDisposableTo(disposeBag)
    }
    
    private func retryObservable() -> Observable<Void> {
        return Observable<Void>.create{observer in
            
            ErrorLoader.sharedInstance.genericInitialze(show: true, completion: {
                observer.onNext(())
                observer.onCompleted()
            })
            
            return Disposables.create {
                ErrorLoader.sharedInstance.genericInitialze(show: false, completion: {})
            }
        }.observeOn(MainScheduler.instance)
    }
}
