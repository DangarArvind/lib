//
//  AppConstant.swift
//  WMA
//
//  Created by tasol on 1/12/16.
//  Copyright © 2016 tasol. All rights reserved.
//

import Foundation

extension String {
    
    var html2AttributedString: NSAttributedString? {
        guard
            let data = dataUsingEncoding(NSUTF8StringEncoding)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String
        {
            return html2AttributedString?.string ?? ""
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height : CGFloat , font : UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: CGFloat.max, height: height)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.width
    }
    
    var extractYoutubeIdFromLink: String?
        {
            let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
            guard let regExp = try? NSRegularExpression(pattern: pattern, options: .CaseInsensitive) else {
                return nil
            }
            let nsLink = self as NSString
            let options = NSMatchingOptions(rawValue: 0)
            let range = NSRange(location: 0,length: nsLink.length)
            let matches = regExp.matchesInString(self as String, options:options, range:range)
            if let firstMatch = matches.first {
                print(firstMatch)
                
                if firstMatch.range.length == 11
                {
                    return nsLink.substringWithRange(firstMatch.range)
                }
                else{
                    return ""
                }
            }
            return ""
    }
}

extension UITextField {
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = FontStyle.textColor.CGColor
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIButton
{
    func centerVerticallyWithPadding(padding: CGFloat)
    {
        let imageSize: CGSize = self.imageView!.frame.size
        let titleSize: CGSize = self.titleLabel!.frame.size
        let totalHeight: CGFloat = (imageSize.height + titleSize.height + padding)
        self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width)
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(totalHeight - titleSize.height), 0.0)
    }
}

enum PrivacyOption : Int
{
    case Public = 0
    case SiteMembers = 20
    case Friends = 30
    case OnlyMe = 40
}

enum TopBarViewName : Int
{
    case AlbumDetailView = 1
    case VirtualMartView = 2
    case VideoDetailView = 3
    case ProfileView = 4
    case GroupDetailView = 5
    case EventDetailView = 6
    case InviteFriendView = 7
    case DiscussionDetailView = 8
    case AnnouncementDetailView = 9
    case FriendSearchView = 10
}

enum PostForView : Int
{
    case ProfileView = 1
    case GroupView = 2
    case EventView = 3
    case ActivityView = 4
}

enum HomeTabView : Int
{
    case ActivityView = 1
    case MessageView = 3
    case FriendView = 2
}

struct CommonConstant
{
    
//    static var TAG_URL  = "http://192.168.5.138/mywewe/index.php?option=com_ijoomeradv"
//    static var TAG_URL = "http://192.168.5.144/wewe/index.php?option=com_ijoomeradv"
    
    // Live demo url for test
    static var TAG_URL = "https://matiz.websitewelcome.com/~tasolglo/dev/wewe/index.php?option=com_ijoomeradv"

    static var TAG_PLACEAPI_KEY = "AIzaSyC7oL5yj316GcmKg7uRIgd5yPOJIwrRfLI"
    static var TAG_TASK : String = "task"
    static var TAG_EXTTASK : String = "extTask"
    static var TAG_EXTVIEW : String = "extView"
    static var TAG_TASK_DATA : String = "taskData"
    static var TAG_REQUEST_OBJ : String = "reqObject"
    static var TAG_EXT_NAME : String    = "extName"
    
    static var TAG_EXTVIEW_JOMSOCIAL : String = "jomsocial"
    static var TAG_EXTNAME_VMVENDOR  : String = "vmvendor"
    static var TAG_EXTNAME_VIRTUEMART : String = "virtuemart"
    static var TAG_EXTNAME_CUSTOMFILTERS  : String = "customfilters"
    
    static var TAG_CODE : String = "code"
    
    static var TAG_DEVICE = "device"
    static var TAG_DEVICE_IPHONE = "iphone"
    static var TAG_TYPE = "type"
    
    static var TAG_TASK_APPLICATIONCONFIG  = "applicationConfig"
    static var DB_NAME = "ijoomer.sqlite"
    static var TAG_DEVICETOKEN = "devicetoken"
}
struct OrderConstant {
    
    static var TAG_EXTTASK_ORDERDETAIL          = "orderdetail"
    static var TAG_EXTVIEW_IJOOMERVMORDER       =  "ijoom_vmorder"
    static var TAG_ORDER_NUMBER =               "order_number"
    static var TAG_ORDER_DATA =               "data"
    static var TAG_ORDER_DATE =               "date"
}

struct DatabaseConstant
{
    static  var TAG_IJOOMER_CONFIG_TABLE : String = "IjoomerConfig"
    
    static  var QUERY_CREATE_TABLE : String = "CREATE TABLE IF NOT EXISTS"
    static  var  QUERY_INSERT_TABLE : String = "INSERT OR REPLACE INTO"
    static  var QUERY_DELETE_TABLE : String = "DELETE FROM"
    static  var QUERY_SELECT_TABLE : String  = "SELECT * FROM"
    static  var QUERY_SELECT_COUNT : String  = "SELECT COUNT(*) FROM"
    static  var QUERY_UPDATE_TABLE : String  = "UPDATE"
    
    static  var TAG_CONFIG_NAME : String = "configName"
    static  var TAG_CONFIG_DATA : String = "configData"
    
    
    static  var TAG_MENU_TABLE  : String = "IjoomerMenus" // Response tag name
    static  var TAG_CATEGORIES_TABLE : String = "Categories"
    
    
    static  var TAG_MENUID  : String = "menuid"
    static  var TAG_MENU_NAME   : String = "menuname"
    static  var TAG_MENU_POSITION   : String = "menuposition"
    static  var TAG_MENU_SCREENS : String = "screens"
    static  var TAG_MENU_TYPE   : String = "menutype"
    static  var TAG_MENU_ITEM   : String = "menuitem"
    
    // -------TAGS for Mode(Smile) Table ----------///////
    static var TAG_MODE_TABLE : String = "mode"
    static var TAG_MODE_TITLE : String = "mood_title"
    static var TAG_MODE_ID  : String = "mood_id"
    static var TAG_MODE_DESCRIPTION = "mood_description"
    static var TAG_MODE_IMAGE   = "mood_image"
    
    // ------ TAGS for Categories Table -----------///
    
    static var TAG_CATEGORIES_ITEM_NAME : String = "name"
    static var TAG_CATEGORIES_ITEM_IMAGE : String = "image"
    static var TAG_CATEGORIES_ITEM_DESCRIPTION : String = "description"
    static var TAG_CATEGORIES_ITEM_PARENTID : String = "parentID"
    static var TAG_CATEGORIES_ITEM_CATEGORYID : String = "categoryID"
    
    
    // ------ TAGS for Ijoomer MenuItem Table  ----------//
    
    static  var TAG_MENU_ITEM_TEABLE    : String = "IjoomerMenuItem"
    
    static  var TAG_MENU_ITEM_CAPTION   : String = "itemcaption"
    static  var TAG_MENU_ITEM_DATA  : String = "itemdata"
    static  var TAG_MENU_ITEM_ITEMVIEW  : String = "itemview"
    static  var TAG_MENU_ITEM_ID    : String = "itemid"
    // static  var TAG_MENUID  : String = "menuid"-> menuid as an forign Key
    static  var TAG_MENU_ITEM_ICON  : String = "icon"
    static var  TAG_MENU_ITEM_BANNER_IMAGE : String = "banner_image"
    
    // Tags for Application Theme TABLE
    
    static  var TAG_THEME   : String = "theme"  // Response tag name
    
    static  var TAG_APP_THEME_TABLE : String = "IjoomerTheme"
    static  var TAG_THEME_VIEWNAME  : String = "viewname"
    static  var TAG_THEME_ICON  : String = "icon"
    static  var  TAG_THEME_TAB   : String = "tab"
    static  var TAG_THEME_TAB_ACTIVE    : String = "tab_active"
    static  var TAG_THEME_TABPATH   : String = "TabPath"
    static  var TAG_THEME_TAB_ACTIVEPATH    : String = "TabactivePath"
    static  var TAG_THEME_ICONPATH  : String = "iconpath"
    
    
    static  var TAG_MENUITEM_TABLE_DETAIL : String = "MenuItemsDetails"
    static  var TAG_THEME_TABLE_DETAIL : String = "ThemeDetails"
    
    static  var TAG_VIEWLIST = "ViewList"
    
    
    // Tags for Cart Table
    
    
    static var TAG_CART_TABLE : String = "Cart"
    static var TAG_CART_ITEM_NAME : String = "productName"
    static var TAG_CART_ITEM_IMAGE : String = "image"
    static var TAG_CART_ITEM_PRICE :String = "salesPrice"
    static var TAG_CART_ITEM_PRODUCTID : String = "productID"
    static var TAG_SHORTDESCRIPTION : String = "shortDescription"
    static var TAG_ADDED_QUANTITY   : String = "quantity"
    
    static var TAG_CART_ITEM_CATEGORYID : String = "categoryID"
    static var TAG_CART_ITEM_CATEGORYNAME : String = "categoryName"
    static var TAG_CART_ITEM_RATING :  String = "rating"
    static var TAG_CART_ITEM_CARRENCY : String = "currency"
    
    //Tags for Address Table
    
    static var TAG_ADDRESS_TABLE : String = "AddressTAble"
    static var TAG_FULLNAME : String = "fullname"
    static var TAG_ADDRESS : String = "address"
    static var TAG_PINCODE :String = "pincode"
    static var TAG_CITY : String = "city"
    static var TAG_STATE : String = "state"
    static var TAG_PHONE : String = "phone"
    
    // Tags For Favourite Table
    static var TAG_FAVOURITE_TABLE : String = "Favourite"
    static var TAG_FAVOURITE_PRODUCTID : String = "productID"
    static var TAG_FAVOURITE_CATEGORYID : String = "categoryID"
    static var TAG_FAVOURITE_PRODUCTNAME : String = "productName"
    static var TAG_FAVOURITE_CATEGORYNAME : String = "categoryName"
    static var TAG_FAVOURITE_RATING :  String = "rating"
    static var TAG_FAVOURITE_SALESPRICE : String = "salesPrice"
    static var TAG_FAVOURITE_IMAGE : String = "image"
    static var TAG_FAVOURITE_SHORTDESC : String = "shortDescription"
    
    // Tags For Country Table
    static var TAG_COUNTRY_TABLE : String = "Country"
    static var TAG_COUNTRY_ID : String = "virtuemart_country_id"
    static var TAG_COUNTRY_NAME : String = "country_name"
    static var TAG_COUNTRY_VALUE  : String = "value"
    static var TAG_COUNTRY_TEXT   : String = "text"
    
    // Tags For State Table
    static var TAG_STATE_TABLE : String = "State"
    static var TAG_STATE_ID : String = "virtuemart_state_id"
    static var TAG_STATE_NAME : String = "state_name"
    static var TAG_STATE_VALUE  : String = "value"
    static var TAG_STATE_TEXT   : String = "text"
    static var TAG_STATE_COUNTRY_ID   : String = "countryId"
}

struct GlobalConfigConstant
{
    //  -------------  Global Config Table Tags  -----------------
    
    
    static  var TAG_GLOBAL_CONFIG   : String = "globalconfig"
    static  var TAG_EXTENTION_CONFIG: String = "extentionconfig"
    static  var TAG_JOMSOCIAL       : String = "jomsocial"
    static  var TAG_K2              : String = "k2"
    
    
    static  var TAG_VIEWNAME        : String = "Viewname"
    static  var TAG_TAB_URL         : String = "Tab_URL"
    static  var TAG_TAB_ACTIVE_URL  : String = "Tabactive_URL"
    static  var TAG_ICON_URL        : String = "Icon_URL"
    static  var TAG_TAB_PATH        : String = "TabPath"
    static  var TAG_TAB_ACTIVE_PATH : String = "TabactivePath"
    static  var TAG_ICONPATH        : String = "iconpath"
    static  var TAG_MENUS           : String = "menus"
    static  var TAG_CONFIGURATION   : String = "configuration"
    static  var TAG_MODEDETAILS     : String = "MoodDetails"
}

struct ForgotPasswordConstant
{
    static var TAG_TASK_RESETPASSWORD :String = "resetPassword"
    static var TAG_TASK_RETRIVEUSERNAME : String = "retriveUsername"
    static var TAG_TASK_RETRIVEACTIVATIONCODE : String = "retriveActivationCode"
    
    static var TAG_STEP : String = "step"
    static var TAG_EMAIL : String = "email"
    static var TAG_USERNAME : String = "username"
    static var TAG_USERID : String = "userid"
    static var TAG_PASSWORD : String = "password"
    static var TAG_CRYPT : String = "crypt"
    static var TAG_TOKEN : String = "token"
    static var TAG_ACTIVATIONCODE   = "activationResend"
    static var TAG_JOMSOCIAL    = "jomsocial"
    static var TAG_USER = "user"
}

struct RegisterConstant
{
    static var TAG_TASK_REGISTER = "registration"
    static var TAG_EXTTASK_PROFILE_TYPE = "profileTypes"
    static var TAG_EXTVIEW_USER = "user"
    
    static var TAG_FIELD_NAME = "name"
    static var TAG_FIELD_USERNAME = "username"
    static var TAG_FIELD_EMAIL  = "email"
    static var TAG_FIELD_PASSWORD = "password"
    static var TAG_FIELD_TYPE   = "type"
    static var TAG_FIELD_PROFILE_TYPE = "profiletype"
    static var TAG_FIELD_ID    = "id"
    static var TAG_REGISTRATION_STEP_ONE_Data = "stepOneData"
    static var TAG_REG_RESPONSE_DATA        = "responseData"
    ////    ------------  Registration Step 2 Fields Tag  -----
    
