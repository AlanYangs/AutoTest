//USEUNIT fCommFun
//USEUNIT fCheckErrors

//-------------------------------------------------------------------------------------
//Function Name : traverseToolsMenu
//Author        : Alan.Yang
//Create Date   : June 19, 2015
//Last Modify   : 
//Description   : Traversing the "Tools" menu
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function traverseToolsMenu(){
    var objMainMenuBar = Aliases.Sqlnavigator.frmMain.HeadZone.MainMenuBar;
    if(objMainMenuBar.Exists){
        
        objMainMenuBar.Keys("~TC");//Tools--->Code Analysis
        Log.Message("Select the MainMenu path: Tools--->Code Analysis");
        var frmCodeAnalysis = Aliases.Sqlnavigator.frmMain.MiddleZone.frmCodeAnalysis;
        existAndCloseWin("Code Analysis",frmCodeAnalysis);

        checkViewDifference();
    }
    else{
        Log.Error("Main menu bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    checkDialogError();
    checkOutputError();
}

//-------------------------------------------------------------------------------------
//Function Name : checkViewDifference
//Author        : Alan.Yang
//Create Date   : June 19, 2015
//Last Modify   : 
//Description   : Traversing the function of View Differences
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkViewDifference(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    var frmViewDifference = Aliases.Sqlnavigator.frmViewDifference;
    var strSourseFile = Project.Path + "AutoFiles\\ViewDifferences\\SourceScript.sql";
    var arrComparedFiles = new Array(2);
    arrComparedFiles[0] = Project.Path + "AutoFiles\\ViewDifferences\\ComparedScript1.sql";//no difference
    arrComparedFiles[1] = Project.Path + "AutoFiles\\ViewDifferences\\ComparedScript2.sql";//difference
    var edtSourceScript = frmViewDifference.edtScript;
    var edtComparedScript = frmViewDifference.edtComparedScript;
    var cmbObjType = frmViewDifference.cmbObjType;
    var cmbComparedObjType = frmViewDifference.cmbComparedObjType;
    var btnOK = frmViewDifference.btnOK;
    var dlgInformation = Aliases.Sqlnavigator.dlgInformation;
    var frmDifferenceViewer = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDifferenceViewer;
    //compare file
    for(i=0; i<arrComparedFiles.length; i++){
        frmMain.Keys("~TE");//Tools--->View Differences
        if(frmViewDifference.Exists){
            Log.Message("View Difference window has displayed.");
            edtSourceScript.Keys(strSourseFile);
            edtComparedScript.Keys(arrComparedFiles[i]);
            btnOK.Click();
            if(frmDifferenceViewer.Exists){
                if(dlgInformation.Exists) dlgInformation.Close();
                var pnlResult = frmDifferenceViewer.pnlResult;
                if(i==0 & trim(pnlResult.Caption) == "Files match"){
                    Log.Message("The First files's comparison result is: "+pnlResult.Caption);
                }
                else if(i==1 & trim(pnlResult.Caption).indexOf("different")!=-1){
                    Log.Message("The Second files's comparison result is: "+pnlResult.Caption);
                }
                else{
                    Log.Error("Files mismatch,the result is: "+pnlResult.Caption,null,pmNormal,null,Sys.Desktop);
                }
                frmDifferenceViewer.Close();
            }
            else{
                Log.Error("Difference Viewer window is not exists.",null,pmNormal,null,Sys.Desktop);
            }
        }
        else{
            Log.Error("View Difference window is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    //compare objects
    if(!frmViewDifference.Exists) frmMain.Keys("~TE");
    var TypeCount = cmbObjType.wItemCount;
    for(i=0; i<TypeCount; i++){
        cmbObjType.ClickItem(i);
        cmbObjType.Click(cmbObjType.Width,0);
        cmbComparedObjType.ClickItem(i);
    }
}
