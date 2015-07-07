//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT fConfirmations
//USEUNIT fCodeEditor

var strSqlPath = Project.Path + "AutoFiles\\CodeEditor\\Syntax\\";
//-------------------------------------------------------------------------------------
//Function Name : checkSyntax
//Author        : Alan.Yang
//Create Date   : July 6, 2015
//Last Modify   : 
//Description   : Checking the function of Syntax in Code Editor
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkSyntax(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    closeCodeEditor();
    frmMain.Keys("^m");
    setCodeEditorSyntax("CreateTables.sql","checkOutputByGivenString(\"SQL statement executed\");");
    setCodeEditorSyntax("Insert.sql","checkOutputByGivenString(\"row(s) inserted\");");
    setCodeEditorSyntax("Alias.sql","checkExecuteResult();");
    setCodeEditorSyntax("DBLink.sql","checkExecuteResult();");
    setCodeEditorSyntax("Comments.sql","checkExecuteResult();");
    setCodeEditorSyntax("JoinClause.sql","checkExecuteResult();");
    setCodeEditorSyntax("UnionClause.sql","checkExecuteResult();");
    setCodeEditorSyntax("SelectExtract01.sql","checkExecuteResult();");
    setCodeEditorSyntax("SelectExtract02.sql","checkExecuteResult();");
    setCodeEditorSyntax("SelectExtract03.sql","checkExecuteResult();");
    setCodeEditorSyntax("SelectExtract04.sql","checkExecuteResult();");
    setCodeEditorSyntax("Connect.sql","checkExecuteResult();");//SQL Plus Command
    setCodeEditorSyntax("Describe.sql","checkOutputByGivenString(\"SQL*Plus statement executed\",3);");//SQL Plus Command
    
    setCodeEditorSyntax("CodeCompletion\\CreatePACKAGE.sql","");
    setCodeCompletion("Dot1.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot2.sql","addBracketsToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot3.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot4.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot5.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot6.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot7.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot8.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot9.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot10.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot11.sql","moveDot(getNumString(\"[Left]\",21)+\".\");","checkCodeCompletionResult();");
    setCodeCompletion("Dot12.sql","moveDot(getNumString(\"[Up]\",5)+\".\");","checkCodeCompletionResult();");
    setCodeCompletion("Dot13.sql","moveDot(\"[Up].\");","checkCodeCompletionResult();");
    setCodeCompletion("Dot14.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot15.sql","moveDot(getNumString(\"[Left]\",11)+\"[Up].\");","checkCodeCompletionResult();");
    setCodeCompletion("Dot16.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("Dot17.sql","moveDot(\"[Up].\");","checkCodeCompletionResult();");
    
    setCodeEditorSyntax("CodeCompletion\\CreateSYNONYM.sql","");
    setCodeCompletion("SYNONYMDot1.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("SYNONYMDot2.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("SYNONYMDot3.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("SYNONYMDot4.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("SYNONYMDot5.sql","addDotToSql();","checkCodeCompletionResult();");
    setCodeCompletion("SYNONYMDot6.sql","addDotToSql();","checkCodeCompletionResult();");
    
    checkDialogError();
    checkOutputError();
}

//-------------------------------------------------------------------------------------
//Function Name : setCodeEditorSyntax
//Author        : Alan.Yang
//Create Date   : July 6, 2015
//Last Modify   : 
//Description   : Inputting and executing the sqls in Code Editor
//Parameter     : [IN]strFileName -- the file name
//Parameter     : [IN]func -- the next need to executed function name
//Return        : null
//-------------------------------------------------------------------------------------
function setCodeEditorSyntax(strFileName,func){
    if(aqFile.Exists(strSqlPath + strFileName)){
        Sys.Clipboard = "";
        Sys.Clipboard = aqFile.ReadWholeTextFile(strSqlPath + strFileName,22);
        edtCodeEditor = getCurrentTab();
        if(edtCodeEditor != null){
            edtCodeEditor.Click();
            edtCodeEditor.Keys("^a[Del]");//clear text
            edtCodeEditor.Keys("^v");
            Log.Message("Loading file ["+ strSqlPath + strFileName +"] to Code Editor.");
            edtCodeEditor.Keys("^a[F9]");
            Log.Message("Executing the sql of ["+ strFileName +"] in current Code Editor tab.");
            var objError = getCodeEditorErrorView();// Error view panel
            if(objError != null && objError.wRootItemCount > 0){
                for(var i=0; i<objError.wRootItemCount; i++){
                    Log.Error(objError.wRootItem(i),null,pmNormal,null,Sys.Desktop);
                }
            }
            if(func != "") eval(func);
        }
        else{
            Log.Error("Code Editor is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Path"+ strSqlPath + strFileName +" is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setCodeCompletion
//Author        : Alan.Yang
//Create Date   : July 7, 2015
//Last Modify   : 
//Description   : Inputting and checking the code completion in Code Editor
//Parameter     : [IN]strFileName -- the file name
//Parameter     : [IN]funcThread -- the next need to executed function name
//Parameter     : [IN]funcCheck -- checking result function name
//Return        : null
//-------------------------------------------------------------------------------------
function setCodeCompletion(strFileName,funcThread,funcCheck){
    if(aqFile.Exists(strSqlPath+"CodeCompletion\\" + strFileName)){
        Sys.Clipboard = "";
        Sys.Clipboard = aqFile.ReadWholeTextFile(strSqlPath+"CodeCompletion\\" + strFileName,22);
        edtCodeEditor = getCurrentTab();
        if(edtCodeEditor != null){
            edtCodeEditor.Click();
            edtCodeEditor.Keys("^a[Del]");//clear text
            edtCodeEditor.Keys("^v");
            Log.Message("Loading file ["+ strSqlPath+"CodeCompletion\\" + strFileName +"] to Code Editor.");
            if(funcThread != "") eval(funcThread);
            if(funcCheck != "") eval(funcCheck);
        }
        else{
            Log.Error("Code Editor is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Path"+ strSqlPath+"CodeCompletion\\" + strFileName +" is not exists.",null,pmNormal,null,Sys.Desktop);
    }   
}

//whether data grid is show or not 
function checkExecuteResult(){
    if(getCodeEditorDataGrid() == null){
        Log.Error("Run query failed, Data gird is not show.",null,pmNormal,null,Sys.Desktop);
    }
    else{
        Log.Message("Run query successed, Data grid is show.");
    }
    clearCurrentOutput();
}

//whether Code Completion popup menu is show or not 
function checkCodeCompletionResult(){
    var objPopupList = Aliases.Sqlnavigator.Window("TecPopupContainer", "", 1);
    if(objPopupList.Exists){
        Log.Message("Code Completion drop-down list has displayed on CodeEditor.");
    }
    else{
        Log.Error("Code Completion drop-down list is not show.",null,pmNormal,null,Sys.Desktop);
    }
}

function addDotToSql(){
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor != null){
        edtCodeEditor.Keys("^[End]");
        edtCodeEditor.Keys(".");
        Log.Message("Go to End && Add Dot.");
    }
    else{
        Log.Error("Code Editor can not edit.",null,pmNormal,null,Sys.Desktop);
    }
}

function moveDot(aStrKeys){
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor != null){
        edtCodeEditor.Keys("^[End]");
        edtCodeEditor.Keys(aStrKeys);
        Log.Message("Go to End && Move cursor,Add Dot.");
    }
    else{
        Log.Error("Code Editor can not edit.",null,pmNormal,null,Sys.Desktop);
    }    
}

function addBracketsToSql(){
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor != null){
        edtCodeEditor.Keys("^[End]");
        edtCodeEditor.Keys("(");
        Log.Message("Go to End && Add Brackets.");
    }
    else{
        Log.Error("Code Editor can not edit.",null,pmNormal,null,Sys.Desktop);
    }
}