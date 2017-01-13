//
//  CCCreateCloud.swift
//  Nextcloud
//
//  Created by Marino Faggiana on 09/01/17.
//  Copyright © 2017 TWS. All rights reserved.
//
//  Author Marino Faggiana <m.faggiana@twsweb.it>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import Foundation

// MARK: - CreateMenuAdd

class CreateMenuAdd: NSObject {
    
    let fontButton = [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 14)!, NSForegroundColorAttributeName:UIColor(colorLiteralRed: 65.0/255.0, green: 64.0/255.0, blue: 66.0/255.0, alpha: 1.0)]
    let fontEncrypted = [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 14)!, NSForegroundColorAttributeName:UIColor(colorLiteralRed: 241.0/255.0, green: 90.0/255.0, blue: 34.0/255.0, alpha: 1.0)]
    let fontCancel = [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 16)!, NSForegroundColorAttributeName:UIColor(colorLiteralRed: 0.0/255.0, green: 130.0/255.0, blue: 201.0/255.0, alpha: 1.0)]
    let fontDisable = [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 12)!, NSForegroundColorAttributeName:UIColor(colorLiteralRed: 65.0/255.0, green: 64.0/255.0, blue: 66.0/255.0, alpha: 1.0)]

    let colorLightGray = UIColor(colorLiteralRed: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
    
    func createMenuPlain(view : UIView) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let actionSheet = AHKActionSheet.init(view: view, title: nil)
        
        actionSheet?.animationDuration = 0.2
        actionSheet?.automaticallyTintButtonImages = 0
        
        actionSheet?.blurRadius = 0.0
        actionSheet?.blurTintColor = UIColor(white: 0.0, alpha: 0.50)
        
        actionSheet?.buttonHeight = 50.0
        actionSheet?.cancelButtonHeight = 50.0
        actionSheet?.separatorHeight = 5.0
        
        actionSheet?.selectedBackgroundColor = UIColor(colorLiteralRed: 0.0/255.0, green: 130.0/255.0, blue: 201.0/255.0, alpha: 0.1)
        actionSheet?.separatorColor = UIColor(colorLiteralRed: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 0.2)
        
        actionSheet?.buttonTextAttributes = fontButton
        actionSheet?.encryptedButtonTextAttributes = fontEncrypted
        actionSheet?.cancelButtonTextAttributes = fontCancel
        actionSheet?.disableButtonTextAttributes = fontDisable
        
        actionSheet?.cancelButtonTitle = NSLocalizedString("_cancel_", comment: "")

        actionSheet?.addButton(withTitle: NSLocalizedString("_create_folder_", comment: ""), image: UIImage(named: "createFolderNextcloud"), backgroundColor: UIColor.white, height: 50.0 ,type: AHKActionSheetButtonType.default, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnCreateFolderPlain))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_upload_photos_videos_", comment: ""), image: UIImage(named: "uploadPhotoNextcloud"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.default, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnCreateFotoVideoPlain))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_upload_file_", comment: ""), image: UIImage(named: "uploadFileNextcloud"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.default, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnCreateFilePlain))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_upload_encrypted_mode", comment: ""), image: UIImage(named: "actionSheetLock"), backgroundColor: colorLightGray, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            self.createMenuEncrypted(view: view)
        })
        
        actionSheet?.show()
        
        CCUtility.setCreateMenuEncrypted(false)
    }
    
    func createMenuEncrypted(view : UIView) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let actionSheet = AHKActionSheet.init(view: view, title: nil)
        
        actionSheet?.animationDuration = 0.2
        
        actionSheet?.blurRadius = 0.0
        actionSheet?.blurTintColor = UIColor(white: 0.0, alpha: 0.50)

        actionSheet?.buttonHeight = 50.0
        actionSheet?.cancelButtonHeight = 50.0
        actionSheet?.separatorHeight = 5.0
        
        actionSheet?.selectedBackgroundColor = UIColor(colorLiteralRed: 0.0/255.0, green: 130.0/255.0, blue: 201.0/255.0, alpha: 0.1)
        actionSheet?.separatorColor = UIColor(colorLiteralRed: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 0.2)

        actionSheet?.buttonTextAttributes = fontButton
        actionSheet?.encryptedButtonTextAttributes = fontEncrypted
        actionSheet?.cancelButtonTextAttributes = fontCancel
        actionSheet?.disableButtonTextAttributes = fontDisable
        
        actionSheet?.cancelButtonTitle = NSLocalizedString("_cancel_", comment: "")
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_create_folder_", comment: ""), image: UIImage(named: "foldercrypto"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnCreateFolderEncrypted))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_upload_photos_videos_", comment: ""), image: UIImage(named: "photocrypto"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnCreateFotoVideoEncrypted))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_upload_file_", comment: ""), image: UIImage(named: "importCloudCrypto"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnCreateFileEncrypted))
        })

        actionSheet?.addButton(withTitle: NSLocalizedString("_upload_template_", comment: ""), image: UIImage(named: "template"), backgroundColor: colorLightGray, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            self.createMenuTemplate(view: view)
        })

        actionSheet?.addButton(withTitle: NSLocalizedString("_upload_plain_mode", comment: ""), image: UIImage(named: "uploadPlainModeNextcloud"), backgroundColor: colorLightGray, height: 50.0, type: AHKActionSheetButtonType.default, handler: {(AHKActionSheet) -> Void in
            self.createMenuPlain(view: view)
        })
        
        actionSheet?.show()
        
        CCUtility.setCreateMenuEncrypted(true)
    }

    func createMenuTemplate(view : UIView) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let actionSheet = AHKActionSheet.init(view: view, title: nil)
        
        actionSheet?.animationDuration = 0.2
        
        actionSheet?.blurRadius = 0.0
        actionSheet?.blurTintColor = UIColor(white: 0.0, alpha: 0.50)

        actionSheet?.buttonHeight = 50.0
        actionSheet?.cancelButtonHeight = 50.0
        actionSheet?.separatorHeight = 5.0
        
        actionSheet?.selectedBackgroundColor = UIColor(colorLiteralRed: 0.0/255.0, green: 130.0/255.0, blue: 201.0/255.0, alpha: 0.1)
        actionSheet?.separatorColor = UIColor(colorLiteralRed: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 0.2)

        actionSheet?.buttonTextAttributes = fontButton
        actionSheet?.encryptedButtonTextAttributes = fontEncrypted
        actionSheet?.cancelButtonTextAttributes = fontCancel
        actionSheet?.disableButtonTextAttributes = fontDisable
        
        actionSheet?.cancelButtonTitle = NSLocalizedString("_cancel_", comment: "")
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_add_notes_", comment: ""), image: UIImage(named: "note"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnNote))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_add_web_account_", comment: ""), image: UIImage(named: "baseurl"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnAccountWeb))
        })
        
        actionSheet?.addButton(withTitle: "", image: nil, backgroundColor: UIColor(colorLiteralRed: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1), height: 10.0, type: AHKActionSheetButtonType.disabled, handler: {(AHKActionSheet) -> Void in
            print("disable")
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_add_credit_card_", comment: ""), image: UIImage(named: "cartadicredito"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnCartaDiCredito))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_add_atm_", comment: ""), image: UIImage(named: "bancomat"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnBancomat))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_add_bank_account_", comment: ""), image: UIImage(named: "contocorrente"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnContoCorrente))
        })
        
        actionSheet?.addButton(withTitle: "", image: nil, backgroundColor: UIColor(colorLiteralRed: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1), height: 10.0, type: AHKActionSheetButtonType.disabled, handler: {(AHKActionSheet) -> Void in
            print("disable")
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_add_driving_license_", comment: ""), image: UIImage(named: "patenteguida"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnPatenteGuida))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_add_id_card_", comment: ""), image: UIImage(named: "cartaidentita"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnCartaIdentita))
        })
        
        actionSheet?.addButton(withTitle: NSLocalizedString("_add_passport_", comment: ""), image: UIImage(named: "passaporto"), backgroundColor: UIColor.white, height: 50.0, type: AHKActionSheetButtonType.encrypted, handler: {(AHKActionSheet) -> Void in
            appDelegate.activeMain.returnCreate(Int(returnPassaporto))
        })
        
        actionSheet?.show()
    }

}