    static var TAG_REGISTRATION_FULL  = "full"
    static var TAG_REGISTRATION_FIELDS = "fields"
    static var TAG_REGISTRATION_GROUP  = "group"
    static var TAG_REGISTRATION_GROUP_NAME = "group_name"
    static var TAG_REGISTRATION_FIELD  = "field"
    static var TAG_REGISTRATION_FIELD_ID    = "id"
    static var TAG_REGISTRATION_FIELD_CAPTION     = "caption"
    static var TAG_REGISTRATION_FIELD_REQUIRED  = "required"
    static var TAG_REGISTRATION_FIELD_VALUE     = "value"
    static var TAG_REGISTRATION_FIELD_TYPE      = "type"
    static var TAG_REGISTRATION_FIELD_OPTIONS   = "options"
    static var TAG_REGISTRATION_FIELD_OPTION_VALUE  = "value"
    static var TAG_REGISTRATION_FIELD_PRIVACY   = "privacy"
    static var TAG_REGISTRATION_FIELD_PRIVACY_VALUE = "value"
    static var TAG_REGISTRATION_FIELD_PRIVACY_OPTIONS   = "options"
    static var TAG_REGISTRATION_FIELD_PRAVACY_CAPTION   = "caption"
    static var TAG_REGISTRATION_FIELD_PRIVACY_TITLE_PUBLIC         = "Public"
    static var TAG_REGISTRATION_FIELD_PRIVACY_TITLE_ONLYME         = "Only Me"
    static var TAG_REGISTRATION_FIELD_PRIVACY_TITLE_FRIENDS        = "Friend"
    static var TAG_REGISTRATION_FIELD_PRIVACY_TITLE_SITEMEMBERS    = "Site Members"
    static var TAG_REGISTRATION_MEMBER = "member"
    
    
    // Field for Type Check
    static var TAG_FIELD_MAP                        = "map"
    static var TAG_FIELD_TYPE_CHECKBOX              = "checkbox"
    static var TAG_FIELD_TYPE_SELECT                = "select"
    static var TAG_FIELD_TYPE_TEXT                  = "text"
    static var TAG_FIELD_TYPE_TEXTAREA              = "textarea"
    static var TAG_FIELD_TYPE_FILE                  = "file"
    static var TAG_FIELD_TYPE_LABEL                 = "label"
    static var TAG_FIELD_TYPE_MAP                   = "map"
    static var TAG_FIELD_TYPE_DATE                  = "date"
    static var TAG_FIELD_TYPE_TIME                  = "time"
    static var TAG_FIELD_TYPE_MULTIPLE_SELECT       = "multipleselect"
    static var TAG_FIELD_TYPE_DATETIME              = "datetime"
    static var TAG_FIELD_TYPE_GENDER                = "gender"
    static var TAG_FIELD_TYPE_BIRTHDATE             = "birthdate"
    static var TAG_FIELD_TYPE_COUNTRY               = "country"
    static var TAG_FIELD_TYPE_EMAILADDRESS          = "emailaddress"
    static var TAG_FIELD_TYPE_DELIMITER             = "delimiter"
    static var TAG_FIELD_TYPE_PASSWORD              = "password"
    static var TAG_FIELD_TYPE_HIDDEN                = "hidden"
}

struct VRHomeConstant
{
    static var TAG_EXTTASK_GETCATEGORIES = "getcategorylist"
    static var TAG_EXTVIEW_ICATEGORY     = "icategory"
    static var TAG_EXTNAME_VIRTUEMART    = "virtuemart"
    
    static var TAG_EXTVIEW_PRODUCT      = "product"
    static var TAG_EXTTASK_GETFEATURED = "getFeatured"
    
    
    static var TAG_HOME_MENUITEMDETAILS    = "MenuItemsDetails"
    static var TAG_HOME_ICON                = "icon"
    static var TAG_HOME_ITEMDATA            = "itemdata"
    static var TAG_VIRTUEMART_CATEGORY_ID   = "virtuemart_category_id"
    static var TAG_CATEGORY_NAME            = "category_name"
}

struct ProductListConstant
{
    static var TAG_EXTTASK_PRODUCTLIST       = "productlist"
    static var TAG_EXTVIEW_PRODUCT      = "product"
    static var TAG_EXTNAME_VIRTUEMART   = "virtuemart"
    static var TAG_PAGENO               = "pageNO"
    static var TAG_ORDERBY              = "orderby"
    static var TAG_CATEGORYID           = "categoryID"
    static var TAG_PRODUCTS             = "products"
    static var TAG_TOTAL                = "total"
    static var TAG_PAGELIMIT            = "pageLimit"
    static var TAG_SORT_OPTION : [String]   = ["Creation Date","Product Name","Product SKU", "Product Price"]
    
    static var TAG_SPECIAL_CASE         = "special_case"
    static var TAG_PRODUCT_LAST_ID      = "last_id"
    static var TAG_CATEGORY_ID          = "category_id"
    static var TAG_DATA                 = "data"
    static var TAG_ID                   = "id"
    static var TAG_NAME                 = "name"
    static var TAG_PRICE                = "price"
    static var TAG_SALES_PRICE          = "salesPrice"
    static var TAG_FORMATTED            = "formatted"
    static var TAG_IMAGES               = "images"
    static var TAG_MAIN                 = "main"
    static var TAG_THUMB                = "thumb"
    static var TAG_FULL                 = "full"
    static var TAG_URL                  = "url"
    static var TAG_SHORT_DESCRIPTION    = "short_description"
    static var TAG_RATING_REVIEWS       = "rating_reviews"
    static var TAG_RATING_ASK_PRICE     = "ask_price"
    static var TAG_LIMIT                = "limit"
    static var TAG_RATINGS              = "ratings"
    static var TAG_VALUE                = "value"
    
    static var TAG_ORDERBYFIELD         = "orderby_fields"
    static var TAG_OPTIONS         = "options"
}

struct ProductDetailConstant
{
    static var TAG_EXTTASK_RECALCULATE  = "recalculate"
    static var TAG_EXTTASK_DETAIL       = "detail"
    static var TAG_EXTVIEW_PRODUCT      = "product"
    static var TAG_EXTNAME_VIRTUEMART   = "virtuemart"
    
    static var TAG_REVIEWCOUNT      = "reviewCount"
    static var TAG_RATING           = "rating"
    static var TAG_SALESPRICE       = "salesPrice"
    static var TAG_ASKPRICE         = "ask_price"
    static var TAG_PRODUCTNAME      = "productName"
    static var TAG_IMAGE            = "image"
    static var TAG_PRODUCTID        = "product_id"
    static var TAG_IMAGES           = "images"
    static var TAG_PRODUCTDESC      = "productDesc"
    static var TAG_SHORTDESCRIPTION = "short_description"
    static var TAG_PRODUCT_NAME     = "ProductName"
    static var TAG_RELATEDPRODUCT   = "relatedProduct"
    static var TAG_RELATEDCATEGORIES = "relatedCategory"
    static var TAG_CATEGORYIMAGE    = "CategoryImage"
    static var TAG_CATEGORYNAME     = "CategoryName"
    static var TAG_CATEGORYID       = "CategoryID"
    static var TAG_CARRENCY         = "currency"
    static var TAG_DISSCOUNTAMOUNT        = "discountAmount"
    static var TAG_BASEPRIZEWITHTAX = "basePriceWithTax"
    static var TAG_WRITEREVIEWS     = "canWriteReviews"
    static var TAG_MANUFACTURE      = "manufacturer"
    
    //Custom Fields Tag
    static var TAG_FIELDTYPE = "field_type"
    static var TAG_CHILDPRODUCT = "childproduct"
    static var TAG_CHILEPRODUCTNAME = "childproductName"
    static var TAG_CUSTOMFILED     = "customefiled"
    static var TAG_CHILEDPRODUCTID = "childproductId"
    static var TAG_CUSTOMTITLE = "custom_title"
    static var TAG_CUSTOMVALUE = "customValue"
    static var TAG_CUSTOMFIELDVALUE = "customFieldValue"
    static var TAG_CUSTOMDESC = "customDesc"
    static var TAG_ISINPUT  = "is_input"
    static var TAG_VARIANTPRICEMODIFICATION    = "variantPriceModification"
    static var TAG_PRICES   = "prices"
    
    static var TAG_MINAMOUNT = "minAmount"
    static var TAG_MAXAMOUNT = "maxAmount"
    static var TAG_MIN_PURCHASE = "min_purchase"
    static var TAG_PRODUCT_ID = "product_id"
    static var TAG_EXTTASK_PRODUCTDETAIL     = "productdetail"
    
    
    // new tags added by Rushita
    static var TAG_NAME   = "name"
    static var TAG_DESCRIPTION = "description"
    static var TAG_REVIEWS = "reviews"
    static var TAG_TOTAL = "total"
    static var TAG_MAIN = "main"
    static var TAG_FULL = "full"
    static var TAG_URL = "url"
    static var TAG_PRICE = "price"
    static var TAG_FORMATTED = "formatted"
    static var TAG_BASEPRICE = "basePrice"
    static var TAG_ID = "id"
    static var TAG_ADDITIONAL = "additional"
    static var TAG_CUSTOMFIELDS = "customfields"
    static var TAG_DATA = "data"
    static var TAG_SELECTBOXES = "selectboxes"
    static var TAG_OPTIONS = "options"
    static var TAG_TEXT = "text"
    static var TAG_SELECTED = "selected"
    static var TAG_VALUE = "value"
    static var TAG_LABEL = "label"
    static var TAG_DATE = "date"
    static var TAG_ISRADIO = "is_radio"
    static var TAG_CARTFIELDNAME   = "cart_fieldname"
    static var TAG_TITLE = "title"
    static var TAG_SELECTEDCUSTOMFIELDS = "selected_customfields"
    static var TAG_QUANTITY = "quantity"
    static var TAG_MAX_PURCHASE = "max_purchase"
    static var TAG_ADDTOCART = "addtocart"
    static var TAG_CART = "cart"
    static var TAG_COMBINATION = "combination"
    static var TAG_CARTDETAILS = "cartdatails"
    static var TAG_PRODUCTS = "products"
    static var TAG_CUSTOMTEXT = "custom_text"
    static var TAG_CARTTOTAL = "cart_total"
    static var TAG_TAX = "tax"
    static var TAG_DISCOUNT = "discount"
    static var TAG_CARTPOS = "cartpos"
    static var TAG_UPDATECART = "updatecart"
    static var TAG_ORDERLIST = "orderlist"
    static var TAG_ORDER = "ijoom_vmorder"
    static var TAG_LASTID = "last_id"
    static var TAG_ORDERNUMBER = "order_number"
    static var TAG_ORDERDATE = "order_date"
    static var TAG_ORDERSTATUS = "order_status"
    static var TAG_ORDERTOTAL = "order_total"
    static var TAG_ORDERID = "order_id"
    static var TAG_STOCK   = "stock"
    static var TAG_STEP_PURCHASE    = "step_purchase"
    static var TAG_SHARE_LINK       = "sharelink"
    //    static var TAG_ORDERID = "order_id"
    //    static var TAG_ORDERID = "order_id"
    //    static var TAG_ORDERID = "order_id"
    //    static var TAG_ORDERID = "order_id"
    
}

struct SideMenuConstant
{
    static var TAG_CATEGORIES    = "categories"
}

struct MenuPosition
{
    static var VRBannerPosition : Int32 = 4
    static var VRTOPMENUBARPOSITION : Int32 = 3
    static var JOMSOCIAL_SIDEMENU_POSITION : Int32 = 2
}
struct MenuViewName
{
    static var banners = "Banners"
    static var TOPBARVIRTUALMART = "Top Bar Menu (Virtuemart)"
    static var JOMSOCIAL_SIDEMENU = "JomSocial Slide Menu"
    static var VM_SIDEMENU = "Virtual Mart Side Menu"
}
struct LoginConstant
{
    static var TAG_TASK_LOGIN  = "login"
    static var TAG_USERNAME    = "username"
    static var TAG_PASSWORD    = "password"
    static var TAG_DEVICETOKEN = "devicetoken"
    static var TAG_TYPE        = "iphone"
    static var TAG_FIELD_TYPE  = "type"
    static var TAG_MESSAGE = "message"
    static var IS_LOGGEDIN    = "isloggedin"
    static var TAG_TASK_LOGOUT   = "logout"
    static var TAG_TASK_FBLOGIN = "fblogin"
}
struct ReviewListConstant {
    
    static var TAG_EXTTASK_GETPRODUCTS_REVIEW  = "reviewratinglist"
    static var TAG_USER         = "user"
    static var TAG_DATE         = "date"
    static var TAG_REVIEWCOUNT   = "reviewCount"
    static var TAG_RATING        = "rating"
    static var TAG_COMMENT       = "comment"
    static var TAG_PRODUCTID     = "productID"
    static var TAG_USERID        = "userID"
    static var TAG_REVIEWS        = "reviews"
    static var TAG_REVIEW_RATING =  "rating"
    static var TAG_VOTE =  "vote"
    static var TAG_DATA =  "data"
    static var TAG_NAME =  "name"
    static var TAG_RATINGREVIEW =  "rating_reviews"
    static var TAG_CANPOST =  "canpost"
    //
}

struct SearchConstant
{
    static var TAG_EXTTASK_SEARCH = "search"
    static var TAG_EXTVIEW_PRODUCT = "product"
    static var TAG_EXTNAME_VIRTUEMART   = "virtuemart"
    static var TAG_KEYWORD = "keyword"
    
}

struct AddReviewConstant {
    
    static var TAG_SAVERATING = "add_reviewrating"
    static var TAG_USERCOMMENT = "comment"
    static var TAG_RATING      = "vote"
    static var TAG_CATEGORYID      = "category_id"
    static var TAG_COUNTER      = "counter"
}

struct CartConstant
{
    static var TAG_EXTTASK_UPLOADFINALCART      = "uploadFinalCart"
    static var TAG_EXTVIEW_PRODUCT              = "product"
    static var TAG_EXTTASK_GETBILLINGADDRESS    = "getBillingAddress"
    static var TAG_EXTTASK_SAVEBILLINGADDRESS   = "savebillingAddress"
    static var TAG_EXTTASK_SAVESHIPPINGADDRESS  = "saveShippingAddress"
    static var TAG_EXTTASK_REMOVESHIPPINGADDRESS = "removeShippingAddress"
    static var TAG_EXTVIEW_CART                 = "cart"
    static var TAG_EXTTASK_GETSHIPPINGADDRESS   = "getShippingAddresses"
    static var TAG_EXTTASK_SELECTSHIPPINGADDRESS = "selectShippingAddressForCart"
    
    static var TAG_EXTTASK_BILLINGADDRESS       = "billingAddress"
    static var TAG_EXTTASK_SHIPINGADDRESS       = "shipmetaddress"
    
    static var TAG_EXTNAME_VIRTUEMART           = "virtuemart"
    static var TAG_PRODUCTID                    = "productID"
    static var TAG_COUNTRYLIST                  = "countryList"
    static var TAG_STATELIST                    = "stateList"
    static var TAG_BILLING                      = "billing"
    static var TAG_VIRTUEMART_USERINFO_ID       = "virtuemart_userinfo_id"
    static var TAG_FORMATED                     = "formatted"
    static var TAG_FORM_FIELDS                  = "form_fields"
    static var TAG_SHIPPING_ADDRESS             = "shipping_address"
}


