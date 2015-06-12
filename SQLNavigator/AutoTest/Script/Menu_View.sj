//USEUNIT fCommFun
//USEUNIT vGlobalVariables
//USEUNIT fCheckErrors
//USEUNIT fConfirmations
//USEUNIT fCodeEditor

//-------------------------------------------------------------------------------------
//Function Name : traverseSearchMenu
//Author        : Alan.Yang
//Create Date   : June 4, 2015
//Last Modify   : 
//Description   : Traversing the "View" menu
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function traverseViewMenu(){
    var objMainMenuBar = Aliases.Sqlnavigator.frmMain.HeadZone.MainMenuBar;
    if(objMainMenuBar.Exists){
        execShortcuts(objMainMenuBar,"~VB");//View--->DB Navigator
        Log.Message("Select the MainMenu path: View--->DB Navigator");
        checkDBNavigator();
        
        closeCodeEditor();//close all CE tab
        objMainMenuBar.Keys("~V[Down][Enter]");//View--->Code Editor
        Log.Message("Select the MainMenu path: View--->Code Editor");
        var edtCodeEditor = getCurrentTab();
        if(edtCodeEditor.Exists){
            Log.Message("A new Code Editor tab has displayed. ")
        }
        else{
            Log.Error("Fail to show a new Code Editor tab.",null,pmNormal,null,Sys.Desktop);
        }
        
        
        
    }
    else{
        Log.Error("Main menu bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    checkDialogError();
    checkOutputError();
}

//-------------------------------------------------------------------------------------
//Function Name : checkDBNavigator
//Author        : Alan.Yang
//Create Date   : June 4, 2015
//Last Modify   : 
//Description   : Traversing DB Navigator
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkDBNavigator(){
    var frmDBNavigator = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBNavigator;
    if(frmDBNavigator.Exists){
        Log.Message("DB Navigator Frame has displayed.");
        var objDBNavTree = frmDBNavigator.pnlLeft.DBTree;
        if(objDBNavTree.Exists){
            Log.Message("DB Navigator Tree has displayed.");
            checkNodePopupMenu(objDBNavTree,"Root");//Root Node
            for(i=0; i<objDBNavTree.wItemCount; i++){
                Log.Message(objDBNavTree.wItem(i));
                checkNodePopupMenu(objDBNavTree,objDBNavTree.wItem(i));
            }
        }
        else{
            Log.Error("DB Navigator Tree is not exists.",null,pmNormal,null,Sys.Desktop);
        }
        frmDBNavigator.Close();
    }
    else{
        Log.Error("DB Navigator frame is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkNodePopupMenu
//Author        : Alan.Yang
//Create Date   : June 5, 2015
//Last Modify   : 
//Description   : checking the selected node's popup menu
//Parameter     : [IN]objTree -- the object Tree
//Parameter     : [IN]strType -- object type name
//Return        : null
//-------------------------------------------------------------------------------------
function checkNodePopupMenu(){//objTree,strType
    var objTree = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBNavigator.pnlLeft.DBTree;
    var strType = "My Schema";
    switch (strType)
    {
      case "Root" :
        PopupMenu_Root(objTree);
        break; 
      case "Session Privileges" :
        PopupMenu_Session(objTree);
        break;
      case "Enabled Roles" :
        PopupMenu_EnabledRoles(objTree);
        break;
      case "Resource Limits" :
        PopupMenu_Resource(objTree);
        break;
      case "Tablespace Quotas" :
        PopupMenu_TabQuotas(objTree);
        break;
      case "Free Space" :
        PopupMenu_FreeSpace(objTree);
        break;
      case "My Schema" :
        gotoGivenNode(objTree,5,true);//select the node
        objTree.Refresh();
        Log.Message(objTree.wItemCount);
        for(i=0; i<objTree.wItemCount; i++){
            Log.Message(objTree.wItem(i));
            var strName = objTree.wItem(i); 
            PopupMenu_MySchema(objTree,strName);
        }
        break;
      case "All Schemas" :
        
        break;
      case "Users" :
    
        break;
      case "Roles" :
    
        break;
      case "Profiles" :
      
        break;
      case "Tablespaces" :
    
        break;
      case "Datafiles" :
      
        break;
      case "Rollback Segments" :
      
        break;
      case "Redo Log Groups" :
      
        break;
      case "Current Instance" :
      
        break;
      case "Recycle Bin" :
      
        break;
      default:
        break;
    }
}

//-------------------------------------------------------------------------------------
//Function Name : PopupMenu_Root
//Author        : Alan.Yang
//Create Date   : June 9, 2015
//Last Modify   : 
//Description   : the Root node's popup menu
//Parameter     : [IN]objTree -- the object Tree
//Return        : null
//-------------------------------------------------------------------------------------
function PopupMenu_Root(objTree){
    var objRootNode = objTree.wItems.Item(0);
    RightClickOpenObj(objTree,objRootNode,2,"setDescribe();");
    RightClickOpenObj(objTree,objRootNode,3,"setCodeRoadMap();");
    RightClickOpenObj(objTree,objRootNode,4,"setERDiagram();");
    RightClickOpenObj(objTree,objRootNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objRootNode);
    setShowOrHideDetails(objTree,objRootNode);  
}

//-------------------------------------------------------------------------------------
//Function Name : PopupMenu_Session
//Author        : Alan.Yang
//Create Date   : June 9, 2015
//Last Modify   : 
//Description   : the Session Privileges node's popup menu
//Parameter     : [IN]objTree -- the object Tree
//Return        : null
//-------------------------------------------------------------------------------------
function PopupMenu_Session(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"1-1");//Session Privileges--->first node
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    collapseGivenNode(objTree,1);
}

//-------------------------------------------------------------------------------------
//Function Name : PopupMenu_EnabledRoles
//Author        : Alan.Yang
//Create Date   : June 10, 2015
//Last Modify   : 
//Description   : the Session Privileges node's popup menu
//Parameter     : [IN]objTree -- the object Tree
//Return        : null
//-------------------------------------------------------------------------------------
function PopupMenu_EnabledRoles(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"2-1");//Enabled Roles--->first node
    RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Role\");");
    RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"Role\");");
    RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
    RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");
    RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
    RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant role
    RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke role
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseGivenNode(objTree,2);
}

//-------------------------------------------------------------------------------------
//Function Name : PopupMenu_Resource
//Author        : Alan.Yang
//Create Date   : June 10, 2015
//Last Modify   : 
//Description   : the Resource Limits node's popup menu
//Parameter     : [IN]objTree -- the object Tree
//Return        : null
//-------------------------------------------------------------------------------------
function PopupMenu_Resource(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"3-1");//Resource Limits--->first node
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseGivenNode(objTree,3);
}

