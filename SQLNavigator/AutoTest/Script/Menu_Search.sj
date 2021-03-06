//USEUNIT fCommFun
//USEUNIT vGlobalVariables
//USEUNIT fCheckErrors
//USEUNIT fConfirmations
//USEUNIT fCodeEditor

//-------------------------------------------------------------------------------------
//Function Name : traverseSearchMenu
//Author        : Alan.Yang
//Create Date   : June 1, 2015
//Last Modify   : 
//Description   : Traversing the "Search" menu
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function traverseSearchMenu(){
    var objMainMenuBar = Aliases.Sqlnavigator.frmMain.HeadZone.MainMenuBar;
    if(objMainMenuBar.Exists){ 
        var edtCodeEditor = getCurrentTab();
        if(edtCodeEditor == null){
            objMainMenuBar.Keys("^m");//ctrl + m
            edtCodeEditor = getCurrentTab();
        }
        if(edtCodeEditor != null){
            Log.Message("Create a new SQL script by shortcuts [Ctrl + m].");
            edtCodeEditor.Keys("^a[Del]");
            edtCodeEditor.Keys("~AF");//Search--->Find
            Log.Message("Select the MainMenu path: Search--->Find");
            setFindAndReplace("Find");
            edtCodeEditor.Keys("~AR");//Search--->Replace
            Log.Message("Select the MainMenu path: Search--->Replace");
            setFindAndReplace("Replace");
            edtCodeEditor.Keys("[F3]");//Search--->Find Next
            Log.Message("Select the MainMenu path: Search--->Find Next");
            var objDialog = Aliases.Sqlnavigator.dlgConfirmOkB;
            closeDialog(objDialog);
            edtCodeEditor.Keys("~AP");//Search--->Find Previous
            Log.Message("Select the MainMenu path: Search--->Find Previous");
            var objDialog = Aliases.Sqlnavigator.dlgConfirmOkB;
            closeDialog(objDialog);
        }
        else{
            Log.Error("Code Editor is not exists.",null,pmNormal,null,Sys.Desktop);
        }
        objMainMenuBar.Keys("~AS");//Search--->Code Search
        Log.Message("Select the MainMenu path: Search--->Code Search");
        setCodeSearch();
        objMainMenuBar.Keys("~AO");//Search--->Find Objects
        Log.Message("Select the MainMenu path: Search--->Find Objects");
        findObjects("%auto%");
        objMainMenuBar.Keys("~AB");//Search--->Find Recycle Bin Objects
        Log.Message("Select the MainMenu path: Search--->Find Recycle Bin Objects");
        findRecycleBinObjects("%");
    }
    else{
        Log.Error("Main menu bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    checkDialogError();
    checkOutputError();
}

//-------------------------------------------------------------------------------------
//Function Name : setFindAndReplace
//Author        : Alan.Yang
//Create Date   : June 2, 2015
//Last Modify   : 
//Description   : verified the Find and Replace window
//Parameter     : [IN]strTabType -- Find or Replace ?
//Return        : null
//-------------------------------------------------------------------------------------
function setFindAndReplace(strTabType){

    var frmFindAndReplace = Aliases.Sqlnavigator.frmFindAndReplace;
    if(frmFindAndReplace.Exists){
        Log.Message("Find and Replace window has displayed.");
        var pageTabs = frmFindAndReplace.PageTabs;
        var objDialog = Aliases.Sqlnavigator.dlgConfirmOkB;
        switch (strTabType)
        {
          case "Find":
            pageTabs.ClickTab(0);
            if(pageTabs.wTabCaption(0) == "Find"){
                Log.Message("Enter into Find tab.");
                var cmbFindText = pageTabs.FindTab.cmbFindText;
                var btnFind = pageTabs.FindTab.btnFind;
                cmbFindText.wText = "Find Test";
                btnFind.Click();
                closeDialog(objDialog);
            }
            else{
                Log.Error("Fail to enter into Find tab.",null,pmNormal,null,Sys.Desktop);
            }
            frmFindAndReplace.Close();
            break;
          case "Replace":
            pageTabs.ClickTab(1);
            if(pageTabs.wTabCaption(1) == "Replace"){
                Log.Message("Enter into Replace tab.");
                var cmbFindReplaceText = pageTabs.ReplaceTab.cmbFindReplaceText;
                var cmbReplaceText = pageTabs.ReplaceTab.cmbReplaceText;
                var btnFind = pageTabs.ReplaceTab.btnFind;
                var btnRepalce = pageTabs.ReplaceTab.btnReplace;
                cmbFindReplaceText.wText = "Find Test";
                cmbReplaceText.wText = "Replace Test";
                btnFind.Click();
                closeDialog(objDialog);
                btnRepalce.Click();
                closeDialog(objDialog);
            }
            else{
                Log.Error("Fail to enter into Replace tab.",null,pmNormal,null,Sys.Desktop);
            }
            frmFindAndReplace.Close();
            break;
        }
    }
    else{
        Log.Error("Find and Replace window is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setCodeSearch
//Author        : Alan.Yang
//Create Date   : June 2, 2015
//Last Modify   : 
//Description   : verified the Code Search
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setCodeSearch(){
    var frmCodeSearch = Aliases.Sqlnavigator.frmMain.MiddleZone.frmCodeSearch; 
    if(frmCodeSearch.Exists){
        Log.Message("Code Search frame has displayed.");
        var pageTabs = frmCodeSearch.PageTabs;
        pageTabs.ClickTab("What");
        if(pageTabs.wFocusedTab == 0){
            Log.Message("Enter into What tab.")
            var cmbFindText = pageTabs.tabWhat.cmbFindText;
            cmbFindText.wText = "test";
            Log.Message("Search text keyword is: " + cmbFindText.wText);
        }
        else{
            Log.Error("Fail to enter into What tab.",null,pmNormal,null,Sys.Desktop);
        }
        //where tab
        pageTabs.ClickTab("Where");
        if(pageTabs.wFocusedTab == 1){
            Log.Message("Enter into Where tab.")
            var edtSchema = pageTabs.tabWhere.edtSchema;
            var edtObject = pageTabs.tabWhere.edtObjectName;
            if(edtSchema.Enabled){
                edtSchema.wText = "navdev";
                Log.Message("Search schema name like: " + edtSchema.wText);
            }
            edtObject.wText = "%auto%";
            Log.Message("Search object name like: " + edtObject.wText);
        }
        else{
            Log.Error("Fail to enter into Where tab.",null,pmNormal,null,Sys.Desktop);
        }
        //search button
        var btnSearch = frmCodeSearch.btnSearch;
        if(btnSearch.Exists && btnSearch.Enabled){
            btnSearch.Click();
            Log.Message("Click on [Search] button.");
            if(bRefreshObjCaption(btnSearch,"Search","Stop")){//waiting for search
                //result
                var listResult = frmCodeSearch.listResults;
                if(listResult.Exists && listResult.wItemCount>0){
                    Log.Message("Search finished, found "+ listResult.wItemCount +" records.");
                }
                else{
                    Log.Error("Search failed, found nothing.",null,pmNormal,null,Sys.Desktop);
                }
            }
        }
        else{
            Log.Error("[Search] button is disable.",null,pmNormal,null,Sys.Desktop);
        }
        frmCodeSearch.Close();
    }
    else{
        Log.Error("Code Search frame is not exists.",null,pmNormal,null,Sys.Desktop);
    } 
}

//-------------------------------------------------------------------------------------
//Function Name : findObjects
//Author        : Alan.Yang
//Create Date   : June 2, 2015
//Last Modify   : 
//Description   : find specified objects
//Parameter     : [IN]strObjName -- the given object name keyword
//Return        : null
//-------------------------------------------------------------------------------------
function findObjects(strObjName){
    var frmFindObjects = Aliases.Sqlnavigator.frmMain.MiddleZone.frmFindObject;
    if(frmFindObjects.Exists){
        Log.Message("Find Objects frame has displayed.");
        var cmbObjectName = frmFindObjects.cmbObjectName;
        var btnSearch = frmFindObjects.btnSearch;
        cmbObjectName.wText = strObjName;
        if(btnSearch.Exists && btnSearch.Enabled){
            btnSearch.Click();
            Log.Message("Click on [Search] button.");
            if(bRefreshObjCaption(btnSearch,"Search","Stop")){//waiting for search
                var treeResults = frmFindObjects.vstResults;
                if(treeResults.Exists && treeResults.RootNodeCount>0){
                    Log.Message("Search finished, found "+ treeResults.RootNodeCount +" records.");
                }
                else{
                    Log.Error("Search failed, found nothing.",null,pmNormal,null,Sys.Desktop);
                }
            }
        }
        else{
            Log.Error("[Search] button is disable.",null,pmNormal,null,Sys.Desktop);
        }
        frmFindObjects.Close();
    }
    else{
        Log.Error("Find Objects frame is not exists.",null,pmNormal,null,Sys.Desktop);
    } 
}

//-------------------------------------------------------------------------------------
//Function Name : findRecycleBinObjects
//Author        : Alan.Yang
//Create Date   : June 2, 2015
//Last Modify   : 
//Description   : find Recycle Bin objects
//Parameter     : [IN]strObjName -- the given object name keyword
//Return        : null
//-------------------------------------------------------------------------------------
function findRecycleBinObjects(strObjName){
    var frmFindRecycleBinObj = Aliases.Sqlnavigator.frmMain.MiddleZone.frmFindRecycleBinObj;
    if(frmFindRecycleBinObj.Exists){
        Log.Message("Find Recycle Bin Objects frame has displayed.");
        var cmbName = frmFindRecycleBinObj.cmbName;
        cmbName.wText = strObjName;
        var btnSearch = frmFindRecycleBinObj.btnSearch;
        if(btnSearch.Exists && btnSearch.Enabled){
            btnSearch.Click();
            Log.Message("Click on [Search] button.");
            if(bRefreshObjCaption(btnSearch,"Search","Stop")){//waiting for search button refresh caption
                var treeResults = frmFindRecycleBinObj.vstResults;
                if(treeResults.Exists){
                    Log.Message("Search finished, found "+ treeResults.RootNodeCount +" records.");
                }
                else{
                    Log.Error("Search failed, Search result table is not show.",null,pmNormal,null,Sys.Desktop);
                }
            }
        }
        else{
            Log.Error("[Search] button is disable.",null,pmNormal,null,Sys.Desktop);
        }
        frmFindRecycleBinObj.Close();
    }
    else{
        Log.Error("Find Recycle Bin Objects frame is not exists.",null,pmNormal,null,Sys.Desktop);
    }   
}