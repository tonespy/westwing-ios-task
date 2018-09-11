import UIKit


/**
 The view which displays the list of campaigns. It is configured in the storyboard (Main.storyboard). The corresponding
 view controller is the `CampaignsListingViewController`.
 */
class CampaignListingView: UICollectionView {

    /**
     A strong reference to the view's data source. Needed because the view's dataSource property from UIKit is weak.
     */
    @IBOutlet var strongDataSource: UICollectionViewDataSource!

    /**
     All the possible cell types that are used in this collection view.
     */
    enum Cells: String {

        /** The cell which is used to display the loading indicator. */
        case loadingIndicatorCell

        /** The cell which is used to display a campaign. */
        case campaignCell
    }

    /**
     Displays the given campaign list.
     */
    func display(campaigns: CampaignList) {
        let campaignDataSource = ListingDataSource(campaigns: campaigns)
        dataSource = campaignDataSource
        delegate = campaignDataSource
        strongDataSource = campaignDataSource
        reloadData()
    }
}


/**
 The data source for the `CampaignsListingView` which is used to display the list of campaigns.
 */
class ListingDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    /** The campaigns that need to be displayed. */
    let campaigns: [Campaign]

    /**
     Designated initializer.

     - Parameter campaign: The campaigns that need to be displayed.
     */
    init(campaigns: [Campaign]) {
        self.campaigns = campaigns
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campaigns.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let campaign = campaigns[indexPath.item]
        let reuseIdentifier =  CampaignListingView.Cells.campaignCell.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let campaignCell = cell as? CampaignCell {
            campaignCell.moodImage = campaign.moodImage
            campaignCell.name = campaign.name
            campaignCell.descriptionText = campaign.description
        } else {
            assertionFailure("The cell should be CampaignCell")
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 450)
    }

}



/**
 The data source for the `CampaignsListingView` which is used while the actual contents are still loaded.
 */
class LoadingDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = CampaignListingView.Cells.loadingIndicatorCell.rawValue
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
