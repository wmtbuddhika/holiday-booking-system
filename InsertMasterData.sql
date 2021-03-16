INSERT INTO `LeaveManagement`.`Department` (`Name`, `Status`) VALUES ('Engineering', '1');
INSERT INTO `LeaveManagement`.`Department` (`Name`, `Status`) VALUES ('Plumbing', '1');
INSERT INTO `LeaveManagement`.`Department` (`Name`, `Status`) VALUES ('Roofing', '1');
INSERT INTO `LeaveManagement`.`Department` (`Name`, `Status`) VALUES ('Carpentry', '1');
INSERT INTO `LeaveManagement`.`Department` (`Name`, `Status`) VALUES ('Bricklaying', '1');
INSERT INTO `LeaveManagement`.`Department` (`Name`, `Status`) VALUES ('Office', '1');

INSERT INTO `LeaveManagement`.`Role` (`Name`, `Status`) VALUES ('Admin', '1');
INSERT INTO `LeaveManagement`.`Role` (`Name`, `Status`) VALUES ('Head', '1');
INSERT INTO `LeaveManagement`.`Role` (`Name`, `Status`) VALUES ('Deputy Head', '1');
INSERT INTO `LeaveManagement`.`Role` (`Name`, `Status`) VALUES ('Manager', '1');
INSERT INTO `LeaveManagement`.`Role` (`Name`, `Status`) VALUES ('Apprentice', '1');
INSERT INTO `LeaveManagement`.`Role` (`Name`, `Status`) VALUES ('Junior member', '1');
INSERT INTO `LeaveManagement`.`Role` (`Name`, `Status`) VALUES ('Senior member', '1');

INSERT INTO `LeaveManagement`.`Employee` (`Name`, `JoinedDate`) VALUES ('Admin', '2020-01-01');
INSERT INTO `LeaveManagement`.`Employee` (`Name`, `JoinedDate`) VALUES ('Head', '2020-01-01');
INSERT INTO `LeaveManagement`.`Employee` (`Name`, `JoinedDate`) VALUES ('Deputy Head', '2020-01-01');
INSERT INTO `LeaveManagement`.`Employee` (`Name`, `JoinedDate`) VALUES ('Manager', '2020-01-01');
INSERT INTO `LeaveManagement`.`Employee` (`Name`, `JoinedDate`) VALUES ('Apprentice', '2020-01-01');
INSERT INTO `LeaveManagement`.`Employee` (`Name`, `JoinedDate`) VALUES ('Junior member', '2020-01-01');
INSERT INTO `LeaveManagement`.`Employee` (`Name`, `JoinedDate`) VALUES ('Senior member', '2020-01-01');

INSERT INTO `LeaveManagement`.`JobMaster` (`Status`, `CreatedDate`, `Role_Id`, `Employee_Id`, `Department_Id`) VALUES ('1', '2020-01-01', '1', '1', '1');
INSERT INTO `LeaveManagement`.`JobMaster` (`Status`, `CreatedDate`, `Role_Id`, `Employee_Id`, `Department_Id`) VALUES ('2', '2020-01-01', '1', '2', '1');
INSERT INTO `LeaveManagement`.`JobMaster` (`Status`, `CreatedDate`, `Role_Id`, `Employee_Id`, `Department_Id`) VALUES ('3', '2020-01-01', '1', '3', '1');
INSERT INTO `LeaveManagement`.`JobMaster` (`Status`, `CreatedDate`, `Role_Id`, `Employee_Id`, `Department_Id`) VALUES ('4', '2020-01-01', '1', '4', '1');
INSERT INTO `LeaveManagement`.`JobMaster` (`Status`, `CreatedDate`, `Role_Id`, `Employee_Id`, `Department_Id`) VALUES ('5', '2020-01-01', '1', '5', '1');
INSERT INTO `LeaveManagement`.`JobMaster` (`Status`, `CreatedDate`, `Role_Id`, `Employee_Id`, `Department_Id`) VALUES ('6', '2020-01-01', '1', '6', '1');
INSERT INTO `LeaveManagement`.`JobMaster` (`Status`, `CreatedDate`, `Role_Id`, `Employee_Id`, `Department_Id`) VALUES ('7', '2020-01-01', '1', '7', '1');

INSERT INTO `LeaveManagement`.`LeaveMaster` (`TotalLeaveCount`, `TakenLeaveCount`, `RemainingLeaveCount`, `JobMaster_Id`) VALUES ('10', '3', '7', '1');

INSERT INTO `LeaveManagement`.`LeaveRequest` (`NoOfLeaveDays`, `LeaveStartDate`, `LeaveEndDate`, `Status`, `TimePeriod_Id`, `CoverupEmployee_Id`, `AuthorizedEmployee_Id`, `LeaveMaster_Id`) VALUES ('1', '2020-01-10', '2020-01-11', '1', '1', '2', '1', '1');

INSERT INTO `LeaveManagement`.`Login` (`UserName`, `Password`, `Type`, `Status`, `CreatedDate`, `Employee_Id`) VALUES ('admin', 'admin', '0', '1', '2020-01-01', '1');