struct Notificaiton
{
    static var TAG_LAST_ID                  = "last_id"
    static var TAG_TYPE2                    = "type2"
    static var TAG_TYPE1                    = "type1"
    static var TAG_COMMENTID                = "commentID"
    static var TAG_ID                       = "id"
    static var TAG_ACTID                    = "actID"
    static var TAG_TYPE                     = "type"
    static var TAG_ACTORID                  = "actorID"
    static var TAG_MESSSAGE                 = "message"
    static var TAG_DATE                     = "date"
    static var TAG_DATA                     = "data"
    static var TAG_AVATAR                   = "actor_avatar"
    static var TAG_GROUP_AVTAR              = "group_avatar"
    static var TAG_EVENT_AVTAR              = "event_avatar"
    static var TAG_ACTOR_NAME               = "actor_name"
    static var TAG_EVENT_TITLE              = "event_title"
    static var TAG_GROUP_NAME               = "group_name"
    static var TAG_ALBUM_ID                 = "albumID"
    static var TAG_PHOTO_ID                 = "photoID"
    static var TAG_EVENT_ID                 = "eventID"
    static var TAG_GROUP_ID                 = "groupID"
    static var TAG_VIDEO_ID                 = "videoID"
    static var TAG_MESSAGE_ID               = "messageID"
    static var TAG_ANNOUNCEMENT_ID          = "announcementID"
    static var TAG_DISCUSSION_ID            = "discussionID"
    static var TAG_DETAILS                  = "details"
    static var TAG_METADATA                 = "metadata"
    static var TAG_GENERAL                  = "general"
    static var TAG_FRIENDREQUEST            = "friendrequest"
    static var TAG_INBOX                    = "inbox"
    
    static var TYPE_PROFILE_LIKE            = "profile.like"
    static var TYPE_PHOTO_LIKE              = "photos.like"
    static var TYPE_ALBUM_LIKE              = "album.like"
    static var TYPE_EVENTS_WALL_CREATE      = "events.wall.create"
    static var TYPE_VIDEO_COMMENT           = "video.comment"
    static var TYPE_VIDEO_LIKE              = "videos.like"
    
    static var LINK_PROFILE                 = "profile"
    static var LINK_GROUP                   = "group"
    static var LINK_EVENT                   = "event"
    static var LINK_PHOTO                   = "photo"
    static var LINK_ALBUM                   = "album"
    static var LINK_VIDEO                   = "video"
}

//MARK: Custom Filter Pro Constant
struct Filter
{
    static var TAG_EXTVIEW_FILTERFIELDS             = "filterfields"
    
    static var TAG_EXTTASK_GETFILTERFIELD           = "getFilterFields"
    static var TAG_EXTTASK_GETPRODUCT_SEARCH_DATA   = "getProductSearchData"
    
    
    static var TAG_FILTER_FIELDS                    = "filter_fields"
    static var TAG_GROUP_NAME                       = "group_name"
    static var TAG_FIELD                            = "field"
    static var TAG_NAME                             = "name"
    static var TAG_EXTRA_ATTRIBUTE                  = "extra_attrib"
    static var TAG_PLACEHOLDER                      = "placeholder"
    static var TAG_SIZE                             = "size"
    static var TAG_MAXLENGTH                        = "maxlength"
    static var TAG_SHOW_PRODUCT_COUNT               = "showProductCount"
    static var TAG_SMART_SEARCH                     = "smartSearch"
    static var TAG_OPTIONS                          = "options"
    static var TAG_SELECTED                         = "selected"
    static var TAG_PRODUCTCOUNT                     = "productCount"
    static var TAG_ACTIVE                           = "active"
    static var TAG_CHILD                            = "child"
    static var TAG_IS_MULTI                         = "is_multi"
    static var TAG_VALUE                            = "value"
    static var TAG_TEXT                             = "text"
    static var TAG_ISCUSTOM_FIELD                   = "is_customfield"
    static var TAG_CUSTOMFIELDS                     = "customefields"
    static var TAG_IS_DISPLAY                       = "is_display"
    
    static var TYPE_TEXT                            = "text"
    static var TYPE_SELECT                          = "select"
    static var TYPE_SLIDER                          = "slider"
}

//MARK: Virtual Mart Vendor Key
struct VMV
{
    //TODO: Extension View Tag
    static var TAG_EXTVIEW_DASHBOARD                  = "dashboard"
    static var TAG_EXTVIEW_USER                       = "user"
    static var TAG_EXTVIEW_PRODUCT                    = "product"
    static var TAG_EXTVIEW_IJOOM_VENDOR               = "ijoom_vmorder"
    
    //TODO: Extension Task Tag
    static var TAG_EXTTASK_GETMYPRODUCTS            = "getMyproducts"
    static var TAG_EXTTASK_GETPROFILE               = "getProfile"
    static var TAG_EXTTASK_EDITPROFILE              = "EditProfile"
    static var TAG_EXTTASK_SAVEPROFILE              = "saveProfile"
    static var TAG_EXTTASK_GETMYSALES               = "getMysales"
    static var TAG_EXTTASK_ADDPRODUCTFORM           = "getProductForm"
    static var TAG_EXTTASK_GETMYPOINTS              = "getMypoints"
    static var TAG_EXTTASK_DISPAYTAXDATA            = "displayTaxData"
    static var TAG_EXTTASK_SAVENEWPRODUCT           = "saveNewProduct"
    static var TAG_EXTTASK_EDITPRODUCT              = "editProduct"
    static var TAG_EXTTASK_GETTAXFORM               = "getTaxForm"
    static var TAG_EXTTASK_SAVETAXDATA              = "saveTaxData"
    static var TAG_EXTTASK_DELETETAX                = "deleteTax"
    static var TAG_EXTTASK_DELETEPRODUCT            = "deleteProduct"
    static var TAG_EXTTASK_MAILCUSTOMER             = "mailCustomer"
    static var TAG_EXTTASK_UPDATEORDERSTATUS        = "updateOrderStatus"
    static var TAG_EXTTASK_ORDERLIST                = "orderlist"
    static var TAG_EXTTASK_ORDERDETAIL              = "orderdetail"
    static var TAG_EXTTASK_DISPLAYSHIPMENTDATA      = "displayShipmentData"
    static var TAG_EXTTASK_DELETESHIPMENT           = "deleteShipment"
    static var TAG_EXTTASK_GET_SHIPMENT_FORM        = "getShipmentForm"
    static var TAG_EXTTASK_SAVE_SHIPMENT_FORM       = "saveShipmentData"
    static var TAG_EXTTASK_GETMYREVIEWS             = "getMyreviews"
    static var TAG_EXTTASK_DELETEREVIEW             = "deleteReview"
    static var TAG_EXTTASK_PUBLISHREVIEW            = "publishReview"
    static var TAG_EXTTASK_GETMYSTATS               = "getMyStats"
    static var TAG_EXTTASK_PROFILEVISIT             = "profilevisit"
    
    //TODO: VMV Profile Tag
    static var TAG_CAPTION_DESCRIPTION      = "Vendor Description"
    static var TAG_CAPTION_TERM_SERVICE     = "Terms of Services"
    static var TAG_CAPTION_LEGAL_SERVICE            = "Legal Services"
    static var TAG_PAGENO                   = "pageNO"
    static var TAG_VENDOR_NAME              = "vendorname"
    static var TAG_USERNAME                 = "username"
    static var TAG_VENDOR_IMAGE             = "vendorimage"
    static var TAG_USER_IMAGE               = "userimage"
    static var TAG_DESCRIPTION              = "description"
    static var TAG_TERM_OF_SERVICE          = "termsofservice"
    static var TAG_LEGAL_SERVICE            = "legalservice"
    static var TAG_RATINGS                  = "ratings"
    static var TAG_FBCOMMENTS               = "fbcomments"
    static var TAG_PAYPALEMAIL              = "paypalemail"
    static var TAG_PROFILE                  = "profile"
    static var TAG_USER_ID                  = "user_id"
    static var TAG_SHARE_LINK               = "sharelink"
    static var TAG_FBCOMMENTURL             = "fbcommentsUrl"
    static var TAG_WEBURL                   = "weburl"
    static var TAG_VISITORID                = "visitorid"
    static var TAG_THUMB                    = "thumb"
    static var TAG_PROFILES                 = "profiles"
    
    //TODO: Tag for Product Detail
    static var TAG_PRODUCTID               = "productid"
    static var TAG_CATEGORYID              = "categoryid"
    static var TAG_PRODUCT_NAME            = "productname"
    static var TAG_CATEGORY_NAME           = "categoryname"
    static var TAG_IMAGE                   = "image"
    static var TAG_PRICE                   = "price"
    static var TAG_CURRENCYSYMBOL          = "currencysymbol"
    static var TAG_ALLOWDELETE             = "allowdelete"
    static var TAG_STOCK                   = "stock"
    static var TAG_PRODUCTS                = "products"
    static var TAG_CONFIG                  = "config"
    static var TAG_CANDELETEPRODUCT        = "canDeleteProduct"
    static var TAG_IS_PUBLISHED            = "is_published"
    
    //TODO: Tag For Dynamic Add Product Form
    static var TYPE_SELECT                  = "select"
    static var TYPE_LABEL                   = "label"
    static var TYPE_TEXT                    = "text"
    static var TYPE_TEXTAREA                = "textarea"
    static var TYPE_FILE                    = "file"
    static var TYPE_SECTION                 = "section"
    static var TYPE_TAGS                    = "tags"
    static var TYPE_IMAGE                   = "image"
    static var TYPE_CHECKBOX                = "checkbox"
    static var TYPE_HIDDEN                  = "hidden"
    static var TYPE_EMAIL                   = "email"
    
    static var TAG_FORM                     = "form"
    static var TAG_FORMDATA                 = "formdata"
    static var TAG_CAPTION                  = "caption"
    static var TAG_TYPE                     = "type"
    static var TAG_NAME                     = "name"
    static var TAG_VALUE                    = "value"
    static var TAG_OPTION                   = "options"
    static var TAG_REQUIRED                 = "required"
    static var TAG_TEXT                     = "text"
    static var TAG_DATA                     = "data"
    static var TAG_PROFILEDATA              = "profileData"
    static var TAG_IS_MULIT                 = "is_multi"
    static var TAG_IS_RADIO                 = "is_radio"
    static var TAG_TOOLTIP                  = "tooltip"
    static var TAG_MAXLENGTH                = "maxlength"
    static var TAG_CURRENCY                 = "currency"
    static var TAG_SYMBOL                   = "symbol"
    static var TAG_MAX_FILE_SIZE            = "max_file_size"
    static var TAG_ALLOWED_EXTENSION        = "allowed_extensions"
    static var TAG_MAX_FILES                = "max_files"
    static var TAG_TAGLIMIT                 = "tagslimit"
    static var TAG_TAGS                     = "tags"
    static var TAG_FIELD_TYPE               = "field_type"
    static var TAG_URL                      = "url"
    static var TAG_LINK_CAPTION             = "link_caption"
    static var TAG_CHILDREN                 = "children"
    static var TAG_LINK                     = "link"
    static var TAG_MEDIA_ID_VALUE           = "media_id_value"
    static var TAG_CAN_DELETE               = "can_delete"
    static var TAG_DELETE_IMAGE_ID          = "deleteimageid"
    static var TAG_DELETE_FIELD_ID          = "deletefileid"
    static var TAG_IS_NUMERIC               = "is_numeric"
    
    //TODO: Tag For Sell Order Detail
    static var TAG_PAGELIMIT                = "pageLimit"
    static var TAG_TOTAL                    = "total"
    static var TAG_CREATEDATE               = "createddate"
    static var TAG_ORDERNUMBER              = "ordernumber"
    static var TAG_ITEMNAME                 = "itemname"
    static var TAG_QUANTITY                 = "quantity"
    static var TAG_ORDERS                   = "orders"
    static var TAG_CUSTOMER                 = "customer"
    static var TAG_SALETITLE                = "saletitle"
    static var TAG_FIRSTNAME                = "firstname"
    static var TAG_MIDDLENAME               = "middlename"
    static var TAG_LASTNAME                 = "lastname"
    static var TAG_COMPANY                  = "company"
    static var TAG_ADDRESS_FIRST            = "addressfirst"
    static var TAG_ADDRESS_COND             = "addresssecond"
    static var TAG_ZIPCODE                  = "zipcode"
    static var TAG_CITY                     = "city"
    static var TAG_STATE                    = "state"
    static var TAG_COUNTRY                  = "country"
    static var TAG_CONTACT_FIRST            = "contactfirst"
    static var TAG_CONTACT_SECOND           = "contactsecond"
    static var TAG_ORDER_STATUS_CHANGE      = "orderstatuschange"
    static var TAG_MESSAGE                  = "message"
    static var TAG_SALESDATA                = "salesData"
    static var TAG_EMAIL                    = "email"
    static var TAG_CUSTOMER_NAME            = "customer_name"
    static var TAG_DEFAULT_SUBJECT          = "default_subject"
    static var TAG_LOGGEDINUSER_EMAIL       = "loggedinuser_email"
    static var TAG_CUSTOMER_EMAIL           = "customer_email"
    static var TAG_DEFAULT_MESSAGE          = "default_message"
    static var TAG_LOGGEDINUSER_NAME            = "loggedinuser_name"
    static var TAG_EMAILFROM                = "emailfrom"
    static var TAG_EMAILTO                  = "emailto"
    static var TAG_TONAME                   = "toname"
    static var TAG_FROMNAME                 = "fromname"
    static var TAG_SUBJECT                  = "subject"
    static var TAG_STATUS                   = "status"
    static var TAG_ORDER_ID                 = "orderid"
    static var TAG_ORDERSTATUS              = "orderstatus"
    
    //TODO: Tag For MyPoints
    static var TAG_POINTS_DETAIL            = "pointsDetail"
    static var TAG_POINTS                   = "points"
    static var TAG_DATA_REFERENCE           = "datareference"
    static var TAG_DATE                     = "date"
    static var TAG_TOTAL_POINTS              = "totalpoints"
    
    //TODO: Tag For Tax and Discount
    static var TAG_TAXDATA                  = "taxdata"
    static var TAG_MATHVALUE                = "mathvalue"
    static var TAG_VENDORID                 = "vendorid"
    static var TAG_ORDERING                 = "ordering"
    static var TAG_SHARED                   = "shared"
    static var TAG_AMOUNT                   = "amount"
    
    //TODO: Tag For Tax And Discount Form
    static var TAG_CALC_ID                  = "calc_id"
    
