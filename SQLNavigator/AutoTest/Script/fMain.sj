//USEUNIT fMSIInstaller
//USEUNIT fLogon
//USEUNIT Menu_File
//USEUNIT Menu_Edit
//USEUNIT Menu_Search
//USEUNIT Menu_View
//USEUNIT Menu_Session
//USEUNIT Menu_Object
//USEUNIT Menu_Tools

function main(){
    MSIInstaller();
    logon();
    traverseFileMenu();
    traverseEditMenu();
    traverseSearchMenu();
    traverseViewMenu();
    traverseSessionMenu();
    traverseObjectMenu();
    traverseToolsMenu();
    
}