//USEUNIT fCommFun
//USEUNIT vGlobalVariables

function test(){
    var str = "|All Projects|Project2";
    Log.Message(str.lastIndexOf("|"));
    eval(null);
    var objTree = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.dpToolbox.NavBar.frmDbExplorer.vstDbNavigator;
    gotoAndExpandTree(objTree,"1-16-1");
}


