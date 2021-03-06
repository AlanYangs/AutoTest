//-------------------------------------------------------------------------------------
//Function Name : copyTnsFileToOracleHome
//Author        : Alan.Yang
//Create Date   : May 14, 2015
//Last Modify   : 
//Description   : copy TNS files to oracle home path
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function copyTnsFileToOracleHome(){
    var strOracleHomePath,strDestinationPath;
    var strSourceTNSPath =  aqFileSystem.IncludeTrailingBackSlash(Project.Path) + "AutoFiles\\TNS\\tnsnames.ora";
    var strSourceLDAPPath = aqFileSystem.IncludeTrailingBackSlash(Project.Path) + "AutoFiles\\TNS\\LDAP.ora";
    var strSourceNetPath = aqFileSystem.IncludeTrailingBackSlash(Project.Path) + "AutoFiles\\TNS\\sqlnet.ora";

    //reading registry
    var intBit = Sys.OSInfo.Windows64bit ? 1 : 0; //if 64bit then intBit = 1 else 0
    var keys = Storages.Registry("SOFTWARE\\ORACLE",HKEY_LOCAL_MACHINE,intBit);

    if(keys != null){
        for(i=0; i<keys.SectionCount; i++)
        {
            var SectionName = keys.GetSectionName(i);
            if(SectionName.toLowerCase().indexOf("home")>0 || SectionName.toLowerCase().indexOf("sysman")>0){
                //child nodes
                var subKeys = Storages.Registry("SOFTWARE\\ORACLE\\" + SectionName , HKEY_LOCAL_MACHINE , intBit);
                if(subKeys != null){
                    if(subKeys.OptionExists("ORACLE_HOME")){
                        strOracleHomePath = subKeys.GetOption("ORACLE_HOME","Null");
                        if(aqFile.Exists(strOracleHomePath)){ // whether the oracle home path is valid or not
                            Log.Message("Find valid Oracle Home, the Path : " + strOracleHomePath);
                            strDestinationPath = aqFileSystem.IncludeTrailingBackSlash(strOracleHomePath) + "network\\admin";
                            if(aqFile.Exists(strDestinationPath)){
                                //copy all .ora files
                                if(aqFile.Copy(strSourceTNSPath,strDestinationPath,false) && aqFile.Copy(strSourceLDAPPath,strDestinationPath,false) && aqFile.Copy(strSourceNetPath,strDestinationPath,false)){
                                    Log.Message("Copy all ora files to oracle home: " + strDestinationPath);  
                                }
                                else{
                                    Log.Error("Fail to copy ora files to " + strDestinationPath);
                                    return;
                                }
                            }
                            else{// config oracle install client 
                                Log.Message(strDestinationPath + " doesn't exist, it maybe oracle Instant client.");
                                strDestinationPath = "C:\\TNS_Admin";
                                if(!aqFile.Exists(strDestinationPath)){
                                    aqFileSystem.CreateFolder(strDestinationPath);
                                    Log.Message("Have created folder: " + strDestinationPath);
                                }
                                if(aqFile.Copy(strSourceTNSPath,strDestinationPath,false) && aqFile.Copy(strSourceLDAPPath,strDestinationPath,false) && aqFile.Copy(strSourceNetPath,strDestinationPath,false)){
                                    Log.Message("Copy all ora files to path: " + strDestinationPath); 
                                    //setting Environment Variable
                                    var WshShell = new ActiveXObject("Wscript.Shell"); 
                                    WshShell.Environment("user").Item("TNS_ADMIN") = sDestinationPath;
                                    Log.Message("set [TNS_ADMIN] Environment Variable value to " + sDestinationPath);
                                }
                                else{
                                    Log.Error("Fail to copy ora files to " + strDestinationPath);
                                    return;
                                }
                            }
                              
                        }
                    }
                }
            }
        }
    }
    else{
        Log.Error("Don't find any oracle node in registry, please check whether oracle has been installed or not.");
        return;
    }
}