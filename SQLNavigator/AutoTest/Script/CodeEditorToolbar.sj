//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT fConfirmations
//USEUNIT fCodeEditor

function checkCodeEditorToolbar(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    if(frmMain.Exists && frmMain.Visible){
        closeCodeEditor();
        frmMain.Keys("^m");
        setCodeEditorLayout();
        var frmCodeEditor = getCodeEditorFrames()[0];
        var edtCodeEditor = getCurrentTab();
        if(edtCodeEditor != null){
            var objFileToolbar = frmCodeEditor.CEToolbarControl.FileToolbar;
            showCodeEditorToolbar("");//just selected file toolbar
            clickToolbarButton("New SQL Tab",objFileToolbar,74);
            
        }
    }
    else{
        Log.Error("SQLNav aplication is not exists.",null,pmNormal,null,Sys.Desktop);
    }

}

//-------------------------------------------------------------------------------------
//Function Name : showCodeEditorToolbar
//Author        : Alan.Yang
//Create Date   : July 15, 2015
//Last Modify   : 
//Description   : select the specified name of toolbar
//Parameter     : [IN]strToolbarName -- the specified toolbar
//Return        : null
//-------------------------------------------------------------------------------------
function showCodeEditorToolbar(strToolbarName){
    var objCEToolbarControl = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.CEToolbarControl;
    if(objCEToolbarControl.Exists && objCEToolbarControl.Visible){
        var intChild = objCEToolbarControl.ChildCount;
        Log.Message(intChild);
        objCEToolbarControl.ClickR();
        objCEToolbarControl.Keys("c");
        var dlgToolBarCustomize = Aliases.Sqlnavigator.dlgToolBarCustomize;
        if(dlgToolBarCustomize.Exists){
            Log.Message("Toolbar Customize dialog has been displayed.");
            var tabsControl = dlgToolBarCustomize.PageControl;
            tabsControl.ClickTab(" Toolbars ");
            var toolBarList = tabsControl.ToolBarList;
            if(toolBarList.Exists){
                for(i=1; i<toolBarList.wItemCount; i++){
                    toolBarList.SelectItem(i);
                    toolBarList.DblClickItem(toolBarList.wItem(i));
                    objCEToolbarControl.Refresh();
                    if(objCEToolbarControl.ChildCount >= intChild){
                        if(toolBarList.wItem(i) != strToolbarName){
                            toolBarList.DblClickItem(toolBarList.wItem(i));
                        }
                    }
                    else{
                        if(toolBarList.wItem(i) == strToolbarName){
                            toolBarList.DblClickItem(toolBarList.wItem(i));
                        }
                    }
                    objCEToolbarControl.Refresh();
                    intChild = objCEToolbarControl.ChildCount;
                }
            }
            else{
                Log.Error("Fail to select the [Toolbars] tab.",null,pmNormal,null,Sys.Desktop);
            } 
            dlgToolBarCustomize.Close();    
        }
        else{
            Log.Error("Toolbar Customize dialog is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Code Editor Toolbar zone is not exists.",null,pmNormal,null,Sys.Desktop);
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
//Return        : null
//-------------------------------------------------------------------------------------
function clickToolbarButton(strButtonName,objToolbar,intPositionX){
    if(objToolbar.Exists){
        objToolbar.Click(objToolbar.Width*(intPositionX/objToolbar.Width),objToolbar.Height/2);
        Log.Message("Click Toolbar Button ["+ strButtonName +"].");
    }
    else{
        Log.Error("Toolbar "+ strButtonName +" is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}