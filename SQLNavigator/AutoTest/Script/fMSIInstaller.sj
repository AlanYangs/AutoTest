//USEUNIT fCommFun
//USEUNIT fConfigOracleHome
//USEUNIT fFileUnit
//USEUNIT vGlobalVariables

//-------------------------------------------------------------------------------------
//Function Name : MSIInstaller
//Author        : Alan.Yang
//Create Date   : May 11, 2015
//Last Modify   : 
//Description   : MSI Installer
//Parameter     : [IN]sSourcePath -- the build path, Required
//Return        : null
//-------------------------------------------------------------------------------------
function MSIInstaller(){
    
    var bLaunchStatus = bLaunchQI(gStrBuildPath,gStrBuildType);
    if(bLaunchStatus){
        var objMSIDialog = Aliases.MSIprocess.wnMSIDialog;
        if(bObjExists(objMSIDialog)){
            Log.Message("The window "+ objMSIDialog.WndCaption +" is show.");
            Delay(1000);
            //step 1
            var objWelcomeLabel = objMSIDialog.labWelcome;
            if(objWelcomeLabel.Exists){
                if(objWelcomeLabel.WndCaption.indexOf("SQL Navigator")>0){
                    Log.Message("The label text is matched successful.");
                }
                else{
                    Log.Error("The label text is not matched.",null,pmNormal,null,Sys.Desktop);
                }
            }
            btnClick("Next");
            
            //step 2
            var objAcceptAgreement = objMSIDialog.chkAccept;
            if(objAcceptAgreement.Exists){
                if(objAcceptAgreement.wState != 1){
                    objAcceptAgreement.Click();
                    btnClick("Next");
                }
            }
            else{
                Log.Error("The Accept Terms is not exist.",null,pmNormal,null,Sys.Desktop);
                return;
            }
            
            //step 3
            var btnBrowse = objMSIDialog.btnBrowse;
            if(btnBrowse.Exists){
                btnBrowse.Click();
                Log.Message("Browse button is clicked.");
                if(objMSIDialog.ChildCount == 18){
                    
                    var objMSIDialog_new = Aliases.Sys.MSIprocess.Window("MsiDialogCloseClass", "SQL Navigator * Setup", 1);
                    
                    if(objMSIDialog_new.ChildCount == 14){
                        setInstallPath(objMSIDialog_new,gStrInstallPath);
                    }
                    else{
                        Log.Error("Occur exception, the select install path Dialog is not found.",null,pmNormal,null,Sys.Desktop);
                        return;
                    }
                }
                else{
                    setInstallPath(objMSIDialog,gStrInstallPath);
                }
            }
            else{
                Log.Error("The Browse button is not found.",null,pmNormal,null,Sys.Desktop);
                return; 
            }
            btnClick("Next");
            
            //step 4
            var btnInstall = objMSIDialog.btnInstall;
            if(btnInstall.Exists){
                
                btnInstall.Click();
                Log.Message("Install button is clicked.");
                var objProgressBar = objMSIDialog.progressBar;
                var counter = 1;
                while (objProgressBar.Exists){
                    Delay(2000);
                    if(counter > 40){
                        Log.Error("Installing occur timeout.",null,pmNormal,null,Sys.Desktop);
                        return;
                    }
                    counter++;
                }
            }
            else{
                Log.Error("Occur exception, the Install button is not found.",null,pmNormal,null,Sys.Desktop);
                return;
            }
            
            //step 5
            btnClick("Finish");
            
            //step 6 verify the size of dll file
            verifyDLLFile(gStrInstallPath,"borlndmm.dll");
            
            //step 7 copy TNS files to oracle home
            copyTnsFileToOracleHome();
        }
        else{
            Log.Error("The MSI window is not show.",null,pmNormal,null,Sys.Desktop);
            return;
        }
    }
}



