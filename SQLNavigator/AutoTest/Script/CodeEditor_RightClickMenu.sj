//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT CodeEditorToolbar
//USEUNIT fCodeEditor
//USEUNIT CodeEditor_Syntax

//-------------------------------------------------------------------------------------
//Function Name : checkRightClickMenu
//Author        : Alan.Yang
//Create Date   : July 24, 2015
//Last Modify   : 
//Description   : Checking the Right Click Menu's item in Code Editor
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkRightClickMenu(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    if(frmMain.Exists && frmMain.Visible){
        closeCodeEditor();
        frmMain.Keys("^m");
        clickPopupMenuItem("Undo","u","inputStrToCodeEdtior(\"Test Undo\");","func_Post_Undo();");
        clickPopupMenuItem("Redo","r","func_Pre_ItemRedo();","func_Post_Redo();");
        clickPopupMenuItem("Cut","t","func_Pre_ItemCut();","func_Post_Cut();");
        clickPopupMenuItem("Copy","c","func_Pre_ItemCopy();","func_Post_Copy();");
        clickPopupMenuItem("Paste","p","func_Pre_ItemPaste();","func_Post_Paste();");
        clickPopupMenuItem("Select All","a","func_Pre_ItemSelectAll();","func_Post_ItemSelectAll();");
        clickPopupMenuItem("Auto Code Completion",getNumString("[Down]",7)+"[Enter]","func_Pre_ItemCodeCompletion();","func_Post_ItemCodeCompletion();");
        clickPopupMenuItem("Auto Reparse",getNumString("[Down]",8)+"[Enter]","","");
        clickPopupMenuItem("Go to Definition",getNumString("[Down]",9)+"[Enter]","func_Pre_ItemDefinition();","func_Post_ItemDefinition();");
        clickPopupMenuItem("Describe",getNumString("[Down]",10)+"[Enter]","func_Pre_ItemDefinition();","func_Post_ItemDescribe();");
        clickPopupMenuItem("Back",getNumString("[Down]",11)+"[Enter]","func_Pre_Back(true);","closeCurrentTab();");
        clickPopupMenuItem("Forward",getNumString("[Down]",12)+"[Enter]","func_Pre_Forward(true);","closeCurrentTab();");
        clickPopupMenuItem("Toolbox-->Align Left",getNumString("[Down]",13)+"[Right][Enter]","","");
        clickPopupMenuItem("Toolbox-->Align Right",getNumString("[Down]",13)+"[Right][Down][Enter]","","");
        clickPopupMenuItem("Toolbox-->Next Page",getNumString("[Down]",13)+"[Right]"+getNumString("[Down]",2)+"[Enter]","","");
        clickPopupMenuItem("Toolbox-->Previous Page",getNumString("[Down]",13)+"[Right]"+getNumString("[Down]",3)+"[Enter]","","");
    
        clickPopupMenuItem("File-->New SQL Tab",getNumString("[Down]",14)+"[Right][Enter]","func_Pre_ItemNewSQL();","func_Post_NewSQL();");
        clickPopupMenuItem("File-->Open File",getNumString("[Down]",14)+"[Right][Down][Enter]","","func_Post_OpenFile();");
        clickPopupMenuItem("File-->Send to New Session",getNumString("[Down]",14)+"[Right]"+getNumString("[Down]",3)+"[Right][Enter]","inputStrToCodeEdtior(\"Test Send to session\");","func_Post_NewSession();");
        clickPopupMenuItem("File-->Save to File",getNumString("[Down]",14)+"[Right]"+getNumString("[Down]",4)+"[Enter]","inputStrToCodeEdtior(\"select 'Test for save to file' from dual;\");","func_Post_SaveToFile();");
        clickPopupMenuItem("File-->Save to File As",getNumString("[Down]",14)+"[Right]"+getNumString("[Down]",5)+"[Enter]","inputStrToCodeEdtior(\"select 'Test for save to file' from dual;\");","func_Post_SaveToFile();");
    
        clickPopupMenuItem("Object-->New Stored Object",getNumString("[Down]",15)+"[Right][Enter]","","func_Post_NewStoredObject();");
        clickPopupMenuItem("Object-->Open Object",getNumString("[Down]",15)+"[Right][Down][Enter]","","func_Post_OpenObject();");
        clickPopupMenuItem("Object-->Open/Create Package Body",getNumString("[Down]",15)+"[Right]"+getNumString("[Down]",2)+"[Enter]","func_Pre_OpenPackage();","clickConfirmations(false);");
        clickPopupMenuItem("Object-->Execute",getNumString("[Down]",15)+"[Right]"+getNumString("[Down]",4)+"[Enter]","","func_Post_Execute();");
        clickPopupMenuItem("Object-->Preview",getNumString("[Down]",15)+"[Right]"+getNumString("[Down]",5)+"[Enter]","func_Pre_OpenPackage();","closeCurrentTab();");
        clickPopupMenuItem("Object-->Generate DDL",getNumString("[Down]",15)+"[Right]"+getNumString("[Down]",6)+"[Enter]","func_Pre_OpenPackage();","closeCurrentTab();");
        clickPopupMenuItem("Object-->Save to DB",getNumString("[Down]",15)+"[Right]"+getNumString("[Down]",7)+"[Enter]","func_Pre_OpenPackage();","checkOutputByGivenString(\"Compilation complete\");");
        clickPopupMenuItem("Object-->Save to DB As",getNumString("[Down]",15)+"[Right]"+getNumString("[Down]",8)+"[Enter]","","func_Post_Clone();");
    
        clickPopupMenuItem("Edit-->Selection Mode-->Block",getNumString("[Down]",16)+"[Right][Right][Down][Enter]","","");
        clickPopupMenuItem("Edit-->Selection Mode-->Stream",getNumString("[Down]",16)+"[Right][Right][Enter]","","");
        clickPopupMenuItem("Edit-->Duplicate Line",getNumString("[Down]",16)+"[Right][Down][Enter]","func_Pre_DuplicateLine();","func_Post_DuplicateLine();");
        clickPopupMenuItem("Edit-->Format Text",getNumString("[Down]",16)+"[Right]"+getNumString("[Down]",2)+"[Enter]","func_Pre_ItemFormat();","func_Post_ItemFormat();");
        clickPopupMenuItem("Edit-->Comment Selection",getNumString("[Down]",16)+"[Right]"+getNumString("[Down]",3)+"[Enter]","func_Pre_Comment(true);","func_Post_Comment();");
        clickPopupMenuItem("Edit-->UnComment Selection",getNumString("[Down]",16)+"[Right]"+getNumString("[Down]",4)+"[Enter]","func_Pre_UnComment(true);","func_Post_UnComment();");
        clickPopupMenuItem("Edit-->Jump to Matching Bracket",getNumString("[Down]",16)+"[Right]"+getNumString("[Down]",5)+"[Enter]","inputStrToCodeEdtior(\"(())\");","closeCurrentTab();");
    
        clickPopupMenuItem("Bookmarks-->Toggle Bookmarks",getNumString("[Down]",17)+"[Right][Right][Enter]","","");
        clickPopupMenuItem("Bookmarks-->Go To Bookmarks",getNumString("[Down]",17)+"[Right][Down][Right][Enter]","","");
    
        clickPopupMenuItem("Split/Compare-->Vertical Split",getNumString("[Down]",18)+"[Right][Enter]","","");
        clickPopupMenuItem("Split/Compare-->Horizontal Split",getNumString("[Down]",18)+"[Right][Down][Enter]","","");
        clickPopupMenuItem("Split/Compare-->No Split",getNumString("[Down]",18)+"[Right][Down][Down][Enter]","","");
    
        clickPopupMenuItem("SQL Conditions-->Add Condition",getNumString("[Down]",20)+"[Right][Enter]","func_Pre_AddCondition();","func_Post_AddCondition();");
        clickPopupMenuItem("SQL Conditions-->Remove All Condition",getNumString("[Down]",20)+"[Right][Down][Enter]","func_Pre_RemoveAllConditions();","func_Post_RemoveAllConditions();");
    
        clickPopupMenuItem("SQL Options-->Updateable",getNumString("[Down]",21)+"[Right][Enter]","","");
        clickPopupMenuItem("SQL Options-->Stop on Error",getNumString("[Down]",21)+"[Right][Down][Enter]","","");
        clickPopupMenuItem("SQL Options-->Spool to Screen",getNumString("[Down]",21)+"[Right]"+getNumString("[Down]",2)+"[Enter]","","");
        clickPopupMenuItem("SQL Options-->Clear Spool on Run",getNumString("[Down]",21)+"[Right]"+getNumString("[Down]",3)+"[Enter]","","");
        clickPopupMenuItem("SQL Options-->Fetch All",getNumString("[Down]",21)+"[Right]"+getNumString("[Down]",4)+"[Enter]","","");
        clickPopupMenuItem("SQL Options-->Scan Binds",getNumString("[Down]",21)+"[Right]"+getNumString("[Down]",5)+"[Enter]","","");
        clickPopupMenuItem("SQL Options-->Echo SQL",getNumString("[Down]",21)+"[Right]"+getNumString("[Down]",6)+"[Enter]","","");
        clickPopupMenuItem("SQL Options-->Show Bind Variables",getNumString("[Down]",21)+"[Right]"+getNumString("[Down]",7)+"[Enter]","","func_Post_BindVariables();");
        clickPopupMenuItem("SQL Options-->Show Substitutions",getNumString("[Down]",21)+"[Right]"+getNumString("[Down]",8)+"[Enter]","","func_Post_Substitutions();");
    
        clickPopupMenuItem("Execute-->Skip To Top",getNumString("[Down]",22)+"[Right][Enter]","func_Pre_SkipToPosition(\"Top\");","func_Post_SkipToTop();");
        clickPopupMenuItem("Execute-->Skip To Previous",getNumString("[Down]",22)+"[Right]"+getNumString("[Down]",1)+"[Enter]","func_Pre_SkipToPosition(\"Previous\");","closeCurrentTab();");
        clickPopupMenuItem("Execute-->Execute To End",getNumString("[Down]",22)+"[Right]"+getNumString("[Down]",2)+"[Enter]","func_Pre_ExecuteToPosition(\"End\");","checkExecuteResult();");
        clickPopupMenuItem("Execute-->Execute Step",getNumString("[Down]",22)+"[Right]"+getNumString("[Down]",3)+"[Enter]","func_Pre_ExecuteToPosition(\"Step\");","checkExecuteResult();");
        clickPopupMenuItem("Execute-->Skip Step",getNumString("[Down]",22)+"[Right]"+getNumString("[Down]",5)+"[Enter]","func_Pre_SkipToPosition(\"Step\");","closeCurrentTab();");
    }else{
        Log.Error("SQLNav aplication is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : clickPopupMenuItem
//Author        : Alan.Yang
//Create Date   : July 24, 2015
//Last Modify   : 
//Description   : click the Right Click Menu's item in Code Editor
//Parameter     : [IN]strName -- item's name
//Parameter     : [IN]strShortCut -- the shortcut of item's position
//Parameter     : [IN]func_Pre -- execute the function before click
//Parameter     : [IN]func_Post -- execute the function after click
//Return        : null
//-------------------------------------------------------------------------------------
function clickPopupMenuItem(strName,strShortCut,func_Pre,func_Post){
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor != null){
        if(func_Pre != "") eval(func_Pre);
        
        edtCodeEditor = getCurrentTab();
        edtCodeEditor.ClickR();
        edtCodeEditor.Keys(strShortCut);
        Log.Message("Right Click and select Popup menu item:" +strName);
        
        if(func_Post != "") eval(func_Post);
    }
}

//Redo
function func_Pre_ItemRedo(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    inputStrToCodeEdtior("Test Redo");
    frmMain.Keys("~EU");
    Log.Message("Click on MainMenu --> Edit --> Undo");
}
//Cut
function func_Pre_ItemCut(){
    var edtCodeEdtior = getCurrentTab();
    Sys.Clipboard = "";
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("Test Cut");
        edtCodeEdtior.Keys("^a");
    }
}
//Copy
function func_Pre_ItemCopy(){
    var edtCodeEdtior = getCurrentTab();
    Sys.Clipboard = "";
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("Test Copy");
        edtCodeEdtior.Keys("^a");
    }
}
//Paste
function func_Pre_ItemPaste(){
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("Test Paste");
        edtCodeEdtior.Keys("^a^c[Del]");
    }
}
//Select All
function func_Pre_ItemSelectAll(){
    inputStrToCodeEdtior("Test Select All");
}