    //TODO: Tag For Shipment 
    static var TAG_SHIPMENT_DATA            = "shipmentData"
    static var TAG_SHIPMENT_ID              = "shipmentid"
    static var TAG_SHIPMENT_NAME            = "shipment_name"
    static var TAG_SHIPMENT_DESC            = "shipment_desc"
    static var TAG_PUBLISHED                = "published"
    static var TAG_COUNTRIES                = "countries"
    static var TAG_ZIP_START                = "zip_start"
    static var TAG_ZIP_STOP                 = "zip_stop"
    static var TAG_WEIGHT_START             = "weight_start"
    static var TAG_WEIGHT_STOP              = "weight_stop"
    static var TAG_WEIGHT_UNIT              = "weight_unit"
    static var TAG_NBPRODUCT_START          = "nbproducts_start"
    static var TAG_NBPRODUCT_STOP           = "nbproducts_stop"
    static var TAG_ORDERAMOUNT_START        = "orderamount_start"
    static var TAG_ORDERAMOUNT_STOP         = "orderamount_stop"
    static var TAG_SHIPMENT_COST            = "shipment_cost"
    static var TAG_TAX_NAME                 = "tax_name"
    static var TAG_PACKAGE_FEE              = "package_fee"
    static var TAG_FREE_SHIPMENT            = "free_shipment"
    static var TAG_CANDELETE                = "canDelete"
    
    //TODO: Tag For Review
    static var TAG_REVIEW_ID                = "review_id"
    static var TAG_COMMENT                  = "comment"
    static var TAG_RATING                   = "rating"
    static var TAG_CAN_PUBLISHED            = "canPublished"
    static var TAG_USER                     = "user"
    static var TAG_REVIEWS                  = "reviews"
    
    //TODO: Tag for Configuration
    static var TAG_CANCHANGE_ORDER_STATUS    = "canChangeOrderStatus"
    static var TAG_MANAGE_REVIEWS            = "manage_reviews"
    static var TAG_TAX_MODE                  = "tax_mode"
    static var TAG_SHIPMENT_MODE             = "shipment_mode"
    static var TAG_SHOW_POINTSTAB            = "show_pointstab"
}


//MARK: JOMSocial Commonent Contants
struct JomSocial
{
    static var arrPrivacyOption : NSArray = ["Public","Site Members","Friends","OnlyMe"]
    
    // Extension Name List
    static var TAG_EXTNAME_JOMSOCIAL    = "jomsocial"
    
    //TODO: Extension Task List
    static var TAG_EXTTASK_WALL          = "wall"
    static var TAG_EXTTASK_GENERATEACTIVITY = "generateActivity"
    static var TAG_EXTTASK_LIKE          = "like"
    static var TAG_EXTTASK_ADD_LIKE      = "addlike"
    static var TAG_EXTTASK_UNLIKE        = "unlike"
    static var TAG_EXTTASK_DISLIKE       = "dislike"
    static var TAG_EXTTASK_ALLALBUMS     = "allAlbums"
    static var TAG_EXTTASK_MYALLBUMS     = "myAlbums"
    static var TAG_EXTTASK_ALBUMDETAIL   = "albumDetail"
    static var TAG_EXTTASK_PHOTOS        = "photos"
    static var TAG_EXTTASK_ADDCOMMENT    = "addComment"
    static var TAG_EXTTASK_COMMENTS      = "comments"
    static var TAG_EXTTASK_GETVIDEODETAIL   = "getVideoDetail"
    static var TAG_EXTTASK_REMOVECOMMENT    = "removeComment"
    static var TAG_EXTTASK_REMOVEALBUM      = "removeAlbum"
    static var TAG_EXTTASK_UPLOADPHOTO      = "uploadPhoto"
    static var TAG_EXTTASK_UPLOADWALLPHOTO  = "uploadWallPhoto"
    static var TAG_EXTTASK_ADDALBUM         = "addAlbum"
    static var TAG_EXTTASK_REMOVEPHOTO      = "removePhoto"
    static var TAG_EXTTASK_SETAVATAR        = "setAvatar"
    static var TAG_EXTTASK_SETPHOTO_AS_PROFILEAVTAR     = "setPhotoAsProfileAvatar"
    static var TAG_EXTTASK_SETPHOTOCAPTION                = "setPhotoCaption"
    static var TAG_EXTTASK_REPORT           = "report"
    static var TAG_EXTTASK_TAGS             = "tags"
    static var TAG_EXTTASK_FRIENDS          = "friends"
    static var TAG_EXTTASK_TAGFRIENDS       = "tagFriends"
    static var TAG_EXTTASK_ADDTAG           = "addTag"
    static var TAG_EXTTASK_REMOVETAG        = "removeTag"
    static var TAG_EXTTASK_MYVIDEO          = "myVideos"
    static var TAG_EXTTASK_ALLVIDEO         = "allVideos"
    static var TAG_EXTTASK_VIDEOCATEGORIES  = "videoCategories"
    static var TAG_EXTTASK_LINKVIDEO        = "linkVideo"
    static var TAG_EXTTASK_UPLOADVIDEO      = "uploadVideo"
    static var TAG_EXTTASK_REMOVEVIDEO      = "removeVideo"
    static var TAG_EXTTASK_SETPROFILEVIDEO  = "setProfileVideo"
    static var TAG_EXTTASK_SEARCHVIDEO      = "searchVideo"
    static var TAG_EXTTASK_PREFRENCES       = "preferences"
    static var TAG_EXTTASK_ADDGROUP         = "addGroup"
    static var TAG_EXTTASK_PROFILE          = "profile"
    static var TAG_EXTTASK_UPDATEPROFILE    = "updateProfile"
    static var TAG_EXTTASK_NEWAVTARUPLOAD   = "newAvatarUpload"
    static var TAG_EXTTASK_USERDETAIL       = "userDetail"
    static var TAG_EXTTASK_FRIENDLIST       = "friendlist"
    static var TAG_EXTTASK_ADDEVENT         = "addEvent"
    static var TAG_EXTTASK_SENDMAIL         = "sendmail"
    static var TAG_EXTTASK_SETUSERCOVER     = "setUserCover"
    static var TAG_EXTTASK_REMOVEFRIEND     = "removeFriend"
    static var TAG_EXTTASK_APPROVEREQUEST   = "approveRequest"
    static var TAG_EXTTASK_REJECTREQUEST    = "rejectRequest"
    static var TAG_EXTTASK_GETCOMMENTS      = "getComments"
    static var TAG_EXTTASK_EDITCOMMENT      = "editComment"
    static var TAG_EXTTASK_SEARCH           = "search"
    static var TAG_EXTTASK_GROUPS           = "groups"
    static var TAG_EXTTASK_EVENTS           = "events"
    static var TAG_EXTTASK_SETALBUMCOVER    = "setCover"
    static var TAG_EXTTASK_SET_DEFAULT_PHOTO_FORALBUM   = "setDefaultPhotoForAlbum"
    static var TAG_EXTTASK_NOTIFICATION    = "notification"
    static var TAG_EXTTASK_UPDATEPRIVACYACTIVITY        = "updatePrivacyActivity"
    static var TAG_EXTTASK_REMOVEPROFILEVIDEO           = "removeProfileVideo"
    static var TAG_EXTTASK_HIDESTATUS                   = "hideStatus"
    static var TAG_EXTTASK_REMOVEAVATAR          = "removeAvatar"
    static var TAG_EXTTASK_REMOVECOVER           = "removecover"
    static var TAG_EXTTASK_UNIQUEID    = "id"
    static var TAG_EXTTASK_MOVEPHOTO    = "movePhoto"
    static var TAG_EXTTASK_REMOVEMOOD           = "removeMood"
    static var TAG_EXTTASK_REMOVELOCATION       = "deleteLocation"
    static var TAG_EXTTASK_ROTATEPHOTO      = "rotatePhoto"
    static var TAG_EXTTASK_DELETE_SENT_FRIEND_REQ    = "deleteSentFriendReq"
    static var TAG_EXTTASK_ALLREPORT                = "allReport"
    static var TAG_EXTTASK_CRAWL_URL                 = "crawl_url"
    static var TAG_EXTTASK_EVENTCATLIST              = "eventCatList"
    static var TAG_EXTTASK_DELETEACTIVITY            = "deleteActivity"
    static var TAG_EXTTASK_STEAMREMOVECOMMENT        = "streamRemoveComment"
    static var TAG_EXTTASK_STEAMADDCOMMENT           = "streamAddComment"
    static var TAG_EXTTASK_INBOX                     = "inbox"
    static var TAG_EXTTASK_SENT                      = "sent"
    static var TAG_EXTTASK_MARKMESSAGE               = "markMessage"
    static var TAG_EXTTASK_CREATEVIDEO               = "createVideo"
    static var TAG_EXTTASK_REMOVEMESSAGE             = "removeMessage"
    static var TAG_EXTTASK_NEW_COVER_UPLOAD          = "newCoverUpload"
    static var TAG_EXTTASK_SAVEDISCUSSION_WALL       = "saveDiscussionWall"
    static var TAG_EXTTASK_EDITDISCUSSION_WALL       = "editDiscussionWall"
    static var TAG_EXTTASK_BLOCK_UNBLOCK_USER          = "blockUnblockUser"
    static var TAG_EXTTASK_IGNORE_UNIGNORE_USER        = "ignoreUnignoreUser"
    static var TAG_EXTTASK_DO_FEATURE_UNFEATURE_USER    = "doFeaturedUnfeaturedUser"
    static var TAG_EXTTASK_DO_BAN_UNBAN_USER            = "doBanUnbanUser"
    static var TAG_EXTTASK_DO_BAN_UNBAN_MEMBER          = "doBanUnbanMember"
    static var TAG_EXTTASK_DO_ADMIN                     = "doAdmin"
    static var TAG_EXTTASK_BAN_MEMBERS                   = "banMembers"
    static var TAG_EXTTASK_DO_ACCEPT_REJECT_INVITATION  = "doAcceptRejectInvitation"
    static var TAG_EXTTASK_RESPONSE                     = "response"
    static var TAG_EXTTASK_NOTIFICATIONS                 = "notifications"
    static var TAG_EXTTASK_PHOTODETAIL                  = "photoDetail"
    
    // Extension Task Event
    static var TAG_EXTTASK_DETAIL           = "detail"
    static var TAG_EXTTASK_MEMBERS          = "members"
    static var TAG_EXTTASK_UPDATE          = "update"
    static var TAG_EXTTASK_WRITE            = "write"
    static var TAG_EXTTASK_REMOVE              = "remove"
    static var TAG_EXTTASK_ADDFRIEND          = "addfriend"
    //    static var TAG_EXTTASK_MEMBERBLOCKUNBLOCK =   "memberBlockUnblock"
    //    static var TAG_EXTTASK_BANUSER =            "banUserByAdmin"
    //    static var TAG_EXTTASK_IGNOREMEMBER =       "memberIgnoreUnignore"
    static var TAG_EXTTASK_EDITAVTAR =       "editAvatar"
    
    
    
    
    
    // Extension View List
    static var TAG_EXTVIEW_WALL         = "wall"
    static var TAG_EXTVIEW_MEDIA        = "media"
    static var TAG_EXTVIEW_FRIEND       = "friend"
    static var TAG_EXTVIEW_USER         = "user"
    static var TAG_EXTVIEW_GROUP        = "group"
    static var TAG_EXTVIEW_EVENT        = "event"
    static var TAG_EXTVIEW_MESSAGE      = "message"
    
    
    //// ------------ Notification Tags -----------
    static var TAG_FIELD_RAW_DETAIL                         = "raw_detail"
    static var TAG_FIELD_EVENT_TITLE                        = "eventtitle"
    static var TAG_FIELD_GROUP_TITLE                        = "grouptitle"
    static var TAG_FIELD_ANNOUNCEMENT_TITLE                 = "announcementtitle"
    static var TAG_FIELD_EVENTID                            = "eventid"
    static var TAG_FIELD_PHOTO_ID                            = "photoid"
    static var TAG_FIELD_ALBUMID                           = "albumid"
    static var TAG_FIELD_ALBUM_id                           = "album_id"
    static var TAG_FIELD_PHOTO_id                           = "photo_id"
    static var TAG_FIELD_VIDEO_id                           = "video_id"
    static var TAG_FIELD_GROUP_ID                            = "groupid"
    static var TAG_FIEDL_GROUPID                            = "group_id"
    static var TAG_FIELD_DISCUSSION_ID                      = "discussionId"
    static var TAG_FIELD_DISCUSSION_TITLE                   = "discussiontitle"
    static var TAG_FIELD_VIDEO_TITLE                        = "videotitle"
    static var TAG_FIELD_VIDEOS_ID                          = "videoid"
    static var TAG_FIELD_MESSAGETITLE                       = "messagetitle"
    static var TAG_FIELD_ANNOUNCEMENT_ID                    = "announcementid"
    static var TAG_FIELD_MESSAGE_ID                         = "messageid"
    static var TAG_FIELD_MSGID                              = "msgID"
    
    static var TAG_NOTI_TYPE_FRIEND_CONNECTION              = "notif_friends_create_connection"
    static var TAG_NOTI_TYPE_PROFILE_LIKE                   = "notif_profile_like"
    static var TAG_NOTI_TYPE_PROFILE_STATUS_UPDATE          = "notif_profile_status_update"
    static var TAG_NOTI_TYPE_GROUPS_CREATE_EVENT            = "notif_groups_create_event"
    static var TAG_NOTI_TYPE_GROUP_WALL_CREATED             = "notif_groups_wall_create"
    static var TAG_NOTI_TYPE_PROFILE_STEAM_LIKE             = "notif_profile_stream_like"
    static var TAG_NOTI_TYPE_GROUP_DISCUSSION_REPLY         = "notif_groups_discussion_reply"
    static var TAG_NOTI_TYPE_PHOTOS_LIKE                    = "notif_photos_like"
    static var TAG_NOTI_TYPE_ACTIVITY_ADD_COMMENT           = "notif_profile_activity_add_comment"
    static var TAG_NOTI_TYPE_EVENTS_SUBMIT_WALL_COMMENT     = "notif_events_submit_wall_comment"
    static var TAG_NOTI_TYPE_GROUPS_ACTIVITY_ADD_COMMENT    = "notif_groups_activity_add_comment"
    static var TAG_NOTI_TYPE_VIDEOS_TAGGING                 = "notif_videos_tagging"
    static var TAG_NOTI_TYPE_PHOTOS_TAGGING                 = "notif_photos_tagging"
    static var TAG_NOTI_TYPE_GROUPS_INVITE                  = "notif_groups_invite"
    static var TAG_NOTI_TYPE_GROUPS_MEMBER_JOIN             = "notif_groups_member_join"
    static var TAG_NOTI_TYPE_INBOX_CREATE_MESSAGE           = "notif_inbox_create_message"
    static var TAG_NOTI_TYPE_EVENTS_INVITE                  = "notif_events_invite"
    static var TAG_NOTI_TYPE_EVENTS_JOIN_REQUEST            = "notif_event_join_request"
    static var TAG_NOTI_TYPE_GROUPS_CREATE_NEWS             = "notif_groups_create_news"
    static var TAG_NOTI_TYPE_EVENTS_INVITATION_APPROVED    = "notif_events_invitation_approved"
    