//-------------------------------------------------------------------------------------
//Function Name : bLaunchQI
//Author        : Alan.Yang
//Create Date   : May 11, 2015
//Last Modify   : 
//Description   : Launch QI or MSI
//Parameter     : [IN]sSourcePath -- the build path, Required
//Parameter     : [IN]sInstallType -- the type of product, Required
//Parameter     : [IN]sBitNumber -- bit number, it not fill necessarily, default = "64bit"
//Return        : boolean
//-------------------------------------------------------------------------------------
function bLaunchQI(sSourcePath,sInstallType){

    var sFileName,sFilePath;
    var sBitNumber = arguments[2] ? arguments[2] : "64bit";//set default value to the third argument
    
    switch(sInstallType){
        
        case "Commercial":
            sFilePath =  sGetAppFilePath(sSourcePath, "SQL Navigator for Oracle*Commercial*"+sBitNumber+"*", false);
            break;
        case "Development Suite Commercial":
            sFilePath =  sGetAppFilePath(sSourcePath, "SQL Navigator for Oracle*Development Suite Commercial*"+sBitNumber+"*", false);
            break;
        case "Development Suite Trial":
            sFilePath =  sGetAppFilePath(sSourcePath, "SQL Navigator for Oracle*Development Suite Trial*"+sBitNumber+"*", false);
            break;
        case "Trial":
            sFilePath =  sGetAppFilePath(sSourcePath, "SQL Navigator for Oracle*0 Trial*"+sBitNumber+"*", false);
            break;
        case "Beta":
            sFilePath =  sGetAppFilePath(sSourcePath, "sqlnav_*Beta*"+sBitNumber+"*", false);
            break;
    }  
        
    if(aqFile.Exists(sFilePath)){
        sFileName = aqFileSystem.GetFileName(sFilePath); 
        if (aqFile.Exists(aqFileSystem.IncludeTrailingBackSlash(Project.Path) + sFileName)==false) {
            aqFile.Copy(sFilePath,Project.Path,false);
            Log.Message("Copy file from [ " + sFilePath + " ] to [" + Project.Path +" ]");
        }
        else{
            Log.Message("Have exists the file in path: " + aqFileSystem.IncludeTrailingBackSlash(Project.Path) + sFileName);
        }
        
        if(sFileName.substr(sFileName.length-3,3).toLowerCase() == "exe"){
            Win32API.WinExec(aqFileSystem.IncludeTrailingBackSlash(Project.Path) + sFileName,SW_SHOW);
            Log.Message("Launching exe Application...");
            return true;
        }
        else if(sFileName.substr(sFileName.length-3,3).toLowerCase() == "msi"){
            killProcess("msiexec.exe");
            var WshShell = new ActiveXObject("WScript.Shell");
            WshShell.Run("cmd.exe /c "+ "\"" + aqFileSystem.IncludeTrailingBackSlash(Project.Path) + sFileName + "\"",true);
            Log.Message("Launching msi Application...");
            return true;
        }
    }
    else{
        Log.Error("The path [ "+sFilePath+" ] is not found.",null,pmNormal,null,Sys.Desktop);
        return false;
    }
}

function btnClick(strBtnName){

    var objMSIDialog,objBtn;
    objMSIDialog = Aliases.Sys.MSIprocess.wnMSIDialog;
    objMSIDialog.Refresh();
    switch(strBtnName){
        case "Next":
           objBtn = objMSIDialog.btnNext;
           break;
        case "Finish":
           objBtn = objMSIDialog.btnFinish;
           break;
    }
    if(objBtn.Enabled){
        objBtn.Click();
        Log.Message(strBtnName +" button is clicked.");
    }else{
        Log.Error("Occur exception, " + strBtnName + " button is disable.",null,pmNormal,null,Sys.Desktop);
        return;
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setInstallPath
//Author        : Alan.Yang
//Create Date   : May 12, 2015
//Last Modify   : 
//Description   : setting the installation path of SQLNav 
//Parameter     : [IN]obj -- the main MSI window, Required
//Parameter     : [IN]strPath -- the installation path, Required
//Return        : null
//-------------------------------------------------------------------------------------
function setInstallPath(obj, strPath){

    var objInstallPath = obj.Window("RichEdit20W", "");
    if(objInstallPath.Exists){
        objInstallPath.wText = "";
        objInstallPath.wText = strPath;
        Log.Message("The install path is:"+ objInstallPath.wText);
        var btnOK = obj.Window("Button", "OK");
        if(btnOK.Enabled){
            btnOK.Click();
        }else{
            Log.Error("Occur exception, the OK button is disable.",null,pmNormal,null,Sys.Desktop);
            return;
        }
    }else{
        Log.Error("The RichEdit of select install path is not found.",null,pmNormal,null,Sys.Desktop);
        return;
    }

}

//-------------------------------------------------------------------------------------
//Function Name : verifyDLLFile
//Author        : Alan.Yang
//Create Date   : May 12, 2015
//Last Modify   : 
//Description   : verifing the ddl file's size
//Parameter     : [IN]strFilePath -- the file path, Required
//Parameter     : [IN]strFileName -- the file name, Required
//Parameter     : [IN]strBitNumber -- the type of SQLNav's bit, Optional, default = "64bit"
//Return        : null
//-------------------------------------------------------------------------------------
function verifyDLLFile(strFilePath, strFileName, strBitNumber){
    
    var bitNumber; 
    if (arguments[2] == undefined){
        bitNumber = "64bit";
    }else{
        bitNumber = strBitNumber;
    }
    if(aqFile.Exists(strFilePath +"\\"+ strFileName)){
        Log.Message("the file in path:" + strFilePath +"\\"+ strFileName);
        var FileSize = parseInt(aqFile.GetSize(strFilePath +"\\"+ strFileName)/ 1024); //transfer to int 
        switch(bitNumber){
            case "64bit":   //79kb
                if(FileSize > 74 && FileSize < 84){
                    Log.Message("The file " + strFileName + " 's size= "+ FileSize +" kb,it's normal.");
                }else{
                    Log.Error("The file " + strFileName + " 's size= "+ FileSize +" kb,it's ! match.",null,pmNormal,null,Sys.Desktop);
                    return;
                }
                break;
            case "32bit":   //42kb
                if(FileSize > 37 && FileSize < 47){
                    Log.Message("The file " + strFileName + " 's size= "+ FileSize +" kb,it's normal.");
                }else{
                    Log.Error("The file " + strFileName + " 's size= "+ FileSize +" kb,it's ! match.",null,pmNormal,null,Sys.Desktop);
                    return;
                }
                break;
        }

    }else{
        Log.Error("Can ! found the file in path:" + strFilePath +"\\"+ strFileName ,null,pmNormal,null,Sys.Desktop);
        return;
    }

}