function func_Post_ItemSelectAll(){
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        Sys.Clipboard = "";
        edtCodeEdtior.Keys("^c");
        if(Sys.Clipboard == "Test Select All"){
            Log.Message("Success to select all contents.")
        }else{
            Log.Error("Fail to select all contents.",null,pmNormal,null,Sys.Desktop);
        }
    }
}
//Auto Code Completion
function func_Pre_ItemCodeCompletion(){
    var objFileToolbar = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.CEToolbarControl.FileToolbar; 
    var bbtnAutoComplete = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnAutoComplete;
    if(bbtnAutoComplete.Down){
        objFileToolbar.Click(objFileToolbar.Width*(231/objFileToolbar.Width),objFileToolbar.Height/2);
        Log.Message("Turn off [Auto Code Completion].");
    }
}

function func_Post_ItemCodeCompletion(){
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("SELEC");
        Delay(500);
        checkCodeCompletionResult();
    }
}
//Go to Definition
function func_Pre_ItemDefinition(){
    inputStrToCodeEdtior("auto_tab_open");
}
function func_Post_ItemDefinition(){
    var frmTableEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmTableEditor;
    existAndCloseWin("Table Editor",frmTableEditor);
}
//open package on DB Explorer
function func_Pre_OpenPackage(){
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor != null){
        var objNavBar = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.dpToolbox.NavBar;
        var frmDbExplorer = objNavBar.frmDbExplorer;
        while(!frmDbExplorer.Exists || !frmDbExplorer.Visible){
            objNavBar.Keys("~^p");//Alt+Ctrl+P, switch toolbars
        }
        var objDBTree = frmDbExplorer.vstDbNavigator;
        collapseAllNode(objDBTree);
        var objNode = gotoAndExpandTree(objDBTree,"1-8-2");//Package
        if(objNode != null) objNode.DblClick();
        Delay(1000);
    }    
}

