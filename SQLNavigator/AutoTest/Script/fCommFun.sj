//USEUNIT vGlobalVariables  
//USEUNIT fCodeEditor

//-------------------------------------------------------------------------------------
//Function Name : killProcess
//Author        : Alan.Yang
//Create Date   : May 11, 2015
//Last Modify   : 
//Description   : according to the name kill it's process
//Parameter     : [IN]ProcessName -- the name of process
//Return        : null
//-------------------------------------------------------------------------------------
function killProcess(ProcessName){

    //if(Sys.Process(ProcessName).Exists){
        var wshShell = new ActiveXObject("WScript.Shell");
        wshShell.Run("%comspec% /c taskkill /F /IM " + ProcessName +"*",true);
        wshShell = null;
        Sys.Refresh();
        Log.Message("The process [ "+ ProcessName + " ] is been killed.");
    //}
}

//-------------------------------------------------------------------------------------
//Function Name : closeSqlnavigator
//Author        : Alan.Yang
//Create Date   : July 10, 2015
//Last Modify   : 
//Description   : close SQL Navigator
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function closeSqlnavigator(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    if(frmMain.Exists){
        if(frmMain.Visible) frmMain.Close();
        var objSaveCloseConfirm = Aliases.Sqlnavigator.frmSaveCloseConfirm;
        if(objSaveCloseConfirm.Exists){
            var btnClearAll = objSaveCloseConfirm.btnClearAll;
            var btnOK = objSaveCloseConfirm.btnOK;
            btnClearAll.Click();
            Log.Message("Clear all selected files.");
            btnOK.Click();
        }
    }
    killProcess("sqlnavigator");
}

//-------------------------------------------------------------------------------------
//Function Name : exportResults
//Author        : Alan.Yang
//Create Date   : July 13, 2015
//Last Modify   : 
//Description   : export log report to specified path
//Parameter     : null
//Return        : Boolean
//-------------------------------------------------------------------------------------
function exportResults()
{
    var strFilePath = "\\\\zhuflsw01\\HOME\\alan.yang\\Automation\\Reports\\";
    var d = new Date();
    var strYear = d.getFullYear().toString();
    var strMonth = d.getMonth()+1;
    var strDay = d.getDate();
    if(strMonth < 10) strMonth = "0" + strMonth;
    if(strDay < 10) strDay = "0" + strDay;
    var Flag = parseInt(Math.random()*100);//the sign
    var strFileName = strYear + strMonth + strDay + Flag + ".mht";
    if(aqFile.Exists(strFilePath)){
        if(Log.SaveResultsAs(strFilePath + strFileName, 2)){
            return strFilePath + strFileName;
        }
        else{
            return "";
        }
    }
    else{
        Log.Warning("Path ["+strFilePath+"] is not exists.");
        return "";
    }
}

//-------------------------------------------------------------------------------------
//Function Name : bObjExists
//Author        : Micahel.luo
//Create Date   : Mar 18, 2014
//Last Modify   : Alan.Yang  , May 11, 2015
//Description   : get the ini file Option value
//Parameter     : [IN]NameMappingItem -- Name Mapping object for Aliases name which you want to judge object exists
//Parameter     : [Optional IN] -- optional parameter nWaitTime s, by default is 30s
//Return        : boolean of object exists
//-------------------------------------------------------------------------------------
function bObjExists(NameMappingItem,intSecond){
    var waitSeconds = arguments[1] == undefined ? 30:intSecond;
    var counter = 1;
    while(!NameMappingItem.Exists)
    {
        Delay(1000);
        // Refresh the mapping information to see if the object has been recreated
        NameMappingItem.RefreshMappingInfo();
        if(counter > waitSeconds){
            //Log.Error("The object "+NameMappingItem +" is not exist, wait timeout.",null,pmNormal,null,Sys.Desktop);
            break;
        }
        counter++;
    }
    return NameMappingItem.Exists;
}

