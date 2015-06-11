
//-------------------------------------------------------------------------------------
//Function Name : getCodeEditorFrames
//Author        : Alan.Yang
//Create Date   : May 25, 2015
//Last Modify   : 
//Description   : get all of Code Editor Frames.
//Parameter     : null
//Return        : Object Array
//-------------------------------------------------------------------------------------
function getCodeEditorFrames(){
    var objMDI = Aliases.Sqlnavigator.frmMain.MiddleZone;
    var objCodeEditor = objMDI.frmUnifiedEditor;
    var PropArray = new Array("Name");
    var ValuesArray = new Array("VCLObject(\"frmUnifiedEditor_*\")");
    var arrCodeEditor = objMDI.FindAllChildren(PropArray,ValuesArray,1);
    arrCodeEditor = (new VBArray(arrCodeEditor)).toArray();
    if(arrCodeEditor.length >0){
        arrCodeEditor.unshift(objCodeEditor);//add the item into array's first position
    }
    else{
        var objCodeEditor = objMDI.frmUnifiedEditor;
        arrCodeEditor = new Array(objCodeEditor);
    }
    if(arrCodeEditor[0].Exists){
        arrCodeEditor[0].Activate();//active the namemapping Code Editor
    }
    return arrCodeEditor;
}

//-------------------------------------------------------------------------------------
//Function Name : setCodeEditorLayout
//Author        : Alan.Yang
//Create Date   : May 25, 2015
//Last Modify   : 
//Description   : set all of Code Editors layout.
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setCodeEditorLayout(){
    var objMDI = Aliases.Sqlnavigator.frmMain.MiddleZone;
    var arrCodeEditor = getCodeEditorFrames();
    for(i=0; i<arrCodeEditor.length; i++){
        if(arrCodeEditor[i].Exists){
            arrCodeEditor[i].Position(objMDI.Left-1,objMDI.Top-100,objMDI.Width-10,objMDI.Height-20);
            //arrCodeEditor[i].Position(arrCodeEditor[i].Left+10,arrCodeEditor[i].Top+30,arrCodeEditor[i].Width-20,arrCodeEditor[i].Height-40);
        }
        else{
            Log.Error("Code Editor is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
}

//-------------------------------------------------------------------------------------
//Function Name : getCurrentTab
//Author        : Alan.Yang
//Create Date   : May 29, 2015
//Last Modify   : 
//Description   : get the current tab in Code Editor.
//Parameter     : null
//Return        : Object
//-------------------------------------------------------------------------------------
function getCurrentTab(){
    var objPane = getCodeEditorFrames()[0].pnlEditor.TAdvPane;
    var PropArray = new Array("Name");
    var ValuesArray = new Array("Window(\"TSyntaxMemo\", *)");
    var arrTabs = objPane.FindAllChildren(PropArray,ValuesArray,1);
    if(arrTabs != null){
        arrTabs = (new VBArray(arrTabs)).toArray();
        for(i=0; i<arrTabs.length; i++){
            if(arrTabs[i].Exists & arrTabs[i].Visible){
                return arrTabs[i];
            }
        }
    }
    else{
        return null;
    }  
}

//-------------------------------------------------------------------------------------
//Function Name : closeCodeEditor
//Author        : Alan.Yang
//Create Date   : May 20, 2015
//Last Modify   : 
//Description   : close Code Editor
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function closeCodeEditor(){
    var objCodeEditor = getCodeEditorFrames()[0];
    if(objCodeEditor.Exists){
        objCodeEditor.Close();
        var objSaveCloseConfirm = Aliases.Sqlnavigator.frmSaveCloseConfirm;
        if(objSaveCloseConfirm.Exists){
            var btnClearAll = objSaveCloseConfirm.btnClearAll;
            var btnOK = objSaveCloseConfirm.btnOK;
            btnClearAll.Click();
            Log.Message("Clear all selected files.");
            btnOK.Click();
        }
        
        if(objSaveCloseConfirm.Exists){
            closeCodeEditor();
        }
        else{
            Log.Message("Code Editor have been closed.");
        }
        
    }
}
