//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT fLogon
//USEUNIT fCodeEditor

function traverseSessionMenu(){
    var objMainMenuBar = Aliases.Sqlnavigator.frmMain.HeadZone.MainMenuBar;
    if(objMainMenuBar.Exists){
        
        
    }
    else{
        Log.Error("Main menu bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    checkDialogError();
    checkOutputError();
}