    ///////  ------ TAGS for User Wall data -----------  //
    static var TAG_FIELD_DATA                               = "data"
    static var TAG_TYPE_STREAM                               = "stream"
    static var TAG_TYPE                                     = "type"
    static var TAG_TYPE_ACTIVITY                            = "activity"
    static var TAG_PAGENO                                   = "pageNO"
    static var TAG_FIELD_UPDATE                             = "update"
    static var TAG_FIELD_NOTIFICATION                       = "notification"
    static var TAG_FIELD_PAGE_LIMIT                         = "pageLimit"
    static var TAG_FIELD_TOTAL                              = "total"
    static var TAG_FIELD_USER_DETAIL                        = "user_detail"
    static var TAG_FIELD_USERID                             = "user_id"
    static var TAG_FIELD_USER_NAME                          = "user_name"
    static var TAG_FIELD_USER_AVATAR                        = "user_avatar"
    static var TAG_FIELD_USER_PROFILE                       = "user_profile"
    static var TAG_FIELD_CONTENT                            = "content"
    static var TAG_FIELD_DATE                               = "date"
    static var TAG_FIELD_POSTED_ON                          = "posted_on"
    static var TAG_FIELD_LIKE_ALLOWED                       = "likeAllowed"
    static var TAG_FIELD_LIKE_COUNT                         = "likeCount"
    static var TAG_FIELD_LIKED                              = "liked"
    static var TAG_FIELD_COMMENT_ALLOWED                    = "commentAllowed"
    static var TAG_FIELD_COMMENT_COUNT                      = "commentCount"
    static var TAG_FIELD_COMMENT_TEXT                       = "comment_text"
    static var TAG_FIELD_LIKE_TYPE                          = "liketype"
    static var TAG_FIELD_COMMENT_TYPE                       = "commenttype"
    static var TAG_FIELD_TYPE                               = "type"
    static var TAG_FIELD_CONTENT_DATA                       = "content_data"
    static var TAG_FIELD_CONTENT_DATA_DESC                  = "description"
    static var TAG_FIELD_CONTENT_DATA_PERMISSION            = "permission"
    static var TAG_FIELD_CONTENT_DATA_THUMB                 = "thumb"
    static var TAG_FIELD_CONTENT_DATA_DATE                  = "date"
    static var TAG_FIELD_CONTENT_DATA_COUNT                 = "count"
    static var TAG_FIELD_CONTENT_DATA_LOCATION              = "location"
    static var TAG_FIELD_CONTENT_DATA_LIKES                 = "likes"
    static var TAG_FIELD_CONTENT_DATA_DISLIKES              = "dislikes"
    static var TAG_FIELD_CONTENT_DATA_LIKED                 = "liked"
    static var TAG_FIELD_CONTENT_DATA_IS_LIKED              = "is_liked"
    static var TAG_FIELD_CONTENT_DATA_DISLIKED              = "disliked"
    static var TAG_FIELD_CONTENT_DATA_COMMENT_COUNT         = "commentCount"
    static var TAG_FIELD_CONTENT_DATA_COMMENT_SHARE_LINK    = "shareLink"
    static var TAG_FIELD_CONTENT_DATA_COMMENT_DELETE_ALLOWED = "deleteAllowed"
    static var TAG_FIELD_CONTENT_DATA_COMMENT_EDIT_ALBUM    = "editAlbum"
    static var TAG_FIELD_EDIT_ALBUM_ALLOWED                         = "editAlbum"
    static var TAG_FIELD_EDIT_ALBUMALLOWED                  = "editAllowed"
    static var TAG_FIELD_DELETE_ALBUM_ALLOWED                       = "deleteAllowed"
    static var TAG_FIELD_IMAGE_DATA                         = "image_data"
    static var TAG_FIELD_IMAGE_DATA_CAPTION                 = "caption"
    static var TAG_FIELD_IMAGE_DATA_THUMB                   = "thumb"
    static var TAG_FIELD_IMAGE_DATA_URL                     = "url"
    static var TAG_FIELD_IMAGE_DATA_SHARE_LINK              = "shareLink"
    static var TAG_FIELD_IMAGE_DATA_LIKES                   = "likes"
    static var TAG_FIELD_IMAGE_DATA_DISLIKES                = "dislikes"
    static var TAG_FIELD_IMAGE_DATA_LIKED                   = "liked"
    static var TAG_FIELD_IMAGE_DATA_DISLIKED                = "disliked"
    static var TAG_FIELD_IMAGE_DATA_COMMENT_COUNT           = "commentCount"
    static var TAG_FIELD_IMAGE_DATA_TAGS                    = "tags"
    static var TAG_FIELD_TITLE_TAG                          = "titletag"
    static var TAG_FIELD_DESCRIPTION                        = "description"
    static var TAG_FIELD_CAPTION                            = "caption"
    static var TAG_FIELD_DELETE_ALLOWED                     = "deleteAllowed"
    static var TAG_FIELD_PAGENO                             = "pageNO"
    static var TAG_FIELD_COMMENT                            = "comment"
    static var TAG_FIELD_IMAGE_CHANGE                       = "image_change"
    static var TAG_FIELD_UNIQUE_ID                          = "uniqueID"
    static var TAG_FIELD_UNIQUEID                           = "uniqueId"
    static var TAG_FIELD_PHOTOID                            = "photoID"
    static var TAG_FIELD_USERDATA                           = "userData"
    static var TAG_FIELD_MOOD_DESCRIPTION                   = "mood_description"
    static var TYPE_FIELD_MOOD                              = "mood"
    static var TYPE_FIELD_MOODIMAGE                         = "moodImage"
    static var TYPE_FIELD_VALUE                             = "value"
    static var TYPE_FIELD_FILTER                            = "filter"
    static var TYPE_FIELD_ATTENDEE                          = "attendee"
    static var TYPE_FIELD_ACTIVITYID                        = "activityId"
    static var TYPE_FIELD_NEWPRIVACY                        = "newPrivacy"
    static var TYPE_FIELD_PERMISSIONS                        = "permissions"
    static var TAG_FIELD_MOOD                               = "mood"
    static var TAG_FIELD_LOCAITON_DATA                      = "location_data"
    static var TAG_FIELD_LOCATION_TYPE                      = "locationType"
    static var TAG_FIELD_DETAIL                             = "details"
    static var TAG_FIELD_GETLIKES                           = "getLikes"
    static var TAG_FROM_NAME                                = "from_name"
    static var TAG_TO_NAME                                  = "to_name"
    static var TAG_CREATORTYPE                              = "creatorType"
    static var TAG_ACTION                                   = "action"
    
    static var TAG_FIELD_ACTIVITY_ID        = "activity_id"
    static var TAG_FIELD_ACTID               = "actID"
    static var TAG_FIELD_ALBUM_ID          = "albumID"
    static var TAG_FIELD_PHOTOS            = "photos"
    static var TAG_FIELD_ALBUMS_COUNT      = "count"
    static var TAG_FIELD_QUERY             = "query"
    static var TAG_FIELD_MEMBER            = "member"
    static var TAG_FIELD_USER_ONLINE       = "user_online"
    static var TAG_FIELD_SORTING           = "sorting"
    
    static var TAG_FIELD_LATEST            = "latest"
    static var TAG_FIELD_WITH_LIMIT        = "withLimit"
    static var TAG_TRUE                    = "TRUE"
    static var TAG_FIELD_CATEGORYID        = "categoryID"
    static var TAG_FIELD_GROUPID           = "groupID"
    static var TAG_FIELD_VIDEOS            = "videos"
    static var TAG_FIELD_FORM              = "form"
    static var TAG_FIELD_SECTION           = "section"
    static var TAG_FIELD_CATEGORYId        = "categoryId"
    static var TAG_FIELD_IMAGECOUNT        = "imageCount"
    static var TAG_FIELD_ISDEFAULT         = "isDefault"
    static var TAG_FIELD_PARAMS            = "params"
    
    static var TAG_FIELD_CATEGORIES    = "categories"
    static var TAG_FIELD_TITLE         = "title"
    static var TAG_FIELD_VIDEOID       = "videoID"
    static var TAG_FIELD_FORM_DATA     = "formData"
    static var TAG_FIELD_PLACE         = "Place"
    static var TAG_FIELD_VICINITY            = "vicinity"
    static var TAG_FIELD_GEOMETRY      = "geometry"
    
    static var TAG_FIELD_PRIVACY        = "privacy"
    static var TAG_FIELD_FORMATTED_ADDRESS     = "formatted_address"
    static var TAG_FIELD_ALL                   = "all"
    static var TAG_FIELD_MY                    = "my"
    static var TAG_FIELD_PENDING               = "pending"
    static var TAG_FIELD_PAST                  = "past"
    static var TAG_FIELD_EVENTS                = "events"
    static var TAG_FIELD_EVENT                = "event"
    static var TAG_FIELD_EVENT_ID                = "eventID"
    static var TAG_FIELD_EVETNID                 = "event_id"
    static var TAG_FIELD_AVATAR                = "avatar"
    static var TAG_FIELD_ENDDATE               = "enddate"
    static var TAG_FIELD_CONFIRMED             = "confirmed"
    static var TAG_FIELD_SEARCH                = "search"
    static var TAG_TITLE_SAVE                  = "Save"
    static var TAG_TITLE_DONE                  = "Done"
    static var TAG_FIELD_TIMEZONE              = "Timezone"
    static var TAG_FIELD_CATID                 = "catid"
    static var TAG_FIELD_OFFFSET               = "offset"
    static var TAG_FIELD_GUEST                 = "guest"
    static var TAG_FIELD_CATEGORY              = "category"
    static var TAG_FIELD_AVAILABLE_SEAT        = "available_seats"
    static var TAG_FIELD_TOTAL_SEAT            = "total_seats"
    static var TAG_FIELD_SUMMARY               = "summary"
    static var TAG_FIELD_STARTDATE             = "startdate"
    static var TAG_FIELD_END_DATE               = "endDate"
    static var TAG_FIELD_MYSTATUS              = "myStatus"
    static var TAG_TITLE_UNLIMITED_SEAT        = "Unlimited Seats"
    static var TAG_FIELD_MENU                  = "menu"
    static var TAG_FIELD_ISOPEN                = "isOpen"
    static var TAG_FIELD_ISINVITATION          = "isInvitation"
    static var TAG_FIELD_ISWAITINGAPPROVAL     = "isWaitingApproval"
    static var TAG_FIELD_EDIT_AVATAR           = "editAvatar"
    static var TAG_FIELD_SENDMAIL              = "sendMail"
    static var TAG_FIELD_EDITEVENT             = "editEvent"
    static var TAG_FIELD_ISPRIVATE             = "isPrivate"
    static var TAG_FIELD_IS_COMMUNITY_ADMIN    = "isCommunityAdmin"
    static var TAG_FIELD_IS_ADMIN              = "isAdmin"
    static var TAG_FIELD_INVITE_FRIEND         = "inviteFriend"
    static var TAG_FIELD_ISLOCKED              = "isLocked"
    static var TAG_FIELD_IGNORE_EVENT          = "ignoreEvent"
    static var TAG_FIELD_DELETE_EVENT          = "deleteEvent"
    static var TAG_FIELD_YOUR_RESPONSE         = "yourResponse"
    static var TAG_FIELD_FILE_PERMISSION       = "filePermission"
    static var TAG_FIELD_ORIENTATION           = "orientation"
    static var TAG_FIELD_EDITCOVER             = "editCover"
    
    static var TAG_TITLE_WAITING_EVENT_APPROVAL         = "This is a private event \nYour request is awaiting approval from event administrator."
    static var TAG_TITLE_PRIVATE_EVENT                 = "This is a private event."
    
    static var TAG_FIELD_STATUS                = "status"
    static var TAG_FIELD_MESSAGE               = "message"
    static var TAG_FIELD_DISLIKE               = "dislike"
    static var TAG_FIELD_COMMENTS              = "comments"
    static var TAG_FIELD_FIRSTNAME             = "firstname"
    static var TAG_FIELD_LASTNAME              = "lastname"
    static var TAG_FIELD_IMAGE                 = "image"
    static var TAG_FIELD_SELECTED              = "selected"
    static var TAG_FIELD_WAITING               = "waiting"
    static var TAG_FIELD_MEMBERID              = "memberID"
    static var TAG_FIELD_SIADMIN               = "isAdmin"
    static var TAG_FIELD_CAN_REMOVE            = "canRemove"
    static var TAG_FIELD_CAN_CREATE            = "canCreate"
    static var TAG_FIELD_CAN_DELETE            = "canDelete"
    static var TAG_FIELD_CAN_EDIT              = "canEdit"
    static var TAG_FIELD_CAN_LOCK              = "canLock"
    static var TAG_FIELD_FILEPERMISSION        = "filePermission"
    static var TAG_FIELD_CAN_ADMIN             = "canAdmin"
    static var TAG_FIELD_CAN_MEMBER            = "canMember"
    static var TAG_FIELD_ADMIN                 = "admin"
    static var TAG_FIELD_INVITATIONICON        = "invitationicon"
    static var TAG_FIELD_INVITATIONMESSAGE     = "invitationMessage"
    static var TAG_FIELD_CAT_ID                = "catID"
    static var TAG_FIELD_MEMBERS               = "members"
    static var TAG_FIELD_DISCUSSIONS           = "discussions"
    static var TAG_FIELD_DISCUSSION           = "discussion"
    static var TAG_FIELD_WALLS                 = "walls"
    static var TAG_FIELD_GROUP                 = "group"
    static var TAG_FIELD_GROUP_WALL            = "groups.wall"
    static var TAG_FIELD_CATEGORYNAME          = "category_name"
    static var TAG_FIELD_FILES                 = "files"
    static var TAG_FIELD_JOINGROUP             = "joinGroup"
    static var TAG_FIELD_SHAREGROUP            = "shareGroup"
    static var TAG_FIELD_REPORTGROUP           = "reportGroup"
    static var TAG_FIELD_CREATE_DISCUSSION     = "createDiscussion"
    static var TAG_FIELD_CREATEANNOUNCEMENT     = "createAnnouncement"
    static var TAG_FIELD_ALBUMLIST             = "albumList"
    static var TAG_FIELD_ANNOUNCEMENTLIST      = "announcementList"
    static var TAG_FIELD_DISCUSSIONLIST        = "discussionList"
    static var TAG_FIELD_EVENTLIST             = "eventList"
    static var TAG_FIELD_MEMBERLIST            = "memberList"
    static var TAG_FIELD_VIDEOLIST             = "videoList"
    static var TAG_FIELD_WALLLIST              = "wallList"
    static var TAG_FIELD_ADMINMENU             = "adminMenu"
    static var TAG_FIELD_ISMEMBER              = "isMember"
    static var TAG_FIELD_OPTION                = "option"
    static var TAG_FIELD_FILE                  = "file"
    static var TAG_FIELD_DELETEGROUP           = "deleteGroup"
    static var TAG_FIELD_EDIT                  = "edit"
    static var TAG_FIELD_UNPUBLISHGROUP        = "unpublishGroup"
    static var TAG_FIELD_CATEGORY_ID            = "categoryid"
    static var TAG_FIELD_ANNOUNCMENTS           = "announcements"
    static var TAG_FIELD_ACTIVITY              = "activity"
    static var TAG_FIELD_ANNOUNCEMENT          = "announcement"
    static var TAG_FIELD_IS_PHOTO_OWNER        = "is_photo_owner"
    