function func_Post_ItemDescribe(){
    var frmDescribe = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDescribe;
    existAndCloseWin("Describe",frmDescribe);
}

function func_Pre_ItemBack(){
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("declare testing number(5) :=0; testing");
        Delay(500);
        edtCodeEdtior.Keys("^[Enter]");
    }
}

function func_Pre_ItemNewSQL(){
    closeCodeEditor();
    var frmMain = Aliases.Sqlnavigator.frmMain;
    frmMain.Keys("^m");
    Delay(1000);
}

function func_Post_NewSession(){
    var frmLogon = Aliases.Sqlnavigator.frmLogon;
    existAndCloseWin("Logon",frmLogon);
}

function func_Post_ItemExecute(){
    var frmRun = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlEditor.frmRun;
    if(frmRun.Exists){
        Log.Message("Run frame has displayed.");
    }else{
        Log.Error("Run frame has not displayed.",null,pmNormal,null,Sys.Desktop);
    }
}
//Duplicate Line
function func_Pre_DuplicateLine(){
    inputStrToCodeEdtior("Test Duplicate Line");
}

function func_Post_DuplicateLine(){
    if(sCopyObjText(getCurrentTab()) == "Test Duplicate LineTest Duplicate Line"){
        Log.Message("Success to duplicate line.");
    }else{
        Log.Error("Fail to duplicate line.",null,pmNormal,null,Sys.Desktop);
    }
}
//Format Text
function func_Pre_ItemFormat(){
    inputStrToCodeEdtior("select 'format text' from dual;");
    clearCurrentOutput();
}

function func_Post_ItemFormat(){
    checkOutputByGivenString("Format complete");
}

function func_Post_BindVariables(){
    var frmDefines = Aliases.Sqlnavigator.frmDefines;
    existAndCloseWin("Bind Variables",frmDefines);
}

function func_Post_Substitutions(){
    var frmSubstitutions = Aliases.Sqlnavigator.frmSubstitutions;
    existAndCloseWin("Substitutions",frmSubstitutions);
}