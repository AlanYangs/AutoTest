//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT fLogon

//-------------------------------------------------------------------------------------
//Function Name : checkMainToolbar
//Author        : Alan.Yang
//Create Date   : July 22, 2015
//Last Modify   : 
//Description   : Checking the Toolbar's button in MainMenu
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkMainToolbar(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    if(frmMain.Exists && frmMain.Visible){
        closeCodeEditor();
        frmMain.Keys("^m");
        var edtCodeEditor = getCurrentTab();
        if(edtCodeEditor != null){
            setToolBarCustomize();
            setCodeEditorLayout();
            //Session Toolbar
            var SessionToolbar = frmMain.HeadZone.SessionToolbar;
            clickToolbarButton("New Session",18,SessionToolbar,"func_Pre_NewSession();","func_Post_NewSession();");
            clickToolbarButton("Current Session",122,SessionToolbar,"","");
            clickToolbarButton("Server Output",190,SessionToolbar,"func_Pre_OutputButton(\"Server Output\",190);","func_Post_ServerOutput();");
            clickToolbarButton("Web Output",211,SessionToolbar,"func_Pre_OutputButton(\"Web Output\",211);","func_Post_WebOutput();");
            clickToolbarButton("Suspend Current Task",250,SessionToolbar,"func_Pre_SuspendTask();","");
            clickToolbarButton("Stop Current Task",270,SessionToolbar,"func_Pre_StopTask();","");
            clickToolbarButton("Commit",300,SessionToolbar,"func_Pre_Commit();","func_Post_Commit();")
            clickToolbarButton("RollBack",328,SessionToolbar,"func_Pre_RollBack();","func_Post_RollBack();")
        }
    }else{
        Log.Error("SQLNav aplication is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : clickToolbarButton
//Author        : Alan.Yang
//Create Date   : July 15, 2015
//Last Modify   : 
//Description   : click the button on toolbar
//Parameter     : [IN]strButtonName -- the button name
//Parameter     : [IN]objToolbar -- the toolbar object
//Parameter     : [IN]intPositionX -- the position of X
//Parameter     : [IN]funcPreRun -- if funcPreRun not equal empty, the run the funcPreRun at first
//Parameter     : [IN]funcPostRun -- if funcPostRun not equal empty, the run the funcPostRun after funcPreRun
//Return        : null
//-------------------------------------------------------------------------------------
function clickToolbarButton(strButtonName,intPositionX,objToolbar,funcPreRun,funcPostRun){
    if(objToolbar.Exists){
        if(funcPreRun != "") eval(funcPreRun);
        
        objToolbar.Click(objToolbar.Width*(intPositionX/objToolbar.Width),objToolbar.Height/2);
        Log.Message("Click Toolbar Button ["+ strButtonName +"].");
        
        if(funcPostRun != "") eval(funcPostRun);
    }else{
        Log.Error("Toolbar "+ strButtonName +" is not exists.",null,pmNormal,null,Sys.Desktop);
        return;
    }
}

/****************************** Session Toolbar ******************************/
//New Session
function func_Pre_NewSession(){
    var bbNewSession = Aliases.Sqlnavigator.frmMain.bbNewSession;
    checkToolbarButtonStatus("New Session",bbNewSession,true,false);
}

function func_Post_NewSession(){
    var frmLogon = Aliases.Sqlnavigator.frmLogon;
    existAndCloseWin("Logon",frmLogon);
}
//Server/Web Output
function func_Pre_OutputButton(strName,intPosition){
    
    var bbOutputButton;
    var SessionToolbar = Aliases.Sqlnavigator.frmMain.HeadZone.SessionToolbar;
    if(strName == "Server Output"){
        bbOutputButton = Aliases.Sqlnavigator.frmMain.bbServerOutput;
    }
    else if(strName == "Web Output"){
        bbOutputButton = Aliases.Sqlnavigator.frmMain.bbWebOutput;
    }
    if(bbOutputButton.Down){
        SessionToolbar.Click(SessionToolbar.Width*(intPosition/SessionToolbar.Width),SessionToolbar.Height/2);
        Log.Message("Turn off the "+strName);
    }
    checkToolbarButtonStatus(strName,bbOutputButton,true,false);
    clearCurrentOutput();
}

function func_Post_ServerOutput(){
    var bbServerOutput = Aliases.Sqlnavigator.frmMain.bbServerOutput;
    checkToolbarButtonStatus("Server Output",bbServerOutput,true,true);
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("begin dbms_output.PUT_LINE('Test Server Output'); end;");
        edtCodeEdtior.Keys("[F9]");
        checkOutputByGivenString("Test Server Output");
    }
}

function func_Post_WebOutput(){
    var bbWebOutput = Aliases.Sqlnavigator.frmMain.bbWebOutput;
    checkToolbarButtonStatus("Web Output",bbWebOutput,true,true);
    checkOutputByGivenString("Web support enabled for session");
}

function func_Pre_SuspendTask(){
    var bbSessionSuspend = Aliases.Sqlnavigator.frmMain.bbSessionSuspend;
    checkToolbarButtonStatus("Suspend Current Task",bbSessionSuspend,false,false);
}

function func_Pre_StopTask(){
    var bbStop = Aliases.Sqlnavigator.frmMain.bbStop;
    checkToolbarButtonStatus("Stop Current Task",bbStop,false,false);
}
//Commit
function func_Pre_Commit(){
    var bbCommit = Aliases.Sqlnavigator.frmMain.bbCommit;
    checkToolbarButtonStatus("Commit",bbCommit,true,false);
    clearCurrentOutput();
}

function func_Post_Commit(){
    checkOutputByGivenString("Transaction Committed");
}
//RollBack
function func_Pre_RollBack(){
    var bbRollback = Aliases.Sqlnavigator.frmMain.bbRollback;
    checkToolbarButtonStatus("RollBack",bbRollback,true,false);
    clearCurrentOutput();
}

function func_Post_RollBack(){
    checkOutputByGivenString("Transaction Rolled Back");
}