//-------------------------------------------------------------------------------------
//Function Name : sRefreshObjCaption
//Author        : Alan.Yang
//Create Date   : June 2, 2015
//Last Modify   : 
//Description   : waiting for refresh the object's caption
//Parameter     : [IN]nameMapping -- Name Mapping object for Aliases name which you want to judge object exists
//Parameter     : [IN]strCaption -- the object's old caption
//Parameter     : [IN]strNewCaption -- the object's new caption
//Parameter     : [Optional IN] -- optional parameter nWaitTime s, by default is 10s
//Return        : Boolean
//-------------------------------------------------------------------------------------
function bRefreshObjCaption(nameMapping,strCaption,strNewCaption,intSecond){
    var waitSeconds = arguments[3] == undefined ? 10:intSecond;
    var counter = 1;
    var Flag = false;
    if(nameMapping.Exists){
        while(nameMapping.WndCaption == strNewCaption)
        {
            Delay(1000);
            // Refresh the mapping information to see if the object has been recreated
            nameMapping.RefreshMappingInfo();
            if(nameMapping.WndCaption == strCaption){
                Flag = true;
                break;
            }
            else{
                if(counter > waitSeconds){
                    Flag = false;
                    break;
                }
                counter++;
            }
        }
    }
    return Flag;
}
//-------------------------------------------------------------------------------------
//Function Name : execShortcuts
//Author        : Alan.Yang
//Create Date   : May 14, 2015
//Last Modify   : 
//Description   : executing the object's shortcuts
//Parameter     : [IN]objNameMapped -- the namemapped object
//Parameter     : [IN]strShortCut -- the keys of shortcut
//Return        : null
//-------------------------------------------------------------------------------------
function execShortcuts(objNameMapped,strShortcut){

    if(objNameMapped.Exists){
        objNameMapped.SetFocus();
        //spliting the string of shortcuts 
        for(i=0;i<strShortcut.length;i++)
        {
            objNameMapped.Keys(strShortcut.charAt(i));
            Log.Message("Typing shortcut:" + strShortcut.charAt(i));
            Delay(100);
        }
    } 
}

//-------------------------------------------------------------------------------------
//Function Name : trim
//Author        : Alan.Yang
//Create Date   : May 21, 2015
//Last Modify   : 
//Description   : clear the string's space
//Parameter     : [IN]s -- the source string
//Return        : String
//-------------------------------------------------------------------------------------
//clear the right and left space
function trim(s){
    return trimRight(trimLeft(s)); 
} 
//clear the left space
function trimLeft(s){ 
    if(s == null) { 
      return ""; 
    } 
    //var whitespace = new String(" \n\r"); 
    //var str = new String(s); 
    var whitespace = " \n\r";
    var str = s;
    if (whitespace.indexOf(str.charAt(0)) != -1) { 
      var j=0, i = str.length; 
      while (j < i && whitespace.indexOf(str.charAt(j)) != -1){ 
          j++; 
      } 
      str = str.substring(j, i); 
    } 
    return str; 
} 
//clear the right space 
function trimRight(s){ 
    if(s == null) return ""; 
    //var whitespace = new String(" \n\r"); 
    //var str = new String(s); 
    var whitespace = " \n\r";
    var str = s;
    if (whitespace.indexOf(str.charAt(str.length-1)) != -1){ 
      var i = str.length - 1; 
      while (i >= 0 && whitespace.indexOf(str.charAt(i)) != -1){ 
          i--; 
      } 
      str = str.substring(0, i+1); 
    } 
    return str; 
} 

