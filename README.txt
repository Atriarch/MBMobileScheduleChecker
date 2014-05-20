Nathan McGaughy
May 19, 2014


MINDBODY Project: Mobile Schedule Checker (Objective C)


This application is designed to request XML data from the MINDBODY web service API, parse the XML data into into key/object dictionaries, and use the dictionaries in order to display selected data to the user. As was requested, the data being displayed is that of the staff members that can be observed from my given account, and their individual schedules.


The first step I took in completing this project was coming up with a way in which to request data from the server. To that end, the first file I created was the SoapDataSource which houses both the GetStaff and GetStaffAppointment requests. These requests were sent to the DownloadData file which, upon a successful download, delegates the new data back to the SoapDataSource where it is then passed to the SoapParse file in order to have the XML formatted data converted into NSDictionaries. From here, depending upon which ViewController requested the data, either the StaffScheduleDataSource or the StaffDataSource will be initialized and passed the Dictionaries.  


StaffListViewController:
This file is called upon by the AppDelegate to display the UITableView which will hold the Staff. 


StaffScheduleViewController:
This file is called upon by the StaffListViewController when a staff row is selected. It displays the StaffSchedule.


SoapDataSource:
This file is called upon by the StaffListViewController file and the StaffScheduleViewController when data needs to be pulled from the API. 


DownloadData:
The DownloadData file manages the XML requests and replies. Upon successfully downloading the required XML data, the new XML data is delegated back to the SoapDataSource. 


SoapParse:
The SoapParse file takes the XML data from the SoapDataSource file and converts it into a NSDictionary. 


StaffDataSource:
Holds the NSDictionary of the staff.


Staff:
Holds a single NSDictionary object.


StaffScheduleDataSource:
Holds the NSDictionary of the StaffSchedule.


StaffSchedule:
Holds a single NSDictionay object.