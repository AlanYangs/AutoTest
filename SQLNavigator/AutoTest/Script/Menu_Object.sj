//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT Menu_View

var arrStoredObjs = new Array("Procedure","Function","Package","Package Body","Object Type","Type Body");
//-------------------------------------------------------------------------------------
//Function Name : traverseObjectMenu
//Author        : Alan.Yang
//Create Date   : June 17, 2015
//Last Modify   : 
//Description   : Traversing the "Object" menu
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function traverseObjectMenu(){
    var objMainMenuBar = Aliases.Sqlnavigator.frmMain.HeadZone.MainMenuBar;
    if(objMainMenuBar.Exists){
        createDBObject();
        openDBObject();
        
        objMainMenuBar.Keys("~OO");//Object--->Import Tables
        Log.Message("Select the MainMenu path: Object--->Import Tables");
        setImportTable();
        
        objMainMenuBar.Keys("~OR");//Object--->Export Tables
        Log.Message("Select the MainMenu path: Object--->Export Tables");
        setExportTable();
    }
    else{
        Log.Error("Main menu bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    checkDialogError();
    checkOutputError();
}

//-------------------------------------------------------------------------------------
//Function Name : CreateDBObject
//Author        : Alan.Yang
//Create Date   : June 17, 2015
//Last Modify   : 
//Description   : Create all types of DB Objects
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function createDBObject(){
    var objMain = Aliases.Sqlnavigator.frmMain;
    objMain.Keys("~OC");//Object--->Create DB Object
    Log.Message("Select the MainMenu path: Object--->Create DB Object");
    
    var frmNewDBObject = Aliases.Sqlnavigator.frmNewDBObject;
    if(frmNewDBObject.Exists){
        var objPages = frmNewDBObject.PageControl;
        var btnOK = frmNewDBObject.btnOK;
        objPages.ClickTab("Schema Objects");
        var objLists =  objPages.tsSchemaObjects.listObjects;
        if(objLists.Exists){
            var count = objLists.wItemCount;
            for(i=0; i<count; i++){
                objLists.ClickItem(objLists.wItem(i,0));
                Log.Message("This action will create ["+objLists.wItem(i,0)+"] object.");
                var itemName = trim(objLists.wItem(i,0));
                btnOK.Click();
                for (var item in arrStoredObjs){
                    if(itemName == arrStoredObjs[item]) itemName = "Stored Object";
                }
                setCreate(itemName);
                if(i < count-1) objMain.Keys("~OC");//last one needn't it
            }
        }
    }
    else{
        Log.Error("New DB Object dialog is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : openDBObject
//Author        : Alan.Yang
//Create Date   : June 18, 2015
//Last Modify   : 
//Description   : Open all types of DB Objects
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function openDBObject(){
    var objMain = Aliases.Sqlnavigator.frmMain;
    objMain.Keys("~O"+getNumString("[Down]",1)+"[Enter]");//Object--->Open DB Object
    Log.Message("Select the MainMenu path: Object--->Open DB Object");
    var frmOpenDBObject = Aliases.Sqlnavigator.frmOpenDBObject;
    if(frmOpenDBObject.Exists && frmOpenDBObject.Visible){
        var cmbTypes = frmOpenDBObject.cmbObjectType;
        var listObjects = frmOpenDBObject.lvObjects;
        var btnOpen = frmOpenDBObject.btnOpen;
        var count = cmbTypes.wItemCount;
        var cmbSchema = frmOpenDBObject.cmbSchema;
        if(bObjExists(cmbSchema,2)){
            if(cmbSchema.Visible && cmbSchema.wText != "NAVDEV") frmOpenDBObject.cmbSchema.ClickItem("NAVDEV");
        }
        else{
            Log.Error("Schema selection combobox is not exists.",null,pmNormal,null,Sys.Desktop);
            return;
        }
        Delay(500);
        var i = 0;
        while(i<count){
            cmbTypes.ClickItem(cmbTypes.wItem(i));
            var counter = 0;
            while(!btnOpen.Enabled){
                btnOpen.RefreshMappingInfo();
                Delay(1000);
                if(counter > 20) break;
                counter++;
            }
            if(listObjects.wItemCount > 0){//list exist records
                listObjects.ClickItem(0,0);
                var strObjectType = trim(cmbTypes.wItem(i));
                var strObjectName = listObjects.wItem(0,0);
                Log.Message("This action will open "+strObjectType+" "+strObjectName);
                if(btnOpen.Enabled){
                    btnOpen.Click();
                    for (var item in arrStoredObjs){
                        if(strObjectType == arrStoredObjs[item]) strObjectType = "Stored Object";
                    }
                    if(!btnOpen.Exists) setOpen(strObjectType);
                }
            }
            else{
                if(frmOpenDBObject.Exists) frmOpenDBObject.Close();
            }
            if(i<count-1) objMain.Keys("~O"+getNumString("[Down]",1)+"[Enter]");
            i++;
        }
        closeMiddleZoneFrames();//close the not open frames
    }
    else{
        Log.Error("Select DB Object dialog is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//Import Table
function setImportTable(){
    var dlgError = Aliases.Sqlnavigator.dlgError_NotFind;
    if(dlgError.Exists){
        Log.Message("A Can Not Find error has displayed.");
        dlgError.Close();
    }
    else{
        var frmImportData = Aliases.Sqlnavigator.frmMain.MiddleZone.frmImportData;
        existAndCloseWin("Import Table",frmImportData);
    }
}