// MARK: - CreateFormUpload

class CreateFormUpload: XLFormViewController, CCMoveDelegate {
    
    var localServerUrl : String?
    var titleLocalServerUrl : String?
    var assets: NSMutableArray = []
    var cryptated : Bool?
    var session : String?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    convenience init(_ titleLocalServerUrl : String?, localServerUrl : String?, assets : NSMutableArray?, cryptated : Bool, session : String?) {
        
        self.init()
        
        if titleLocalServerUrl == nil || titleLocalServerUrl?.isEmpty == true {
            self.titleLocalServerUrl = "/" //NSLocalizedString("_root_", comment: "")
        } else {
            self.titleLocalServerUrl = titleLocalServerUrl
        }
        
        self.localServerUrl = localServerUrl
        self.assets = assets!
        self.cryptated = cryptated
        self.session = session
        
        self.initializeForm()
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        let cancelButton : UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("_cancel_", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancel))
        
        let saveButton : UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("_save_", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(save))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func initializeForm() {

        let form : XLFormDescriptor = XLFormDescriptor() as XLFormDescriptor
        form.rowNavigationOptions = XLFormRowNavigationOptions.stopDisableRow

        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor

        // Section: Destination Folder
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "ButtonDestinationFolder", rowType: XLFormRowDescriptorTypeButton, title: self.titleLocalServerUrl)
        row.cellConfig.setObject(UIImage(named: image_settingsManagePhotos)!, forKey: "imageView.image" as NSCopying)
        row.action.formSelector = #selector(changeDestinationFolder(_:))
        section.addFormRow(row)
        
