//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT fCodeEditor
//USEUNIT Menu_View
//USEUNIT fLogon

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
        checkCodeFormat();
        checkSyntax();
        checkProfileCode();
        
        objMainMenuBar.Keys("~TFM");//Tools--->Formatter Tools--->Multi-File Formatting 
        Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Multi-File Formatting");
        var frmMultiFileFormat = Aliases.Sqlnavigator.frmMultiFileFormat;
        existAndCloseWin("Multi-File Formatting",frmMultiFileFormat);
        
        objMainMenuBar.Keys("~TFO");//Tools--->Formatter Tools--->Formatting Options
        Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Formatting Options");
        var frmFmtOptions = Aliases.Sqlnavigator.frmFmtOptions;
        existAndCloseWin("Formatter Options",frmFmtOptions);
        
        checkWrapCode();
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",5)+"[Enter]");//Tools--->Session Browser
        Log.Message("Select the MainMenu path: Tools--->Session Browser");
        var frmSessionBrowser = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSessionBrowser;
        existAndCloseWin("Session Browser",frmSessionBrowser);
        
        objMainMenuBar.Keys("~TK");//Tools--->Search Knowledge Xpert
        Log.Message("Select the MainMenu path: Tools--->Search Knowledge Xpert");
        checkThirdPartyTools("Knowledge Xpert");
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",7)+"[Enter]");//Tools--->SQL Optimizer
        Log.Message("Select the MainMenu path: Tools--->SQL Optimizer");
        checkThirdPartyTools("SQL Optimizer");
        
        objMainMenuBar.Keys("~TX");//Tools--->Explain Plan Tool
        Log.Message("Select the MainMenu path: Tools--->Explain Plan Tool");
        var frmExplainPlan = Aliases.Sqlnavigator.frmMain.MiddleZone.frmExplainPlan;
        existAndCloseWin("Explain Plan",frmExplainPlan);
        
        objMainMenuBar.Keys("~TP");//Tools--->PL/SQL Profiler
        Log.Message("Select the MainMenu path: Tools--->PL/SQL Profiler");
        var frmProfiler = Aliases.Sqlnavigator.frmMain.MiddleZone.frmProfiler;
        Delay(5000);
        existAndCloseWin("PL/SQL Profiler",frmProfiler);
        Delay(5000);
        
        objMainMenuBar.Keys("~TQ");//Tools--->SQL Modeler
        Log.Message("Select the MainMenu path: Tools--->SQL Modeler");
        setSqlModeler();
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",11)+"[Enter]");//Tools--->Code Road Map
        Log.Message("Select the MainMenu path: Tools--->Code Road Map");
        setCodeRoadMap();
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",12)+"[Enter]");//Tools--->ER Diagram
        Log.Message("Select the MainMenu path: Tools--->ER Diagram");
        Delay(2000);
        setERDiagram();
        
        objMainMenuBar.Keys("~TJ");//Tools--->Job Scheduler
        Log.Message("Select the MainMenu path: Tools--->Job Scheduler");
        var frmJobScheduler = Aliases.Sqlnavigator.frmMain.MiddleZone.frmJobScheduler;
        existAndCloseWin("Job Scheduler",frmJobScheduler);
        
        objMainMenuBar.Keys("~TM");//Tools--->Java Manager
        Log.Message("Select the MainMenu path: Tools--->Java Manager");
        var frmJavaManager = Aliases.Sqlnavigator.frmMain.MiddleZone.frmJavaManager;
        existAndCloseWin("Java Manager",frmJavaManager);
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",16)+"[Enter]");//Tools--->Code Tester for Oracle
        Log.Message("Select the MainMenu path: Tools--->Code Tester for Oracle");
        Delay(2000);
        checkThirdPartyTools("Code Tester");
        
        objMainMenuBar.Keys("~TB");//Tools--->Benchmark Factory
        Log.Message("Select the MainMenu path: Tools--->Benchmark Factory");
        Delay(2000);
        checkThirdPartyTools("Benchmark Factory");
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",18)+"[Enter]");//Tools--->Toad Data Modeler
        Log.Message("Select the MainMenu path: Tools--->Toad Data Modeler");
        Delay(2000);
        checkThirdPartyTools("Toad Data Modeler");
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",20)+"[Enter]");//Tools--->Profile Manager
        Log.Message("Select the MainMenu path: Tools--->Profile Manager");
        checkThirdPartyTools("Profile Manager");
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",21)+"[Enter]");//Tools--->SQL Tracker
        Log.Message("Select the MainMenu path: Tools--->SQL Tracker");
        checkThirdPartyTools("SQL Tracker");
        
        objMainMenuBar.Keys("~TZ");//Tools--->SQL Navigator Server
        Log.Message("Select the MainMenu path: Tools--->SQL Navigator Server");
        checkThirdPartyTools("SQL Navigator Server");
        
        checkAuthorizationKeys();
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
                if(i==0 && trim(pnlResult.Caption) == "Files match"){
                    Log.Message("The First files's comparison result is: "+pnlResult.Caption);
                }
                else if(i==1 && trim(pnlResult.Caption).indexOf("different")!=-1){
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
        cmbComparedObjType.ClickItem(i);
    }
    frmViewDifference.Close();
}