//-------------------------------------------------------------------------------------
//Function Name : PopupMenu_TabQuotas
//Author        : Alan.Yang
//Create Date   : June 10, 2015
//Last Modify   : 
//Description   : the Tablespace Quotas node's popup menu
//Parameter     : [IN]objTree -- the object Tree
//Return        : null
//-------------------------------------------------------------------------------------
function PopupMenu_TabQuotas(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"4-1");//Tablespace Quotas--->first node
    RightClickOpenObj(objTree,objCurrentNode,2,"setDescribe();");
    RightClickOpenObj(objTree,objCurrentNode,3,"setCodeRoadMap();");
    RightClickOpenObj(objTree,objCurrentNode,4,"setERDiagram();");
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode); 
    collapseGivenNode(objTree,4);
}

//-------------------------------------------------------------------------------------
//Function Name : PopupMenu_FreeSpace
//Author        : Alan.Yang
//Create Date   : June 10, 2015
//Last Modify   : 
//Description   : the Free Space node's popup menu
//Parameter     : [IN]objTree -- the object Tree
//Return        : null
//-------------------------------------------------------------------------------------
function PopupMenu_FreeSpace(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"5-1");//Free Space--->first node
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseGivenNode(objTree,5);
}

//-------------------------------------------------------------------------------------
//Function Name : PopupMenu_MySchema
//Author        : Alan.Yang
//Create Date   : June 10, 2015
//Last Modify   : 
//Description   : the My Schema node's popup menu
//Parameter     : [IN]objTree -- the object Tree
//Return        : null
//-------------------------------------------------------------------------------------
function PopupMenu_MySchema(strType){
//    var objTree = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBNavigator.pnlLeft.DBTree;
//    var strType = "Tables";
    var objCurrentNode;
    switch (trim(strType))
    {
      case "Tables" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-1-1");//My Schame--->Tables--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Table\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Table\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"r[Enter]","setRename();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,6,"setExtractDDL();");//get metadata
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setExportTable();");      
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,"h","setDrop();");//drop with purge
        RightClickOpenObj(objTree,objCurrentNode,11,"setSqlModeler();");
        RightClickOpenObj(objTree,objCurrentNode,"q","setQuickBrowse();");//Quick Browse
        RightClickOpenObj(objTree,objCurrentNode,"e","setQuickBrowse();");//Edit Data
        RightClickOpenObj(objTree,objCurrentNode,"z","setAnalyze();");
        RightClickOpenObj(objTree,objCurrentNode,15,"setERDiagram();");
        RightClickOpenObj(objTree,objCurrentNode,"u","setTruncate(\"Table\");");
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"y","setRekey();");
        RightClickOpenObj(objTree,objCurrentNode,"ooo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Constraints" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-2-1");//My Schame--->Constraints--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Constraint\");");
        RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"Constraint\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop(\"Constraint\");");//drop
        RightClickOpenObj(objTree,objCurrentNode,"a","clickConfirmations(false);");//disable
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Views" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-3-1");//My Schame--->Views--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"View\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"View\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"r[Enter]","setRename();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,6,"setExtractDDL();");//get metadata
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,9,"setSqlModeler();");
        RightClickOpenObj(objTree,objCurrentNode,"q","setQuickBrowse();");//Quick Browse
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,16,"setCodeAnalysis();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Indexes" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-4-1");//My Schame--->Indexes--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Index\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Index\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,5,"setExtractDDL();");//get metadata
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop(\"Index\");");//drop
        RightClickOpenObj(objTree,objCurrentNode,"z","setAnalyze();");
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Triggers" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-5-1");//My Schame--->Triggers--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Trigger\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Trigger\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,4,"setExtractDDL();");//get metadata
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,7,"setCodeRoadMap();");
        RightClickOpenObj(objTree,objCurrentNode,"a","clickConfirmations(false);");//disable
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,12,"setCodeAnalysis();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Procedures","Functions","Packages" :
        if(strType == "Procedures"){
            objCurrentNode = gotoAndExpandTree(objTree,"6-6-1");//My Schame--->Procedures--->first node
        }
        else if(strType == "Functions"){
            objCurrentNode = gotoAndExpandTree(objTree,"6-7-1");//My Schame--->Functions--->first node
        }
        else if(strType == "Packages"){
            objCurrentNode = gotoAndExpandTree(objTree,"6-8-1");//My Schame--->Packages--->first node
        }
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,5,"setExtractDDL();");//get metadata  
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,8,"setCodeRoadMap();");
        RightClickOpenObj(objTree,objCurrentNode,"x[Enter]","setExecute();");
        RightClickOpenObj(objTree,objCurrentNode,"tt[Enter]","setCodeTest();");
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        if(getDBVersion() > 11){
            RightClickOpenObj(objTree,objCurrentNode,13,"setCodeRoleGrant();");
            RightClickOpenObj(objTree,objCurrentNode,17,"setCodeAnalysis();");
        }
        else{
            RightClickOpenObj(objTree,objCurrentNode,16,"setCodeAnalysis();");
        }
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"ooo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Package Bodies" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-9-1");//My Schame--->Package Bodies--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,4,"setExtractDDL();");//get metadata  
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,7,"setCodeRoadMap();");
        RightClickOpenObj(objTree,objCurrentNode,"x[Enter]","setExecute();");
        RightClickOpenObj(objTree,objCurrentNode,"tt[Enter]","setCodeTest();");
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,13,"setCodeAnalysis();");
        RightClickOpenObj(objTree,objCurrentNode,"ooo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Clusters" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-10-1");//My Schame--->Clusters--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Cluster\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Cluster\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,"z","setAnalyze();");
        RightClickOpenObj(objTree,objCurrentNode,"u","setTruncate();");//Truncate
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Materialized Views" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-11-1");//My Schame--->Materialized Views--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Materialized View\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Materialized View\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,5,"setSqlModeler();");
        RightClickOpenObj(objTree,objCurrentNode,"q","setQuickBrowse();");//Quick Browse
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Synonyms" :
    
        break;
      case "Database Links" :
    
        break;
      case "Object Types" :
    
        break;
      case "Object Type Bodies" :
    
        break;
      default:
        break;
    }
}