    static var TAG_SCREEN_HOME                 = "Home"
    static var TAG_SCREEN_PROFILE              = "JomProfile"
    static var TAG_SCREEN_ALBUM                = "JomAlbums"
    static var TAG_SCREEN_FRIENDS              = "JomFriendList"
    static var TAG_SCREEN_PRIVACY_SETTING              = "JomPrivacySetting"
    static var TAG_SCREEN_VIDEO                = "JomVideo"
    static var TAG_SCREEN_GROUP                = "JomGroup"
    static var TAG_SCREEN_EVENT                = "JomEvent"
    static var TAG_SCREEN_ACTIVITY             = "JomActivities"
    static var TAG_SCREEN_MESSAGE              = "JomMessage"
    static var TAG_SCREEN_LOGIN                = "Login"
    static var TAG_SCREEN_LOGOUT               = "Logout"
    
    static var TAG_FIELD_CONDITION             = "condition"
    static var TAG_FIELD_RANGE                 = "range"
    static var TAG_FIELD_VALUETYPE             = "valuetype"
    static var TAG_FIELD_VALUE                 = "value"
    static var TAG_FIELD_GENDER                = "gender"
    static var TAG_FIELD_OPTIONS               = "options"
    
    static var TAG_FIELD_CURRENTFIELD_DETAIL   = "currentFieldDetail"
    static var TAG_FIELD_CURRENT_CONDITION     = "currentCondtion"
    static var TAG_FIELD_BETWEEN               = "between"
    static var TAG_FIELD_FIELD_VALUE           = "fieldValue"
    static var TAG_FIELD                       = "field"
    static var TAG_FIELD_FIELDCODE             = "fieldcode"
    static var TAG_FIELD_FIELDID               = "fieldid"
    static var TAG_FIELD_FIELDTYPE             = "fieldtype"
    static var TAG_FIELD_OPERATOR              = "operator"
    static var TAG_FIELD_AVATAR_ONLY           = "avatarOnly"
    static var TAG_FIELD_MESSAGES              = "messages"
    static var TAG_FIELD_SUBJECT               = "subject"
    static var TAG_FIELD_OUTGOING              = "outgoing"
    static var TAG_FIELD_BODY                  = "body"
    static var TAG_FIELD_PHOTO                 = "photo"
    static var TAG_FIELD_DESC                  = "desc"
    static var TAG_FIELD_POSITION              = "position"
    static var TAG_FIELD_PHOTO_DETAIL          = "photoDetail"
    static var TAG_FIELD_COMMENT_LIST          = "commentList"
    static var TAG_FIELD_FRIENDS               = "friends"
    static var TAG_FIELD_WALLID                = "wallID"
    static var TAG_FIELD_PHOTO_WALL_CREATE     = "photos.wall.create"
    static var TAG_FIELD_GROUP_DATA            = "group_data"
    static var TAG_FIELD_TYPE_GROUP_PHOTO_UPLOAD    = "groups.avatar.upload"
    static var TAG_FIELD_TYPE_COVER_UPLOAD     = "cover.upload"
    static var TAG_FIELD_EVENT_DATA            = "event_data"
    static var TAG_FIELD_PROFILE               = "profile"
    static var TAG_FIELD_STREAM                = "stream"
    static var TAG_FIELD_TAGS                  = "tags"
    static var TAG_FIELD_DISCUSSIONID         = "discussionID"
    static var TAG_FIELD_VIDEO                 = "video"
    static var TAG_FIELD_VIDEO_ID              = "videoID"
    static var TAG_FIELD_REPLY                 = "reply"
    static var TAG_FIELD_REPLYS                = "replys"
    static var TAG_FIELD_BULLETIN              = "bulletin"
    static var TAG_FIELD_ANNOUNCEMENTID        = "announcementID"
    static var TAG_FIELD_HITS                  = "hits"
    static var TAG_FIELD_SIZE                  = "size"
    static var TAG_FIELD_GLOBAL_NOTIFICATION   = "globalNotification"
    static var TAG_FIELD_FRIEND_NOTIFICATION   = "friendNotification"
    static var TAG_FIELD_MESSAGE_NOTIFICATION  = "messageNotification"
    static var TAG_FIELD_DELETE                = "delete"
    static var TAG_FIELD_GROUPS                = "groups"
    static var TAG_FIELD_VIDEOPERMISSION       = "videopermission"
    static var TAG_FIELD_ALBUMPERMISSION       = "albumpermission"
    static var TAG_FIELD_EVENTPERMISSION       = "eventpermission"
    static var TAG_FIELD_NOTIFICATION_TITLE          = "notif_title"
    static var TAG_FIELD_NOTIFICATIONS         = "notifications"
    static var TAG_FIELD_GLOBAL                = "global"
    static var TAG_FIELD_CONNECTIONID          = "connectionID"
    static var TAG_FIELD_READ                  = "read"
    static var TAG_FIELD_PERMISSIONS           = "permissions"
    static var TAG_FIELD_PERMISSION            = "permission"
    static var TAG_FIELD_PROFILE_STATUS              = "profile.status"
    static var TAG_FIELD_ID                     = "id"
    static var TAG_FIELD_VIDEO_DATA             = "video_data"
    static var TAG_TYPE_PHOTOSCOMMENT          = "photos.comment"
    
    static var TAG_FIELD_SHOWBUTTON             = "showButton"
    static var TAG_FIELD_HIDESTREAM             = "hideStream"
    static var TAG_FIELD_STREAMREPORT           = "streamReport"
    static var TAG_FIELD_ALLOWPRIVACY           = "allowPrivacy"
    static var TAG_FIELD_DELETELOCATION         = "deleteLocation"
    static var TAG_FIELD_DELETEPOST             = "deletePost"
    static var TAG_FIELD_ADDLOCATION            = "addLocation"
    static var TAG_FIELD_UNFEATURE_ACTIVITY     = "unfeatureActivity"
    static var TAG_FIELD_IGNORESTREAM           = "ignoreStream"
    static var TAG_FIELD_ADDMOOD                = "addMood"
    static var TAG_FIELD_DELETEMOOD             = "deleteMood"
    static var TAG_FIELD_EDITPOST               = "editPost"
    static var TAG_FIELD_FEATUREACTIVITY        = "featureActivity"
    static var TAG_FIELD_ADMINACCESS            = "adminAccess"
    static var TAG_FIELD_CANBE_FEATURED          = "canBeFeatured"
    static var TAG_FIELD_CAN_BE_BANNED           = "canBeBanned"
    
    //-------- TAGS FOR USER PROFILE ---------- //
    
    static var TAG_FIELD_PROFILE_DISLIKED               = "disliked"
    static var TAG_FIELD_PROFILE_DISLIKES               = "dislikes"
    static var TAG_FIELD_PROFILE_IS_FRIEND_REQUEST_BY   = "isFriendReqBy"
    static var TAG_FIELD_PROFILE_IS_FRIENDREQ_TO        = "isFriendReqTo"
    static var TAG_FIELD_PROFILE_IS_FRIEND              = "isfriend"
    static var TAG_FIELD_PROFILE_IS_LIKE                = "isprofilelike"
    static var TAG_FIELD_PROFILE_LIKED                  = "liked"
    static var TAG_FIELD_PROFILE_LIEKS                  = "likes"
    static var TAG_FIELD_PROFILE_NOTIFICATION           = "notification"
    static var TAG_FIELD_PROFILE_TOTAL_FRIENDS                 = "totalfriends"
    static var TAG_FIELD_PROFILE_TOTAL_GROUP                 = "totalgroup"
    static var TAG_FIELD_PROFILE_TOTAL_PHOTOS                 = "totalphotos"
    static var TAG_FIELD_PROFILE_TOTAL_EVENTS          = "totalevents"
    static var TAG_FIELD_PROFILE_TOTAL_VIDEOS                 = "totalvideos"
    static var TAG_FIELD_PROFILE_USER_AVATAR                 = "user_avatar"
    static var TAG_FIELD_PROFILE_TOTAL_USER_LAT                 = "user_lat"
    static var TAG_FIELD_PROFILE_TOTAL_USER_LONG                 = "user_long"
    static var TAG_FIELD_PROFILE_USER_NAME                 = "user_name"
    static var TAG_FIELD_PROFILE_USER_STATUS                 = "user_status"
    static var TAG_FIELD_PROFILE_TOTAL_USER_VIEW_COUNT                 = "viewcount"
    static var TAG_FIELD_PROFILE_USERID                        = "userID"
    static var TAG_FIELD_PROFILE_USER_ID                       = "userId"
    static var TAG_FIELD_PROFILE_COVER_PIC                     = "coverpic"
    static var TAG_FIELD_PROFILE_COVER                         = "cover"
    static var TAG_FIELD_PROFILE_NAME                      = "name"
    static var TAG_FIELD_PROFILE_VIEWCOUNT                 = "viewcount"
    static var TAG_FIELD_PROFILE_TOTAL_FRINEDS             = "totalfriends"
    static var TAG_FIELD_PROFILE_VIDEO_STATUS              = "profile_video"
    static var TAG_FIELD_PROFILE_VIDEO_TITLE               = "title"
    static var TAG_FIELD_PROFILE_VIDEO_URL                 = "url"
    static var TAG_FIELD_PROFILE_USER_DETAIL               = "userDetail"
    static var TAG_FIELD_DELETE_PROFILE            = "deleteProfile"
    static var TAG_FIELD_CAPTION_FRIENDS                   = "Friend"
    static var TAG_FIELD_CAPTION_UNFRIEND                  = "Unfriend"
    static var TAG_FIELD_CAPTION_ADD_AS_FRIEND             = "Add as Friend"
    static var TAG_FIELD_CAPTION_REQUEST_PENDING           = "Pending Approval"
    static var TAG_FIELD_CAPTION_REQUEST_SENT              = "Cancel friend request"
    static var TAG_FIELD_ISPHOTOUPLOAD                     = "isPhotoUpload"
    static var TAG_FIELD_ISVIDEOUPLOAD                     = "isVideoUpload"
    static var TAG_FIELD_ADDVIDEO                          = "addVideo"
    static var TAG_FIELD_UPLOADPHOTO                       = "uploadPhoto"
    static var TAG_FIELD_CREATEEVENT                       = "createEvent"
    static var TAG_FIELD_CANREMOVECOVER                    = "canRemoveCover"
    static var TAG_FIELD_CANREMOVEAVTAR                    = "canRemoveAvatar"
    static var TAG_FIELD_ISPROFILELIKE                     = "isprofilelike"
    static var TAG_FIELD_PROFILE_ACCESS                    = "profile_access"
    
    ////  ----------  GENERAL TAGS FOR APPLICATION   --------------
    