//-------------------------------------------------------------------------------------
//Function Name : checkCodeFormat
//Author        : Alan.Yang
//Create Date   : June 23, 2015
//Last Modify   : 
//Description   : format code
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkCodeFormat(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    frmMain.Keys("^o");//open file
    var strFile = Project.Path + "AutoFiles\\CodeEditor\\FormatCode.sql";
    var dlgOpenFile = Aliases.Sqlnavigator.dlgOpenFile;
    if(dlgOpenFile.Exists){
        dlgOpenFile.Keys(strFile+"[Enter]");
        var edtCodeEditor = getCurrentTab();
        if(edtCodeEditor != null){
            var objCurrentOutput = frmMain.BottomZone.pnlOutput.pcOutput.tabCurrent.t_currentOutput;
            if(objCurrentOutput.Exists) objCurrentOutput.Keys("^a^[Del]");//clear output
            frmMain.Keys("~TFF");//Tools--->Formatter Tools--->Format Code
            Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Format Code");
            Delay(1000);
            checkOutputByGivenString("Format complete");
            closeCodeEditor();
        }
    }
    else{
        Log.Error("Open file dialog is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkSyntax
//Author        : Alan.Yang
//Create Date   : June 23, 2015
//Last Modify   : 
//Description   : check syntax
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkSyntax(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    if(getCurrentTab() == null) frmMain.Keys("^m");
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor!= null){
        edtCodeEditor.Keys("^a[Del]");
        edtCodeEditor.Keys("Select sysdate as Date from dual where 1 = (select cast('1') from dual) order by 1 desc;");
        var objCurrentOutput = frmMain.BottomZone.pnlOutput.pcOutput.tabCurrent.t_currentOutput;
        if(objCurrentOutput.Exists) objCurrentOutput.Keys("^a^[Del]");//clear output
        frmMain.Keys("~TFY");//Tools--->Formatter Tools--->Check Syntax
        Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Check Syntax");
        checkOutputByGivenString("Syntax Check complete - no errors found.");
        checkOutputError();
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkProfileCode
//Author        : Alan.Yang
//Create Date   : June 23, 2015
//Last Modify   : 
//Description   : check Code Profile
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkProfileCode(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    if(getCurrentTab() == null) frmMain.Keys("^m");
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor!= null){
        frmMain.Keys("~TFC");//Tools--->Formatter Tools--->Profile Code
        Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Profile Code");
        var frmProfileCode = Aliases.Sqlnavigator.frmProfileCode;
        existAndCloseWin("Profile Code",frmProfileCode);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkWrapCode
//Author        : Alan.Yang
//Create Date   : June 23, 2015
//Last Modify   : 
//Description   : check Wrap Code
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkWrapCode(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    frmMain.Keys("~TA");//Tools--->Wrap Code
    Log.Message("Select the MainMenu path: Tools--->Wrap Code");
    var frmWrapCode = frmMain.MiddleZone.frmWrapCode;
    if(frmWrapCode.Exists){
        var btnFileSelect = frmWrapCode.btnFileSelect;
        btnFileSelect.Click();
        var dlgOpenFile = Aliases.Sqlnavigator.dlgOpenFile;
        if(dlgOpenFile.Exists){
            var strFile = Project.Path + "AutoFiles\\CodeEditor\\WrapCode.sql";
            dlgOpenFile.Keys(strFile+"[Enter]");
            var btnWrapCode = frmWrapCode.btnWrapCode;
            btnWrapCode.Click();
            Delay(500);
            if(aqFile.Exists(Project.Path + "AutoFiles\\CodeEditor\\WrapCode.plb")){
                Log.Message("Generate a new file: "+ Project.Path + "AutoFiles\\CodeEditor\\WrapCode.plb");
            }
            else{
                Log.Error("No file generation,Wrap Code failed.",null,pmNormal,null,Sys.Desktop);
                var TMessageForm = Aliases.Sqlnavigator.TMessageForm;
                if(bObjExists(TMessageForm,2)) TMessageForm.Close();
            }
        }
        else{
            Log.Error("Open file dialog is not display.",null,pmNormal,null,Sys.Desktop);
        }
        frmWrapCode.Close();
    }
    else{
        Log.Error("Wrap Code frame is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkThirdPartyTools
//Author        : Alan.Yang
//Create Date   : June 24, 2015
//Last Modify   : 
//Description   : check the third-party tools
//Parameter     : [IN]strToolName -- the third-party tool's name
//Return        : null
//-------------------------------------------------------------------------------------
function checkThirdPartyTools(strToolName){
    var dlgError = Aliases.Sqlnavigator.dlgError;
    if(bObjExists(dlgError,1)){
        Log.Message(dlgError.edtProblem.wText);
        dlgError.btnOK.Click();
    }
    else{
        switch (strToolName)
        {
          case "SQL Optimizer":
            var frmSqlTuning = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSqlTuning;
            var frmSqlOptimizer = Aliases.SqlOptimizer.frmSqlOptimizer;
            if(frmSqlTuning.Exists) frmSqlTuning.Close();
            if(bObjExists(frmSqlOptimizer,2)){
                Log.Message("SQL Optimizer window has displayed.");
                frmSqlOptimizer.Close();
                killProcess("*SQL Optimizer*");
            }
            else{
                Log.Error("SQL Optimizer window is not exists.",null,pmNormal,null,Sys.Desktop);
            }
            break;
          case "Knowledge Xpert":
            var wndHome = Aliases.KnowledgeXpert.wndHome;
            existAndCloseWin("Knowledge Xpert",wndHome);
            break;
          case "Profile Manager":
            var dlgConfirm = Aliases.Sqlnavigator.dlgConfirm;
            if(dlgConfirm.Exists) dlgConfirm.Keys("[Enter]");
            var frmSaveCloseConfirm = Aliases.Sqlnavigator.frmSaveCloseConfirm;
            if(frmSaveCloseConfirm.Exists){
                frmSaveCloseConfirm.btnClearAll.Click();
                Delay(500);
                frmSaveCloseConfirm.btnOK.Click();
            }
            setUserProfile("Backup");
            logon(false);//let it not show Authorization window
            break;
          case "SQL Tracker":
            var wndMain = Aliases.SqlTracker.wndMainForm;
            if(bObjExists(wndMain,2)){
                Log.Message("SQL Tracker window has displayed.");
                wndMain.Close();
            }
            else{
                Log.Error("SQL Tracker window is not exists.",null,pmNormal,null,Sys.Desktop);
            }
            break;
          case "SQL Navigator Server":
            var frmMain = Aliases.SqlnavServer.frmMain;
            if(bObjExists(frmMain,2)){
                Log.Message(frmMain.WndCaption+" window has displayed.");
                frmMain.Close();
            }
            else{
                Log.Error("SQL Navigator Server Side Installation window is not exists.",null,pmNormal,null,Sys.Desktop);
            }
            break;
          case "Code Tester":
            break;
          case "Benchmark Factory":
            break;
          case "Toad Data Modeler":
            break;
          default:
            break;
        }
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setUserProfile
//Author        : Alan.Yang
//Create Date   : June 24, 2015
//Last Modify   : 
//Description   : backup or restore User Profile
//Parameter     : [IN]strType -- backup or restore
//Return        : null
//-------------------------------------------------------------------------------------
function setUserProfile(strType){
    var frmProfileManager = Aliases.ProfileManager.frmMain;
    var strDefaultPath = aqEnvironment.GetEnvironmentVariable("userprofile",Sys.OSInfo.Windows64bit)+"\\Documents";// default path in Documents
    var dlgConfirm = Aliases.ProfileManager.dlgConfirm;
    var dlgInformation = Aliases.ProfileManager.dlgInformation;
    if(bObjExists(frmProfileManager,2)){
        Log.Message("Profile Manager window has displayed.");
        switch (strType)
        {
          case "Backup":
            var labBackup = frmProfileManager.labBackup;
            labBackup.Click();
            Log.Message("This action will be backup user profile.");
            var btnBackup = frmProfileManager.ProfileManagerPageCtrl.btnBackup;
            var edtFileName = frmProfileManager.ProfileManagerPageCtrl.edtFileName;
            var tvPath = frmProfileManager.ProfileManagerPageCtrl.tvPath;
            if(btnBackup.Exists && btnBackup.Enabled){
                var strFileName = edtFileName.wText;
                var strFolderPath =  aqString.Replace((tvPath.wSelection).substr(1),"|","\\");
                Log.Message("The Backup profile's file path is: "+strFolderPath + "\\" + strFileName);
                btnBackup.Click();
                if(dlgConfirm.Exists) dlgConfirm.Keys("[Enter]");
                if(dlgInformation.Exists) dlgInformation.Keys("[Enter]");
                
                if(aqFile.Exists(strDefaultPath + "\\" + strFileName+".prof")){
                    Log.Message("Success to backup profile to "+ strFolderPath + "\\" + strFileName+".prof");
                }
                else{
                    Log.Error("Fail to backup user profile.",null,pmNormal,null,Sys.Desktop);
                }
            }
            break;
          case "Restore":
            var labRestore = frmProfileManager.labRestore;
            labRestore.Click();
            var lvFiles = frmProfileManager.ProfileManagerPageCtrl.lvFile;
            var btnNext = frmProfileManager.ProfileManagerPageCtrl.btnNext;
            var btnRestore = frmProfileManager.ProfileManagerPageCtrl.btnRestore;
            if(lvFiles.wItemCount > 0){
                for(i=lvFiles.wItemCount; i>0; i--){
                    lvFiles.ClickItem(i,0);
                    btnNext.Refresh();
                    if(btnNext.Enabled){
                        btnNext.Click();
                        break;
                    }
                }
                if(btnRestore.Exists){
                    btnRestore.Click();
                    if(dlgConfirm.Exists) dlgConfirm.Keys("[Enter]");
                    Delay(2000);
                    if(dlgInformation.Exists) dlgInformation.Keys("[Enter]");
                    Log.Message("Success to restore profile from backup file.");
                }
            }
            break;
          default:
            break;
        }
        frmProfileManager.Close();       
    }
    else{
        Log.Error("Profile Manager window is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkAuthorizationKeys
//Author        : Alan.Yang
//Create Date   : June 25, 2015
//Last Modify   : 
//Description   : checking the priority of license keys, and writting other types of keys into ProductLicenses.xml file 
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkAuthorizationKeys(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    var frmAuthorization = Aliases.Sqlnavigator.wnAuthorizeForm;
    var edtKey = frmAuthorization.edtKey;
    var edtMesage = frmAuthorization.edtMesage;
    var btnOK = frmAuthorization.btnOK; 
    var arrLicenses = new Array(4);
    var arrSites = new Array(4);
    var arrTypes = new Array(4);
    arrLicenses[0] = "EQQFV2NZ6TJ71Y6BKG40J6MH74V0CYMRQ7-123-456-789-BB";//Base Edition,lowest level
    arrSites[0] = "Dell <.@&\"'> - prod\\ayang1";
    arrTypes[0] = "Base Edition";
    arrLicenses[1] = "E2GZFGQFRLYZA206FNZ2L27JNW6D7M5YRF-123-456-789-9E";//Professional Edition 
    arrSites[1] = "Dell <.@&\"'> - prod\\ayang1";
    arrTypes[1] = "Professional Edition";
    arrLicenses[2] = "ESCMB7PJXAJLHWFVJAVDRTY435ZKV7X3YW-123-456-789-1D";//Xpert Edition
    arrSites[2] = "Dell <.@&\"'> - prod\\ayang1";
    arrTypes[2] = "Xpert Edition";
    arrLicenses[3] = "ESSHMR4MSY0SVLMYWX3A0ZLG4QXFGFKJ0F-123-456-789-D8";//Development Suite,highest level
    arrSites[3] = "Dell <.@&\"'> - prod\\ayang1";
    arrTypes[3] = "Development Suite";
    var strLicensesFile = strLicensesPath + "\\ProductLicenses.xml";
    var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
    xmlDoc.async = false; 
    var flag = 0;
    for(i=0; i<arrLicenses.length; i++){
        frmMain.Keys("~TU");
        if(frmAuthorization.Exists){
            if(i>2){//begin to third
                //Checking it always show the highest level keys
                if(trim(edtKey.wText) != arrLicenses[i-1] && trim(edtMesage.wText) != arrTypes[i-1]){
                    Log.Message("The License key is: "+edtKey.wText);
                    Log.Message("The Site message is: "+edtMesage.wText);
                    Log.Error("Current active License is not the highest level key.",null,pmNormal,null,Sys.Desktop);
                }
            }
            Log.Message("Current active License key is: "+edtKey.wText);
            Log.Message("Current active Site message is: "+edtMesage.wText);
            //inputting new keys 
            edtKey.wText = arrLicenses[i];
            edtMesage.wText = arrSites[i];
            btnOK.Click();
            var objConfirm = Aliases.Sqlnavigator.wnAuthorizeConfirm;
            if(objConfirm.Exists) objConfirm.btnOK.Click();
            Log.Message("Writting a "+arrTypes[i]+" license into ProductLicenses.xml.");
            xmlDoc.load(strLicensesFile);//read xml
            var arrNodes = xmlDoc.getElementsByTagName("License");//get <License> node
            if(arrNodes != null && arrNodes.length >0){
                for(j=0;j<arrNodes.length;j++){
                    var arrChildNodes = arrNodes[j].childNodes;
                    if(arrChildNodes != null && arrChildNodes.length>0){//arrChildNodes contain 2 node's values:LicenseKey and SiteMessage
                        if(arrLicenses[i] == arrChildNodes[0].text && arrSites[i] == arrChildNodes[1].text){
                            Log.Message("Success to add a new licenses into ProductLicenses.xml");
                            flag++;
                            break;
                        }
                    }
                }
                if(flag == 0){
                    Log.Error("Fail to add a new licenses into ProductLicenses.xml",null,pmNormal,null,Sys.Desktop);
                }
            }
        }
        
    }
}