//Describe
function setDescribe(){
    var frmDescribe = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDescribe;
    existAndCloseWin("Describe",frmDescribe);
}
//Code Road Map
function setCodeRoadMap(){
    var frmCodeRoadMap = Aliases.Sqlnavigator.frmMain.MiddleZone.frmCodeRoadMap;
    existAndCloseWin("Code Road Map",frmCodeRoadMap);
}
//ER Diagram
function setERDiagram(){
    var frmERDiagram = Aliases.Sqlnavigator.frmMain.MiddleZone.frmERDiagram;
    var dlgCreatERDiagram = Aliases.Sqlnavigator.dlgERDiagram;
    if(dlgCreatERDiagram.Exists){
        dlgCreatERDiagram.Close();
    }
    existAndCloseWin("ER Diagram",frmERDiagram);
}
//Find Objects
function setFindObejcts(){
    var frmFindObejcts =Aliases.Sqlnavigator.frmMain.MiddleZone.frmFindObject;
    existAndCloseWin("Find Objects",frmFindObejcts);
}
//Find Recycle Bin Objects
function setFindRecycleBinObj(){
    var frmFindRecycleBinObj = Aliases.Sqlnavigator.frmMain.MiddleZone.frmFindRecycleBinObj;
    existAndCloseWin("Find Recycle Bin Objects",frmFindRecycleBinObj);
}
//Show/Hide Detials Panel
function setShowOrHideDetails(objTree,objNode){
    var objDetailPanel = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBNavigator.pnlDetail;
    objNode.ClickR();
    objTree.Keys("s");//Hide Detials Panel
    if(objDetailPanel.Exists & objDetailPanel.Visible){
        Log.Error("Fail to use popup menu to Hide Details Panel.",null,pmNormal,null,Sys.Desktop);
    }
    else{
        Log.Message("Success to use popup menu to Hide Details Panel.");
        objNode.ClickR();
        objTree.Keys("s");//Show Detials Panel
        if(objDetailPanel.Exists & objDetailPanel.Visible){
            Log.Message("Success to use popup menu to Show Details Panel.");
        }
        else{
            Log.Error("Fail to use popup menu to Show Details Panel.",null,pmNormal,null,Sys.Desktop);
        }
    }
}
//Copy Text
function setCopyText(objTree,objNode){
    Sys.Clipboard = "";
    objNode.ClickR();
    objTree.Keys("x");//Copy Text
    if(objNode.Text.indexOf(Sys.Clipboard) != -1){
        Log.Message("Success to copy the text from node: " + objNode.Text)
    }
    else{
        Log.Error("Fail to copy the text from node: " + objNode.Text,null,pmNormal,null,Sys.Desktop);
    }
}
//Create
function setCreate(strType){
    switch (strType)
    {
      case "Role":
        var dlgNewRole = Aliases.Sqlnavigator.frmNewRole;
        existAndCloseWin("New Role",dlgNewRole);
        if(!dlgNewRole.Exists){
            var frmRoleEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmRoleEditor;
            existAndCloseWin("Role Editor",frmRoleEditor);
        }
        break;
      case "Table":
        var dlgNewTable =  Aliases.Sqlnavigator.frmNewTable;
        existAndCloseWin("New Table",dlgNewTable);
        if(!dlgNewTable.Exists){
            var frmTableEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmTableEditor;
            existAndCloseWin("Table Editor",frmTableEditor);
        }
        break;
      case "Constraint":
        var dlgNewConstraint =  Aliases.Sqlnavigator.frmNewConstraint;
        existAndCloseWin("New Constraint",dlgNewConstraint);
        if(!dlgNewConstraint.Exists){
            var frmConstraintEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmConstraintEditor;
            existAndCloseWin("Constraint Editor",frmConstraintEditor);
        }
        break;
      case "View":
        var dlgNewView =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New View",dlgNewView);
        if(!dlgNewView.Exists){
            var frmViewEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmViewEditor;
            existAndCloseWin("View Editor",frmViewEditor);
        }
        break;
      case "Index":
        var dlgNewIndex =  Aliases.Sqlnavigator.frmNewIndex;
        existAndCloseWin("New Index",dlgNewIndex);
        if(!dlgNewView.Exists){
            var frmIndexEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmIndexEditor;
            existAndCloseWin("Index Editor",frmIndexEditor);
        }
        break;
      case "Trigger":
        var dlgNewTrigger =  Aliases.Sqlnavigator.frmNewTrigger;
        existAndCloseWin("New Trigger",dlgNewTrigger);
        if(!dlgNewTrigger.Exists){
            var frmCodeEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor;
            existAndCloseWin("Code Editor",frmCodeEditor);
        }
        break;
      case "Stored Object"://procedure,function,package,package body
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Stored Object",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmCodeEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor;
            existAndCloseWin("Code Editor",frmCodeEditor);
        }
        break;
      case "Materialized View":
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Materialized View",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmMaterialViewsEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmMaterialViewsEditor;
            existAndCloseWin("Materialized View Editor",frmMaterialViewsEditor);
        }
        break;
        
      default:
        break;
    }
    
}
//Open
function setOpen(strType){
    switch (strType)
    {
      case "Role":
        var frmRoleEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmRoleEditor;
        existAndCloseWin("Role Editor",frmRoleEditor);
        break;
      case "Table":
        var frmTableEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmTableEditor;
        existAndCloseWin("Table Editor",frmTableEditor);
        break;
      case "Constraint":
        var frmConstraintEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmConstraintEditor;
        existAndCloseWin("Constraint Editor",frmConstraintEditor);
        break;
      case "View":
        var frmViewEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmViewEditor;
        existAndCloseWin("View Editor",frmViewEditor);
        break;
      case "Index":
        var frmIndexEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmIndexEditor;
        existAndCloseWin("Index Editor",frmIndexEditor);
        break;
      case "Trigger","Stored Object":
        var frmCodeEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor;
        existAndCloseWin("Code Editor",frmCodeEditor);
        break;
      case "Cluster":
        var frmClusterEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmClusterEditor;
        existAndCloseWin("Cluster Editor",frmClusterEditor);
        break;
      case "Materialized View":
        var frmMaterialViewsEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmMaterialViewsEditor;
        existAndCloseWin("Materialized View Editor",frmMaterialViewsEditor);
        break;
      default:
        break;
    }
}
//Drop
function setDrop(strType){
    strType = arguments[0] == undefined ? "":strType;
    switch (strType)
    {
      case "Constraint","Index":
        if(getDBVersion() > 11){
            var dlgConfirmDrop = Aliases.Sqlnavigator.dlgConfirmDrop;
            existAndCloseWin("Confirm Drop ",dlgConfirmDrop);
        }
        else{
            clickConfirmations(false);
        }
        break;
      default:
        clickConfirmations(false);
        break;
    }
}
//Extract DDL / Get Metadata
function setExtractDDL(){
    var frmPreference = Aliases.Sqlnavigator.frmPreferences;
    existAndCloseWin("Preferences",frmPreference);
}
//View Differences
function setViewDifference(){
    var frmViewDifference = Aliases.Sqlnavigator.frmViewDifference;
    existAndCloseWin("View Differences",frmViewDifference);
}
//Grant / Revoke
function setGrantOrRevoke(){
    var frmGrantOrRevokeRole = Aliases.Sqlnavigator.frmGrantOrRevokeRole;
    var frmGrantObject = Aliases.Sqlnavigator.frmGrantObject;
    var frmRevokeObject = Aliases.Sqlnavigator.frmRevokeObject;
    if(frmGrantOrRevokeRole.Exists){
        existAndCloseWin("Grant/Revoke Role",frmGrantOrRevokeRole);
    }
    else if(frmGrantObject.Exists){
        existAndCloseWin("Grant Object",frmGrantObject);
    }
    else if(frmRevokeObject.Exists){
        existAndCloseWin("Revoke Object",frmRevokeObject);
    }
}
//Rename
function setRename(){
    var dlgRenameObj = Aliases.Sqlnavigator.dlgRenameObj;
    existAndCloseWin("Rename Object",dlgRenameObj);
}
//Export Table
function setExportTable(){
    var frmExportData = Aliases.Sqlnavigator.frmMain.MiddleZone.frmExportData;
    existAndCloseWin("Export Table",frmExportData);
}
//SQL Modeler
function setSqlModeler(){
    var frmSqlModeler = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSqlModeler;
    if(bObjExists(frmSqlModeler,2)){
        Log.Message("SQL Modeler has displayed.");
        frmSqlModeler.Close();
        clickConfirmations(false);
    }
    else{
        Log.Error("SQL Modeler frame is not show.",null,pmNormal,null,Sys.Desktop);
    }
}
//Quick Browse / Edit Data
function setQuickBrowse(){
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor.Exists){
        var objDataGrid = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlEditor.frmBrowseData.DataGrid;
        Log.Message("Code Editor has displayed.");
        if(objDataGrid.Exists){
            Log.Message("Data Grid is exists.");
        }
        else{
            Log.Error("Data Grid is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    closeCodeEditor();
}
//Analyze
function setAnalyze(){
    var frmAnalyze = Aliases.Sqlnavigator.frmMain.MiddleZone.frmAnalyze;
    existAndCloseWin("Analyze",frmAnalyze);
}
//Truncate
function setTruncate(strType){
    strType = arguments[0] == undefined ? "":strType;
    switch (strType)
    {
      case "Table":
        if(getDBVersion() > 11){
            var dlgTruncateTable = Aliases.Sqlnavigator.frmTruncateTable;
            existAndCloseWin("Truncate Table",dlgTruncateTable);
        }
        else{
            clickConfirmations(false);
        }
        break;
      default:
        clickConfirmations(false);
        break;
    }
}
//Property
function setProperty(){
    var dlgProperty = Aliases.Sqlnavigator.frmObjProperty;
    existAndCloseWin("Object Properties",dlgProperty);
}
//Rekey
function setRekey(){
    var dlgRekey = Aliases.Sqlnavigator.frmRekey;
    existAndCloseWin("Rekey Table",dlgRekey);
}
//Send to Code Analyzsis
function setCodeAnalysis(){
    var frmCodeAnalysis = Aliases.Sqlnavigator.frmMain.MiddleZone.frmCodeAnalysis;
    existAndCloseWin("Code Analyzsis",frmCodeAnalysis);
}
//Execute
function setExecute(){
    var frmCodeEditor = getCodeEditorFrames()[0];
    var btnExecute = frmCodeEditor.pnlEditor.frmRun.btnRun;
    if(btnExecute.Exists){
        Log.Message("Execute button has displayed.");
        btnExecute.click();
    }
    else{
        Log.Error("Execute button is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    closeCodeEditor();
}
//Code Test
function setCodeTest(){
    
}
//Code Role Grant
function setCodeRoleGrant(){
    var frmCodeRoleGrant = Aliases.Sqlnavigator.frmCodeRoleGrant;
    existAndCloseWin("Code Role Grant",frmCodeRoleGrant);
}


//-------------------------------------------------------------------------------------
//Function Name : RightClickOpenObj
//Author        : Alan.Yang
//Create Date   : June 5, 2015
//Last Modify   : 
//Description   : Right Click Open popup menu's item object
//Parameter     : [IN]objTree -- the object Tree
//Parameter     : [IN]objNode -- the object Tree's Node
//Parameter     : [IN]keys -- the number of menu's item or shortcuts
//Parameter     : [IN]func -- need to run this function
//Return        : null
//-------------------------------------------------------------------------------------
function RightClickOpenObj(objTree,objNode,keys,func){
    objNode.ClickR();
    if( /^\+?[1-9][0-9]*$/.test(keys)){//whether keys is number or shortcuts , /^\+?[1-9][0-9]*$/  positive integer
        objTree.Keys(getNumString("[Down]",keys)+"[Enter]");//open popup menu item by [Down]
    }
    else{
        objTree.Keys(keys);//shortcuts
    }
    eval(func);
}