    static var TAG_PROFILE_TYPE    = "Profile Type"
    static var TAG_PROFILE_TYPE_EXTENDED   = 1
    static var TAG_PROFILE_TYPE_SIMPLE     = 2
    static var TAG_CANCEL_TITLE    = "Cancel"
    static var TAG_OK_TITLE    = "OK"
    static var TAG_VALIDATION  = "Validation"
    static var TAG_TITLE_SUCSESS_FORGOT_USERNAME   = "You have sent an email with username.Please Login using that email"
    static var TAG_TITLE_SELECT_PHOTO      = "Select Photo"
    static var TAG_TITLE_OPEN_CAMERA       = "Capture"
    static var TAG_TITLE_FROM_GALLARY      = "From Gallery"
    static var TAG_TITLE_EDIT              = "Edit"
    static var TAG_TITLE_BACK              = "Back"
    static var TAG_TITLE_MORE              = "More"
    static var TAG_TITLE_REMOVE_PHOTO      = "Remove"
    static var TAG_TITLE_UPLOAD_PHOTO      = "Upload Photo"
    static var TAG_TITLE_MSG_REMOVE_PHOTO  = "Do you want to remove all photos from album?"
    static var TAG_TITLE_YES               = "YES"
    static var TAG_TITLE_NO                 = "NO"
    static var TAG_TITLE_ALBUM_DELETED     = "Album deleted successfully"
    static var TAG_TITLE_COVERPAGE_CHANGE_SUCCESS     = "Cover Page changed successfully"
    static var TAG_TITLE_SELECT_VIDEO      = "Select Video"
    static var TAG_TITLE_EVENT_CREATED_SUCCESS     = "Event added successfully"
    static var TAG_TITLE_EVENT_DELETE_SUCCESS      = "Event removed successfully"
    static var TAG_TITLE_GROUP_DELETE_SUCCESS      = "Group Removed successfully"
    static var TAG_TITLE_MAIL_SEND_SUCCESS         = "Mail sent successfully"
    static var TAG_TITLE_REMOVE_EVENT              = "Are you sure to remove Event?"
    static var TAG_TITLE_SELECT_REPORT_TYPE        = "Select Report Type"
    static var TAG_TITLE_VALIDATE_REPORT           = "Select report type to proceed"
    static var TAG_TITLE_REPORT_SEND_SUCCESS       = "Report sent successfully"
    static var TAG_TITLE_SHARE_SUCCESS             = "Successfully shared"
    static var TAG_TITLE_MAIL_CANCELED             = "Mail Canceled"
    static var TAG_TITLE_MAIL_SAVED                = "Mail Saved"
    static var TAG_TITLE_MAIL_FAILED               = "Mail sending Fail"
    static var TAG_TITLE_MAIL_NOT_SENT             = "Mail not sent.Please try again"
    static var TAG_TITLE_TITLE_DESC_REQUIRED       = "Please enter Title text and Description"
    static var TAG_TITLE_AVATAR_EDIT_SUCCESS       = "Avatar edited successfully"
    static var TAG_TITLE_INVITE_FRIEND             = "Invite Friend"
    static var TAG_TITLE_PLEASE_SELECT_USER        = "Please select user to send"
    static var TAG_TITLE_INVITATION_SENT           = "Invitation send successfully"
    static var TAG_TITLE_SUCCESS                   = "Success"
    static var TAG_TITLE_MEMBER_APPROVE_SUCCESS    = "Member Approved successfully"
    static var TAG_TITLE_MEMBER_REMOVE_SUCCESS     = "Member Removed successfully"
    static var TAG_TITLE_MEMBER_SET_ADMIN_SUCCESS  = "Member Set as admin successfully"
    static var TAG_TITLE_REQUEST_IS_WAITING        = "Your Request is waiting for admin approval"
    static var TAG_TITLE_JOINGROUP                 = "Join"
    static var TAG_TITLE_LEAVEGROUP                = "Leave"
    static var TAG_TITLE_DISCUSSION                = "Discussion"
    static var TAG_TITLE_ACTIVITY                  = "Activity"
    static var TAG_TITLE_ANNOUNCEMENT              = "Announcement"
    static var TAG_TITLE_CREATEANNOUNEMENT         = "Create Announcement"
    static var TAG_TITLE_CREATEDISCUSSION         = "Create Discussion"
    static var TAG_TITLE_CREATEGROUP               = "Create Group"
    static var TAG_TITLE_GROUP_CREATE_SUCCESS      = "Group Saved successfully"
    static var TAG_TITLE_SENDMAIL                  = "Send Mail"
    static var TAG_TITLE_UNPUBLISH                 = "Unpublish"
    static var TAG_TITLE_GROUP_UNPUBLISH_SUCCESS   = "Group Unpublish successfully"
    static var TAG_TITLE_RECENT_ACTIVITY           = "Recent Activities"
    static var TAG_TITLE_SELECT_CONDITION          = "Select Condtion"
    static var TAG_TITLE_ENTER_VALUE               = "Value required to search"
    static var TAG_TITLE_CRITERIA_REQUIRED         = "Add crieria to search"
    static var TAG_TITLE_CONNECTION_FAILED         = "Connection Fail"
    static var TAG_TITLE_TRY_AGAIN                 = "Try again after some time"
    static var TAG_TITLE_USER_SETTING_SAVED             = "User Privacy Setting updated"
    static var TAG_TITLE_DELETE                    = "Delete"
    static var TAG_TITLE_DELETE_MESSAGE                    = "Are you sure to Delete"
    static var TAG_TITLE_MESSAGE_SENT              = "Message sent successfully"
    static var TAG_TITLE_SUBJECT_REQUIRED          = "Subject is required to send message"
    static var TAG_TITLE_MESSAGE_CONTENT_REQUIRED          = "Message content is required to send message"
    static var TAG_TITLE_TAP_HERE_TO_ADD           = "Tap here to Add"
    static var TAG_TITLE_WRITE_MESSAGE             = "Write message.."
    static var TAG_TITLE_RECORD_AUDIO              = "please recoard audio first"
    static var TAG_TITLE_ALERT                     = "Alert"
    static var TAG_TITLE_HOLD_AND_SPEAK           = "Hold and Speek"
    static var TAG_TITLE_SEND                      = "Send"
    static var TAG_TITLE_ALL_ALBUM                 = "All Album"
    static var TAG_TITLE_MY_ALBUM                  = "My Album"
    static var TAG_TITLE_ADD_ALBUM                 = "AddAlbum"
    static var TAG_TITLE_DOWNLOAD_COMPLETE         = "Your download successfully saved"
    static var TAG_TITLE_ALERT_REMOVE_PHOTO        = "Are You sure to delete this Photo?"
    static var TAG_TITLE_PHOTO_REMOVED_SUCCESS     = "Photo Removed successfully"
    static var TAG_TITLE_PHOTO_SET_AS_AVATAR_SUCCESS   = "Photo set as user Avatar successfully"
    static var TAG_TITLE_PHOTO_SET_AS_USER_COVER_SUCCESS   = "Photo set as user Cover photo successfully"
    static var TAG_TITLE_ALERT_ENTER_ALBUMNAME     = "Enter album name to create album"
    static var TAG_TITLE_ALBUM_CREATE_SUCCESSS     = "Album created successfully"
    static var TAG_TITLE_ALBUM_UPDATE_SUCCESSS     = "Album detail updated successfully"
    static var TAG_TITLE_SELECT_USER               = "Select User"
    static var TAG_TITLE_TAG_NEW                   = "Tag New"
    static var TAG_TITLE_TAG                       = "Tag"
    static var TAG_TITLE_MENU                      = "Menu"
    static var TAG_TITLE_ALREADY_FRIENDS           = "Already Friends"
    static var TAG_TITLE_ADD_FRIENDS               = "Add Friends"
    static var TAG_TITLE_REMOVE            = "Are you sure you want to remove this?"
    static var TAG_TITLE_FRIEND_REQUEST_SEND_SUCCESS   = "Friends Request send successfully"
    static var TAG_TITLE_REMOVE_FRIEND_SUCCESS     = "User removed successfullu from your Friendlist"
    static var TAG_TITLE_LIKE                      = "Like"
    static var TAG_TITLE_COMMENT                   = "Comment"
    static var TAG_TITLE_UNLIKE                    = "UnLike"
    static var TAG_TITLE_MESSAGE                   = "Message"
    static var TAG_TITLE_REPORT_MESSAGE            = "Report Message"
    static var TAG_TITLE_SURE_TO_LOGOUT            = "Are you sure to Logout?"
    static var TAG_TITLE_VIDEO_UPLOAD_URL_SUCCESS      = "Video Uploaded successfully Using LINK URL"
    static var TAG_TITLE_VIDEO_UPLOAD_GALLERY_SUCCESS  = "Video Uploaded successfully from Gallery"
    static var TAG_TITLE_PEOPLE_COMMENTED              = "People commented on this."
    static var TAG_TITLE_REMOVE_VIDEO                  = "Do you want to remove video?"
    static var TAG_TITLE_LOCK                          = "Lock"
    static var TAG_TITLE_UNLOCK                        = "Unlock"
    static var TAG_TITLE_UPLOAD_FILE                   = "Upload File"
    static var TAG_TITLE_DISCUSSION_DELETE_SUCCESS     = "Discussion Removed successfully"
    static var TAG_TITLE_ANNNOUNCEMENT_DELETE_SUCCESS  = "Announcement Removed successfully"
    static var TAG_TITLE_REJECT                        = "Are you sure to Reject?"
    static var TAG_TITLE_VIDEO_DELETE_SUCCESS          = "Video deleted successfully"
    static var TAG_TITLE_SET_AS_PROFILE_VIDEO          = "Set as Profile Video"
    static var TAG_TITLE_VIDEO_UPDATE_SUCESS           = "Video updated successfully"
    static var TAG_TITLE_NO_MORE_NOTIFICATION          = "No more Notification Found"
    static var TAG_FIELD_URL                           = "url"
    static var TAG_IS_FOR_VIDEO                        = "is_forvideo"
    static var TAG_FIELD_VIEWCOUNT                     = "viewCount"
    
    //// ----------------- my albums tags  -------------------
    
    static var TAG_FIELD_ALBUMS                 = "albums"
    static var TAG_FIELD_ALBUM                  = "album"
    static var TAG_RESPONSE_PROFILETYPE         = "profiletype"
    static var TAG_FIELD_NAME                   = "name"
    static var TAG_FIELD_MAP                    = "map"
    static var TAG_FIELD_CHECKBOX               = "checkbox"
    static var TAG_FIELD_TYPE_SELECT            = "select"
    static var TAG_FIELD_TYPE_TEXT              = "text"
    static var TAG_FIELD_TYPE_TEXTAREA          = "textarea"
    static var TAG_FIELD_TYPE_FILE              = "file"
    static var TAG_FIELD_TYPE_LABEL             = "label"
    static var TAG_FIELD_TYPE_MAP               = "map"
    static var TAG_FIELD_TYPE_DATE              = "date"
    static var TAG_FIELD_TYPE_TIME              = "time"
    static var TAG_FIELD_TYPE_MULTIPLE_SELECT   = "multipleselect"
    static var TAG_FIELD_TYPE_DATETIME          = "datetime"
    static var TAG_FIELD_TYPE_GENDER            = "gender"
    static var TAG_FIELD_TYPE_BIRTHDATE         = "birthdate"
    static var TAG_FIELD_TYPE_COUNTRY           = "country"
    static var TAG_FIELD_LOCATION               = "location"
    static var TAG_FIELD_LAT                    = "lat"
    static var TAG_FIELD_LONG                   = "long"
    static var TAG_FIELD_LATITUDE               = "latitude"
    static var TAG_FIELD_LONGITUDE              = "longitude"
    static var TAG_FIELD_SHARELINK              = "shareLink"
    static var TAG_FIELD_UPLOADPHOTOALLOWED     = "uploadPhotoAllowed"
    
    //----- EventList tags----//
    static var TAG_EVENTS = "events"
    static var TAG_EVENT = "event"
    static var TAG_EVENT_TYPE = "type"
    static var TAG_SORTING = "sorting"
    static var TAG_TASK_EVENTS = "events"
    static var TAG_EVENT_TITLE = "title"
    static var TAG_EVENT_DATE = "date"
    static var TAG_EVENT_ONGOING = "ongoing"
    
    //----EventDetail tags----//
    static var TAG_EVENT_COVER              = "cover"
    static var TAG_EVENT_LIKES              = "likes"
    static var TAG_EVENT_DISLIKES           = "dislikes"
    static var TAG_EVENT_COMMENTS           = "comments"
    static var TAG_FIELD_PHOTOCOUNT         = "photoCount"
    static var TAG_FIELD_VIDEOCOUNT         = "videoCount"
    static var TAG_FIELD_GETGROUP_MEMBER    = "getGroupMember"
    //    static var TAG_FIELD_BAN                = "ban"
    static var TAG_FIELD_BLOCKMEMBER        = "blockMember"
    static var TAG_FIELD_IGNORE             = "ignore"
    static var TAG_FIELD_IS_IGNORED         = "is_ignored"
    static var TAG_FIELD_IS_BLOCKED         = "is_blocked"
    static var TAG_FIELD_IS_FEATURED        = "is_featured"
    static var TAG_FIELD_MEMBER_TYPE        = "Type"
    static var TAG_FIELD_BLOCK              = "Block"
    static var TAG_EVENT_ALLOW_INVITE       = "allowInvite"
    static var TAG_EVENT_RESPONSE           = "response"
    static var TAG_FIELD_MEMBER_WAITING     = "memberWaiting"
    static var TAG_FIELD_REQUEST_INVITE     = "requestInvite"
    static var TAG_FIELD_APPROVE_MEMBER     = "approveMember"
    static var TAG_FIELD_MEMBER_BLOCK       = "block"
    static var TAG_FIELD_CAN_INVITE_GROUPMEMBER     = "canInviteGroupMember"
    static var TAG_FIELD_EVENT_USERID               = "userID"
    static var TAG_FIELD_EVENT_CANCREATE_DUPLICATE  = "canCreateDuplicate"
    static var TAG_FIELD_EVENT_ISDUPLICATE          = "isDuplicate"
    static var TAG_FIELD_EVENT_VIEW_COUNT           = "viewCount"
    static var TAG_EVENT_UPDATESTATUS               = "updateStatus"
    static var TAG_FIELD_ISPRIVATE_EVENT            = "isPrivateEvent"
    
    //---CreateEvent tags----
    static var TAG_EVENT_FIELD_VALUE = "value"
    static var TAG_CREATE_EVENT_TITLE = "title"
    
    
    
    
    //---UserLIst tags----//
    static var TAG_TASK_MEMBERS = "member"
    
    //---Member tags---//
    
    static var TAG_FIELD_FRIEND = "friend"
    static var TAG_FIELD_FRIENDS_REQUEST = "friends_request"
    static var TAG_FIELD_BLOCK_MEMBER = "is_blocked"
    static var TAG_FIELD_UNBLOCK_MEMBER = "unblock"
    static var TAG_FIELD_DATA_USERID   = "userID"
    static var TAG_FIELD_IGNORE_MEMBER   = "is_ignored"
    static var TAG_FIEDL_IGNORE          = "Ignor"
    static var TAG_FIELD_UNIGNORE_MEMBER   = "unignore"
    static var TAG_FIELD_MUTUALFRIENDS  = "mutualFriends"
    static var TAG_FIELD_FRIENDSCOUNT  = "friendsCount"
    static var TAG_FIELD_UNFEATURED = "unfeatured"
    static var TAG_FIELD_MEMBER_ID = "memberId"
    static var TAG_FIELD_FRIEND_ID = "friendID"
    static var TAG_FIELD_FRIENDSHIP_STATUS = "friendship_status"
    static var TAG_FIELD_CONNECTION_ID = "connectionID"
    static var TAG_FIELD_CONNECTIONID_FRIEND = "connection_id"
    static var TAG_FIELD_EMAIL = "email"
    static var TAG_FIELD_GETFRIENDREQUESTLIST = "getFriendRequestList"
    
    //    static var TAG_EXTTASK_ADDFRIENDFEATURED = "AddFriendFeatured"
    //    static var TAG_EXTTASK_REMOVEFRIENDFEATURED = "RemoveFriendFeatured"
    //    static var TAG_EXTTASK_FRIENDBLOCK = "friendblock"
    static var TAG_EXTTASK_SENTFRIENDREQUEST = "getSentFriendRequestList"
    static var TAG_EXTTASK_INVITEFRIEND =  "inviteFriend"
    static var TAG_EXTTASK_GETFRIENDREQUESTLIST = "getFriendRequestList"
    
    
    static var TAG_FIELD_USER_ID = "user_id"
    
    
    
    
    //-- Message tags--//
    static var TAG_MESSAGE_WITH_FILE = "file"
    static var TAG_MESSAGE_WITH_IMAGE = "image"
    static var TAG_MESSAGE_PHOTO = "photo"
    static var TAG_MESSAGE_READ = "read"
    static var TAG_MESSAGE_UNREAD = "unRead"
    static var TAG_MESSAGE_ID = "msgID"
    static var TAG_UNIQUE_ID = "uniqueID"
    static var TAG_FIELD_FULL = "full"
    static var TAG_FIELD_THUMBIMAGE = "thumbImage"
    