        // Section: Folder Photo
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "useFolderPhoto", rowType: XLFormRowDescriptorTypeBooleanSwitch, title: NSLocalizedString("_photo_camera_", comment: ""))
        row.value = 0
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: "useSubFolder", rowType: XLFormRowDescriptorTypeBooleanSwitch, title: NSLocalizedString("_upload_camera_create_subfolder_", comment: ""))
        row.hidden = "$\("useFolderPhoto") == 0"
        
        if CCCoreData.getCameraUploadCreateSubfolderActiveAccount(appDelegate.activeAccount) == true {
            row.value = 1
        } else {
            row.value = 0
        }
        section.addFormRow(row)

        // Section: Rename File Name
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: "maskFileName", rowType: XLFormRowDescriptorTypeName, title: NSLocalizedString("_filename_", comment: ""))
        section.addFormRow(row)
        
        self.form = form
    }
    
    //MARK: XLFormDescriptorDelegate
    
    override func formRowDescriptorValueHasChanged(_ formRow: XLFormRowDescriptor!, oldValue: Any!, newValue: Any!) {
        
        super.formRowDescriptorValueHasChanged(formRow, oldValue: oldValue, newValue: newValue)
        
        if formRow.tag == "useFolderPhoto" {
            
            if (formRow.value! as AnyObject).boolValue  == true {
                
                let buttonDestinationFolder : XLFormRowDescriptor  = self.form.formRow(withTag: "ButtonDestinationFolder")!
                buttonDestinationFolder.hidden = true
                
            } else{
                
                let buttonDestinationFolder : XLFormRowDescriptor  = self.form.formRow(withTag: "ButtonDestinationFolder")!
                buttonDestinationFolder.hidden = false
            }
        }
        else if formRow.tag == "useSubFolder" {
            
            if (formRow.value! as AnyObject).boolValue  == true {
            
            } else{
                
            }
        }
        else if formRow.tag == "maskFileName" {
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var returnTitle : String?
        
        if section == 0 {
            let buttonDestinationFolder : XLFormRowDescriptor  = self.form.formRow(withTag: "ButtonDestinationFolder")!
            if buttonDestinationFolder.isHidden() {
                returnTitle = ""
            } else {
                returnTitle = NSLocalizedString("_destination_folder_", comment: "")
            }
        }
        
        if section == 1 {
            returnTitle = NSLocalizedString("_use_folder_photos_", comment: "")
        }
        
        if section == 2 {
            returnTitle = NSLocalizedString("_rename_filename_", comment: "")
        }
        
        return returnTitle
    }

    func reloadForm() {
        
        self.form.delegate = nil
        
        let buttonDestinationFolder : XLFormRowDescriptor  = self.form.formRow(withTag: "ButtonDestinationFolder")!
        buttonDestinationFolder.title = self.titleLocalServerUrl
        
        self.tableView.reloadData()
        self.form.delegate = self
    }
    
    func changeDestinationFolder(_ sender: XLFormRowDescriptor) {
        
        self.deselectFormRow(sender)
        
        let storyboard : UIStoryboard = UIStoryboard(name: "CCMove", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "CCMove") as! UINavigationController
        let viewController : CCMove = navigationController.topViewController as! CCMove
        
        viewController.delegate = self;
        viewController.tintColor = UIColor.init(colorLiteralRed: 0.0/255.0, green: 130.0/255.0, blue: 201.0/255.0, alpha: 1.0) // COLOR_BRAND
        viewController.barTintColor = UIColor.init(colorLiteralRed: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0) // COLOR_BAR;
        viewController.tintColorTitle = UIColor.init(colorLiteralRed: 65.0/255.0, green: 64.0/255.0, blue: 66.0/255.0, alpha: 1.0) // COLOR_GRAY;
        viewController.move.title = NSLocalizedString("_select_", comment: "");
        viewController.networkingOperationQueue =  appDelegate.netQueue 

        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func move(_ serverUrlTo: String!, title: String!, selectedMetadatas: [Any]!) {
        
        self.localServerUrl = serverUrlTo
        if title == nil {
            self.titleLocalServerUrl = "/"
        } else {
            self.titleLocalServerUrl = title
        }
        
        self.reloadForm()
    }
    
    func save() {
        
        self.dismiss(animated: true, completion: {
            
            let useFolderPhotoRow : XLFormRowDescriptor  = self.form.formRow(withTag: "useFolderPhoto")!
            let useSubFolderRow : XLFormRowDescriptor  = self.form.formRow(withTag: "useSubFolder")!
            var useSubFolder : Bool = false
            
            if (useFolderPhotoRow.value! as AnyObject).boolValue == true {
                self.localServerUrl = CCCoreData.getCameraUploadFolderNamePathActiveAccount(self.appDelegate.activeAccount, activeUrl: self.appDelegate.activeUrl, typeCloud: self.appDelegate.typeCloud)
                useSubFolder = (useSubFolderRow.value! as AnyObject).boolValue
            }
            
            self.appDelegate.activeMain.uploadFileAsset(self.assets, serverUrl: self.localServerUrl, cryptated: self.cryptated!, useSubFolder: useSubFolder, session: self.session)
        })
    }

    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}


