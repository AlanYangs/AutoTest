//USEUNIT fCommFun
//USEUNIT vGlobalVariables
//USEUNIT CodeEditor_DBExplorer

function test(){
    var str = "|All Projects|Project2";
    Log.Message(str.lastIndexOf("|"));
    eval(null);
    var objTree = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.dpToolbox.NavBar.frmDbExplorer.vstDbNavigator;
    var objCurrentNode = gotoAndExpandTree(objTree,"1-1-2");
    var strNodeName = trim(objTree.wSelection).split("|")[trim(objTree.wSelection).split("|").length-1];
    Log.Message(strNodeName+"--strNodeName--"+strNodeName.length);
    RightClickOpenObj(objTree,objCurrentNode,getNumString("[Down]",16)+"[Right]"+getNumString("[Down]",6)+"[Enter]","locateInDbNavigator(\""+strNodeName+"\");");//Other-->
}


