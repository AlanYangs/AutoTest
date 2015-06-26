//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT Menu_View

//-------------------------------------------------------------------------------------
//Function Name : traverseToolsMenu
//Author        : Alan.Yang
//Create Date   : June 25, 2015
//Last Modify   : 
//Description   : Traversing the "Tools" menu
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkDBExplorer(){
    var objNavBar = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.dpToolbox.NavBar;
    if(objNavBar.Exists){
        var frmDbExplorer = objNavBar.frmDbExplorer;
        while(!frmDbExplorer.Exists || !frmDbExplorer.Visible){
            objNavBar.Keys("~^p");//Alt+Ctrl+P, switch toolbars
        }
        var objDBTree = frmDbExplorer.vstDbNavigator;
        if(objDBTree.Exists){
            Log.Message("The DB Explorer Tree has displayed.");
            collapseAllNode(objDBTree);
            
            
        }
        else{
            Log.Error("The DB Explorer Tree is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Navigator Bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}