    static var TAG_MESSAGEID = "id"
    static var TAG_EXTTASK_MARKMESSAGEASUNREAD = "markMessageAsUnread"
    static var TAG_EXTTASK_MARKMESSAGEASREAD = "markMessageAsRead"
    
    //--Advance Search tags--//
    static var TAG_FIELD_SEARCH_FORM = "form"
    static var TAG_EXTTASK_ADVANCESEARCH = "advanceSearch"
    static var TAG_EXTVIEW_USER_SEARCH = "user"
    static var TAG_FIELDS = "fields"
    static var TAG_FIELD_FORMDATA = "formData"
    static var TAG_FIELD_SEARCH_OPERATOR = "operator"
    static var TAG_FIELD_AVTARONLY = "avatarOnly"
    static var TAG_TYPE_GROUP       = "group"
    
    // PhotoAlbum Sorting Type
    static var SORT_CAPTION_DATE        = "Date"
    static var SORT_CAPTION_HITS        = "Hits"
    static var SORT_CAPTION_NAME        = "Name"
    static var SORT_CAPTION_FEATUREDONLY = "Featured Only"
    static var SORT_CAPTION_FEATURED    = "Featured"
    
    static var SORT_VALUE_DATE          = "date"
    static var SORT_VALUE_HIT           = "hit"
    static var SORT_VALUE_NAME          = "name"
    static var SORT_VALUE_FEATUREONLY   = "featured_only"
    static var SORT_VALUE_FEATURED      = "featured"
    static var TAG_FIELD_SORT           = "sort"
    
    // Video Sorting Type
    static var SORT_CAPTION_LATEST_VIDEO    = "Latest videos"
    static var SORT_CAPTION_MOST_DISCUSSED  = "Most discussed"
    static var SORT_CAPTION_MOST_POPULAR    = "Most popular"
    static var SORT_CAPTION_TITLE           = "Title"
    
    static var SORT_VALUE_LATEST_VIDEO      = "latest"
    static var SORT_VALUE_MOST_DISCUSSED    = "mostwalls"
    static var SORT_VALUE_MOST_POPULAR      = "mostviews"
    static var SORT_VALUE_TITLE             = "title"
    
    // push Notification
    
    static var TAG_GETNOTIFICATION = "getPushNotificationData"
    
}

struct WallActivity
{
    static var LIKETYPE                                     = "liketype"
    static var COMMENTTYPE                                  = "commenttype"
    
    //Activity Type of Profile
    static var TYPE_PROFILE                                 = "profile"
    static var TYPE_COVER_UPLOAD                            = "cover.upload"
    static var TYPE_PROFILE_AVATAR_UPLOAD                     = "profile.avatar.upload"
    
    
    //Activity Type Of Group
    static var TYPE_GROUP                                   = "group"
    static var TYPE_GROUPWALL                               = "groups.wall"
    static var TYPE_GROUP_DISCUSSION_REPLY                  = "groups.discussion.reply"
    static var TYPE_GROUP_JOIN                              = "groups.join"
    static var TYPE_GROUP_ANNOUNCEMENT                      = "announcement"
    static var TYPE_GROUP_DISCUSSION                        = "discussion"
    static var TYPE_GROUP_AVTAR_UPLOAD                      = "groups.avatar.upload"
    
    //ACtivity type of Event
    static var TYPE_EVENTWALL                               = "events.wall"
    static var TYPE_EVENT                                   = "event"
    static var TYPE_EVENT_ATTEND                            = "events.attend"
    static var TYPE_EVENT_UPDATE                            = "events.update"
    static var TYPE_EVENT_AVTAR_UPLOAD                      = "events.avatar.upload"
    
    // Activity type of Photo
    static var TYPE_PHOTO                                   = "photo"
    static var TYPE_PHOTOS                                  = "photos"
    static var TYPE_PHOTOS_LIKE                             = "photos.like"
    static var TYPE_PHOTOS_COMMENT                          = "photos.comment"
    static var TYPE_ALBUMS                                  = "albums"
    
    // Activity Type Of Video
    static var TYPE_VIDEO_LINKING                           = "videos.linking"
    static var TYPE_VIDEO_COMMENT                           = "videos.comment"
    static var TYPE_VIDEOS                                  = "videos"
    
    // Activity Type of Friend
    static var TYPE_FRIENDS                                 = "friends"
    
    //Activity Like Type
    static var TYPE_LIKE_PROFILE_STATUS                     = "profile.status"
    static var TYPE_LIKE_PHOTOS_WALL_CREATE                 = "photos.wall.create"
    static var TYPE_LIKE_ALBUMS                             = "albums"
    static var TYPE_LIKE_PROFILE_AVATAR_UPLOAD              = "profile.avatar.upload"
    
    //Activity Comment Type
    static var TYPE_COMMENT_PROFILE_STATUS                  = "profile.status"
    static var TYPE_COMMENT_PHOTOS_WALL_CREATE              = "photos.wall.create"
    static var TYPE_COMMENT_ALBUMS                          = "commenttype"
    static var TYPE_COMMENT_PROFILE_AVATAR_UPLOAD           = "profile.avatar.upload"
    static var TYPE_COMMENT_GROUP_CREATE                    = "groups.create"
    
    
    //Filter Type Caption
    
    static var FILTER_VALUE_PHOTOS                                  = "photo"
    static var FILTER_VALUE_GROUPS                                  = "group"
    static var FILTER_VALUE_MYFRIENDS                               = "me-and-friends"
    static var FILTER_VALUE_STAUS_UPDATE                            = "profile"
    static var FILTER_VALUE_VIDEOS                                  = "video"
    static var FILTER_VALUE_EVENTS                                  = "event"
    
    static var FILTER_APPS                                          = "apps"
    static var FILTER_PRIVACY                                       = "privacy"
    static var FILTER_KEYWORD                                       = "keyword"
    static var FILTER_HASHTAG                                       = "hashtag"
    static var FILTER_ALL                                           = "all"
    
    static var FILTER_CAPTION_ALLSTREAMS                            = "ALL Streams"
    static var FILTER_CAPTION_PHOTOS                                = "Photos"
    static var FILTER_CAPTION_GROUPS                                = "Groups"
    static var FILTER_CAPTION_MYFRIENDS                             = "My Friends & I"
    static var FILTER_CAPTION_STAUS_UPDATE                          = "Status Updates"
    static var FILTER_CAPTION_VIDEOS                                = "Videos"
    static var FILTER_CAPTION_EVENTS                                = "Events"
    static var FILTER_CAPTION_KEYWORD                               = "Filter by keyword"
    static var FILTER_CAPTION_HASHTAG                               = "Filter by hashtag"
    
    static var TAG_ELEMENT                                 = "element"
    static var TAG_TARGET                                  = "target"
    static var TAG_PROFILE                                 = "profile"
    static var TAG_GROUPS                                  = "groups"
    static var TAG_EVENTS                                  = "events"
    static var TAG_ATTACHMENT                              = "attachment"
    static var TAG_MOOD                                    = "mood"
    static var TAG_FETCH                                   = "fetch"
    static var TAG_CATEGORIES_ID                           = "categoryId"
    static var TAG_IS_VIDEO_UPLOAD                         = "is_video_upload"
    static var TAG_CATEGORY_ID                             = "category_id"
    static var TAG_TEXT                                    = "text"
    static var TAG_ALLDAY                                  = "allday"
    static var TAG_VIDEO_LINKURL                           = "videoLinkUrl"
    static var TAG_PARENT                                  = "parent"
}

struct groupList
{
    static var TAG_FIELD_ALL            = "all"
    static var TAG_FIELD_MY             = "my"
    static var TAG_FIELD_PENDING        = "pending"
    static var TAG_FIELD_TYPE           = "type"
    static var TAG_FIELD_PAGENO         = "pageNO"
    static var TAG_FIELD_CATID          = "categoryID"
    static var TAG_FIELD_CATEID         = "catID"
    static var TAG_FIELD_SORT           = "sort"
    static var TAG_FIELD_LATEST         = "latest"
    static var TAG_FIELD_ALPHABETICAL   = "alphabetical"
    static var TAG_FIELD_MOSTACTIVE     = "mostactive"
    static var TAG_FIELD_FEATURED       = "featured"
    static var TAG_FIELD_GROUP          =  "group"
    static var TAG_FIELD_JOMSOCIAL      =  "jomsocial"
    static var TAG_FIELD_GROUPs         =  "groups"
    static var TAG_FIELD_DETAIL         =  "detail"
    static var TAG_FIELD_UNIQUEID       =  "uniqueID"
    static var TAG_FIELD_AVATAR         = "avatar"
    static var TAG_FIELD_TITLE          = "title"
    static var TAG_FIELD_MEMBERS          = "members"
    static var TAG_FIELD_DISCUSSIONS          = "discussions"
    static var TAG_FIELD_WALLS          = "walls"
    static var TAG_FIELD_COVER          = "cover"
    static var TAG_FIELD_DATE          = "date"
    static var TAG_FIELD_DESCIPTION         = "description"
    static var TAG_FIELD_LIKES         = "likes"
    static var TAG_FIELD_DILIKES         = "dislikes"
    static var TAG_FIELD_WALL         = "wall"
    static var TAG_FIELD_WAITING                = "waiting"
    static var TAG_FIELD_ID                     = "id"
    static var TAG_FIELD_USERAVATAR             = "user_avatar"
    static var TAG_FIELD_USERNAME               = "user_name"
    static var TAG_FIELD_EVENTLIST              = "totalEvents"
    static var TAG_FIELD_WALLLIST               = "totalBulletin"
    static var TAG_FIELD_VIDEOLIST              = "totalVideos"
    static var TAG_FIELD_MEMBERLIST             = "membersCount"
    static var TAG_FIELD_ANNOUNCEMENTLIST       = "totalBulletin"
    static var TAG_TOTAL_BANED_MEMBERS          = "totalBannedMembers"
    static var TAG_FIELD_DISCUSSIONLIST       = "totalDiscussion"
    static var TAG_FIELD_ALBUMLIST       = "totalPhotos"
    static var TAG_FIELD_FIELDS         = "fields"
    static var TAG_FIELD_ANNOUNCEMENT       = "announcement"
    static var TAG_FIELD_ANNOUNCEMENTDETAIL       = "announcementDetail"
    static var TAG_FIELD_ADDGROUP           = "addGroup"
    static var TAG_FIELD_ADDANNOUNCEMENT    = "addAnnouncement"
    static var TAG_FIELD_FILE    = "file"
    static var TAG_FIELD_MESSAGE    = "message"
    static var TAG_FIELD_FILEPERMISSION    = "filePermission"
    static var TAG_FIELD_ANNOUNCEMENTID    = "announcementID"
    static var TAG_FIELD_ANNOUNCEID    = "announceId"
    static var TAG_FIELD_DELETEANNOUNCEMENT   = "deleteAnnouncement"
    static var TAG_FIELD_DISCUSSION     = "discussion"
    static var TAG_FIELD_TOPICS     = "topics"
    static var TAG_FIELD_DISCUSSIONDETAIL     = "discussionDetail"
    static var TAG_FIELD_ADDDISCUSSION     = "addDiscussion"
    static var TAG_FIELD_ADDDISCUSSIONREPLY     = "addDiscussionReply"
    static var TAG_FIELD_DISCUSSIONID     = "discussionID"
    static var TAG_FIELD_DELETEDISCUSSION     = "deleteDiscussion"
    static var TAG_FIELD_LOCKDISCUSSION     = "lockDiscussion"
    static var TAG_FIELD_ISLOCKED     = "isLocked"
    static var TAG_FIELD_CANADMIN     = "canAdmin"
    //    static var TAG_FIELD_SETADMIN     = "setAdmin"
    static var TAG_FIELD_ADMIN     = "admin"
    static var TAG_FIELD_USERID     = "user_id"
    static var TAG_FIELD_MEMBERID     = "memberID"
    static var TAG_FIELD_BAN     = "ban"
    static var TAG_FIELD_REMOVEMEMBER     = "removeMember"
    static var TAG_EXTTASK_ADDGROUP = "addGroup"
    static var TAG_FIELD_EDITAVATAR     = "editAvatar"
    static var TAG_FIELD_LIKED     = "liked"
    static var TAG_FIELD_LIKEALLOWED     = "likeAllowed"
    static var TAG_FIELD_FRIENDLIST    = "friendList"
    static var TAG_FIELD_NAME     = "name"
    static var TAG_FIELD_FRIENDS     = "friends"
    static var TAG_FIELD_FRIENDS_COUNT  = "friendsCount"
    static var TAG_FIELD_INVITE     = "invite"
    static var TAG_FIELD_ISINVITED     = "isinvited"
    static var TAG_FIELD_IMAGEURL     = "imageUrl"
    static var TAG_FIELD_ISADMIN     = "isAdmin"
    static var TAG_FIELD_JOIN     = "join"
    static var TAG_FIELD_LEAVE     = "leave"
    static var TAG_FIELD_ISJOIN     = "isJoin"
    static var TAG_FIELD_COUNT     = "count"
    static var TAG_FIELD_ADDLIKE     = "addlike"
    static var TAG_FIELD_UNLIKE     = "unlike"
    static var TAG_FIELD_HITS     = "hits"
    static var TAG_FIELD_COMMENT     = "comment"
    static var TAG_FIELD_WALLID     = "wallID"
    static var TAG_FIELD_DELETE     = "delete"
    static var TAG_FIELD_PHOTOID     = "photoID"
    static var TAG_FIELD_SETPHOTOCOVER     = "setPhotoCover"
    static var TAG_FIELD_BULLETIN     = "bulletin"
    static var TAG_FIELD_UPLOADFILE     = "uploadFile"
    static var TAG_FIELD_REMOVECOVER    = "removecover"
    static var TAG_FIELD_INVITATION     = "invitation"
    static var TAG_FIELD_IS_OWNER       = "is_owner"
    static var TAG_FIELD_GROUPID           = "groupid"
    static var TAG_FIELD_LIKECOUNT     = "likeCount"
    static var TAG_FIELD_ISPRIVATE      = "isPrivate"
    static var TAG_FIELD_ADMINMENU      = "adminMenu"
    static var TAG_FIELD_CREATEANNOUCEMENT = "createAnnouncement"
    static var TAG_FIELD_CAN_EDIT      = "canEdit"
    static var TAG_FIELD_CAN_DELETE      = "canEdit"
    static var TAG_FIELD_ISBANNED      = "isBanned"
}