//-------------------------------------------------------------------------------------
//Function Name : existAndCloseWin
//Author        : Alan.Yang
//Create Date   : May 22, 2015
//Last Modify   : 
//Description   : check the window is exist or not
//Parameter     : [IN]StrCaption -- the caption of window
//Parameter     : [IN]ObjNameMapping -- the window's namemapping
//Return        : null
//-------------------------------------------------------------------------------------
function existAndCloseWin(strCaption,objNameMapping){
    if(objNameMapping.Exists){
        if(objNameMapping.Visible){
            Log.Message("The window "+ strCaption +" has displayed.");
            objNameMapping.Close();
            Sys.Refresh();
            Delay(500);
            if(objNameMapping.Exists){
                if(objNameMapping.Visible){
                    Log.Error("The window "+ strCaption +" is still exist,fail to close it.",null,pmNormal,null,Sys.Desktop);
                }
                else{
                    Log.Message("The window "+ strCaption +" has been hided.");
                }
            }
            else{
                Log.Message("The window "+ strCaption +" has been closed.");
            }
        }
        else{
            Log.Error("The window "+ strCaption +" has not displayed.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("The window "+ strCaption +" is not exist.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : sCopyObjText
//Author        : Alan.Yang
//Create Date   : May 26, 2015
//Last Modify   : 
//Description   : copy the editable object's text contents
//Parameter     : [IN]edtObj -- the editable object's namemapping
//Return        : String
//-------------------------------------------------------------------------------------
function sCopyObjText(edtObj){
    Sys.Clipboard="";
    edtObj.Click();
    edtObj.Keys("^a^c");//copy to clipboard
    return trim(Sys.Clipboard);
}

//-------------------------------------------------------------------------------------
//Function Name : compareArrayCase
//Author        : Alan.Yang
//Create Date   : May 29, 2015
//Last Modify   : 
//Description   : Compare the two arrays, whether uppercase or lowercase equel or not.
//Parameter     : [IN]arr1 -- the source array
//Parameter     : [IN]arr2 -- the compared array
//Parameter     : [IN]isUppercase -- boolean, Is UpperCase ? 
//Return        : null
//-------------------------------------------------------------------------------------
function compareArrayCase(arr1, arr2, isUppercase){
    if(arr1.length == arr2.length){
        var flag = 0;
        var strFlag = isUppercase?"UpperCase":"LowerCase";
        for(i=0; i<arr1.length; i++){
            arr1[i] = isUppercase? arr1[i].toUpperCase():arr1[i].toLowerCase();
            if(arr1[i] == arr2[i]){
                flag += 0;
            }
            else{
                flag += 1;
                Log.Message("Keyword ["+arr1[i]+"] unable to convert to " + strFlag);
            }
        }
        if(flag > 0){
            Log.Error("Unable to convert all keywords to " + strFlag,null,pmNormal,null,Sys.Desktop);
        }
        else{
            Log.Message("Success to convert all keywords to " + strFlag);
        }
    }
    else{
        Log.Error("Occur Exception, the arrays have difference length.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : getNumString
//Author        : Alan.Yang
//Create Date   : May 29, 2015
//Last Modify   : 
//Description   : generating the number of specified strings
//Parameter     : [IN]strKey -- the specified string
//Parameter     : [IN]number -- need to generate string's number
//Return        : String
//-------------------------------------------------------------------------------------
function getNumString(strKey,number){
    if(number <= 0) return ""; 
    var Keys = "";
    for(i=0; i<number; i++){
        Keys += strKey;
    }
    return Keys;
}

//-------------------------------------------------------------------------------------
//Function Name : gotoAndExpandTree
//Author        : Alan.Yang
//Create Date   : June 9, 2015
//Last Modify   : 
//Description   : goto and expand the specified Tree path
//Parameter     : [IN]objTree -- the object Tree
//Parameter     : [IN]strPaths -- the path of tree，split by "-",such as 6-1-1
//Return        : Object, return last node in the specified tree path
//-------------------------------------------------------------------------------------
function gotoAndExpandTree(objTree, strPaths){
    
    strPaths = (arguments[1] == undefined || strPaths=="") ? 0 : strPaths;//deal with null and ""
    var objNode = objTree.wItems.Item(0);//root node
    var arrLevels = new Array();
    if(strPaths.indexOf("-")!= -1){
        arrLevels = strPaths.split("-");
        for(i=0; i<arrLevels.length; i++){
            arrLevels[i] = parseInt(arrLevels[i]);//transfer to integer
        }
    }
    else{
        arrLevels[0] = parseInt(strPaths);
    }
    var counter = 0;
    for(i=0; i<arrLevels.length; i++){
        var intPos = objTree.VScroll.Pos;
        objNode = (i == arrLevels.length-1) ? gotoGivenNode(objNode,arrLevels[i]-1,false,true) : gotoGivenNode(objNode,arrLevels[i]-1); 
        while(objTree.VScroll.Pos < intPos + 1){//whether under expanding or not
            Delay(1000);
            objTree.Refresh();
            if(i == arrLevels.length-1 || counter>20) break;//last node or timeout exit loop
            counter++;
        }
    }
    return objNode;
}

//-------------------------------------------------------------------------------------
//Function Name : gotoGivenNode
//Author        : Alan.Yang
//Create Date   : June 9, 2015
//Last Modify   : 
//Description   : goto and expand the specified node
//Parameter     : [IN]objNode -- the object Tree or Node
//Parameter     : [IN]level -- the level of node such as 6
//Parameter     : [IN]isFirstNode -- optional
//Parameter     : [IN]isLastNode -- optional
//Return        : Object, the specified node
//-------------------------------------------------------------------------------------
function gotoGivenNode(objNode, level, isFirstNode, isLastNode){
    isFirstNode = arguments[2] == undefined ? false : isFirstNode;
    isLastNode = arguments[3] == undefined ? false : isLastNode;
    try
    {
        if(isFirstNode) objNode = objNode.wItems.Item(0);
        if(objNode.Items != null && objNode.Items.Count>0){//when exists child node
            objNode = objNode.Items.Item(level);
        }
        else{
            Log.Error("Not exists any child nodes in Parent Node "+level +",stop finding.");
        }
        if(isLastNode){
            objNode.Click();//the last node needn't expanded.
            Log.Message("Select node:"+objNode.Text);
        }
        else{
            objNode.DblClick();
            Log.Message("Expanding node: "+objNode.Text);
        }
    }
    catch (e)
    {
        Log.Error(e.message);
    }
    return objNode;
}

//-------------------------------------------------------------------------------------
//Function Name : collapseGivenNode
//Author        : Alan.Yang
//Create Date   : June 10, 2015
//Last Modify   : 
//Description   : collapse the specified first level nodes in Tree
//Parameter     : [IN]objTree -- the object Tree
//Parameter     : [IN]index -- the index of node, it start at 1
//Return        : null
//-------------------------------------------------------------------------------------
function collapseGivenNode(objTree,index){
    var objNode = objTree.wItems.Item(0).Items.Item(index-1);
    objNode.DblClick();
    Log.Message("Collapse the Node:"+objNode.Text);
    objTree.Keys("[Home]");//retrun Root node, ensure that the wItemCount is correct.
    objTree.Refresh();
    Delay(1000);
}
function collapseAllNode(objTree){
    objTree.Keys("[Home]");
    objTree.Refresh();
    for (i=0; i<=objTree.wItemCount-1; i++){
        var objNode = objTree.wItems.Item(0).Items.Item(i);
        if(objNode.Expanded){
            objNode.DblClick();
            Log.Message("Collapse the Node: "+objNode.Text);
        }
        objTree.Keys("[Home]");
        objTree.Keys("[F5]");
        objTree.Refresh();
    }
}

//-------------------------------------------------------------------------------------
//Function Name : getDBVersion
//Author        : Alan.Yang
//Create Date   : June 11, 2015
//Last Modify   : 
//Description   : get the current DB version
//Return        : Int
//-------------------------------------------------------------------------------------
function getDBVersion(isDBExplorer){
    isDBExplorer = arguments[0] == undefined ? false:isDBExplorer;
    var objMain = Aliases.Sqlnavigator.frmMain;
    var objDBTree;
    var objNavBar = objMain.MiddleZone.frmUnifiedEditor.dpToolbox.NavBar;
    if(isDBExplorer){
        objDBTree = objNavBar.frmDbExplorer.vstDbNavigator;
    }
    else{
        objDBTree = objMain.MiddleZone.frmDBNavigator.pnlLeft.DBTree;
    }
    if(!objDBTree.Exists){
        if(isDBExplorer){
            objMain.Keys("^m");
            while(!frmDbExplorer.Exists || !frmDbExplorer.Visible){
                objNavBar.Keys("~^p");//Alt+Ctrl+P, switch toolbars
            }
        }
        else{
            objMain.Keys("[F12]");
        }
    }
    if(bObjExists(objDBTree,2)){
        var strRootName = objDBTree.wRootItem(0);
        if(isDBExplorer){
            var strVersion = trim(strRootName.split("(")[1]).substr(0,2);
        }
        else{
            var strVersion = trim(strRootName.split("(Oracle")[1]).substr(0,2);
        }
        if(strVersion != ""){
            Log.Message("The current Oracle Database's Version is "+strVersion);
            return parseInt(strVersion);
        }
        else{
            return -1;
        }
        if(!isDBExplorer) objMain.MiddleZone.frmDBNavigator.Close();
    }
    else{
        return -1;
    }
}

//-------------------------------------------------------------------------------------
//Function Name : closeMiddleZoneFrames
//Author        : Alan.Yang
//Create Date   : July 3, 2015
//Last Modify   : 
//Description   : close the all of frames in Middle Zone
//Return        : null
//-------------------------------------------------------------------------------------
function closeMiddleZoneFrames(){
    var objMiddleZone = Aliases.Sqlnavigator.frmMain.MiddleZone;
    if(objMiddleZone.Exists && objMiddleZone.ChildCount>0){
        Log.Message("Find "+objMiddleZone.ChildCount+" Frames in Middle Zone.");
        var PropArray = new Array("Name");
        var ValuesArray = new Array("VCLObject(\"frm*\")");
        var arrFrames = objMiddleZone.FindAllChildren(PropArray,ValuesArray,1);
        arrFrames = (new VBArray(arrFrames)).toArray();
        if(arrFrames.length >0){
            for(var i=0; i<arrFrames.length; i++){
                if(arrFrames[i].Name == "VCLObject(\"frmUnifiedEditor\")"){//Code Editor
                    closeCodeEditor();
                }
                else{
                    arrFrames[i].Close();
                }
            }
        }
    }
}

//-------------------------------------------------------------------------------------
//Function Name : getTestDebugInfo
//Author        : Micahel.luo
//Create Date   : Mar 18, 2014
//Last Modify   : 
//Description   : get the test environment and system info, application info for helping reproduce the bug.
//Parameter     : Null
//Return        : it will post all info message into log.
//-------------------------------------------------------------------------------------
function getTestDebugInfo()
{
    var sOSHostName, sOSFullName, sOSPlatform, sOSVersion, sOSBit, sOSUser;
    var sAppVersion, sAppFullPath, sOraClent, sLoginDB; 
    
    sOSHostName = Sys.HostName;
    Log.Message("OS Host Name: " + sOSHostName);
    
    sOSFullName = Sys.OSInfo.FullName;
    Log.Message("OS Full Name: " + sOSFullName);
    
    sOSPlatform = Sys.OSInfo.Name;
    Log.Message("OS Platform: " + sOSPlatform);
    
    sOSVersion = Sys.OSInfo.Version;
    Log.Message("OS Version: " + sOSVersion);
    
    sOSUser = Sys.UserName;
    Log.Message("OS User: " + sOSUser);
    
    if (Sys.OSInfo.Windows64bit)
    {
        sOSBit = "64bit"; 
        Log.Message("OS Bit: " + sOSBit);        
    }
    else
    {
        sOSBit = "32bit";  
        Log.Message("OS Bit: " + sOSBit);  
    }
    
    sAppVersion = sGetiniOptionValue(gSettingPath, "Flag", "AppVersion");
    Log.Message("Application Version: " + sAppVersion);
    
    sAppFullPath = sGetiniOptionValue(gSettingPath, "Flag", "AppLocation");
    Log.Message("Application Full Path: " + sAppFullPath);
    
    sOraClent = sGetiniOptionValue(gSettingPath, "Flag", "OracleClient");
    Log.Message("Oracle Client: " + sOraClent); 
}