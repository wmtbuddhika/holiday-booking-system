CREATE FUNCTION GetRoleName(EmpId INT) RETURNS VARCHAR(255)
BEGIN
    DECLARE RoleName VARCHAR(255) DEFAULT 0;
    SET RoleName = (SELECT r.Name FROM Role r, JobMaster jm
        WHERE r.RoleId = jm.Role_Id AND jm.Employee_Id = EmpId AND jm.Status = 1);
    RETURN RoleName;
END;

CREATE FUNCTION GetRemainingLeavesCount(EmpId INT) RETURNS INT
BEGIN
    DECLARE RemainingLeaveCount INT DEFAULT 0;
    SET RemainingLeaveCount = (SELECT lm.RemainingLeaveCount FROM LeaveMaster lm, JobMaster jm
        WHERE lm.JobMaster_Id = jm.JobMasterId AND jm.Employee_Id = EmpId AND jm.Status = 1);
    RETURN RemainingLeaveCount;
END;


CREATE FUNCTION GetLeaveStaffCount(EmpId INT, StartDate VARCHAR(255), RoleName VARCHAR(255)) RETURNS INT
BEGIN
    DECLARE DepartmentId INT DEFAULT 0;
    DECLARE StaffCount INT DEFAULT 0;

    SET DepartmentId = (SELECT jm.Department_Id FROM JobMaster jm WHERE Employee_Id = EmpId);

    SET StaffCount = (SELECT COUNT(*) FROM LeaveRequest lr, LeaveMaster lm, JobMaster jm, Role r WHERE lm.LeaveMasterId = lr.LeaveMaster_Id
            AND jm.Role_Id = r.RoleId AND lm.JobMaster_Id = jm.JobMasterId AND lr.Status = 1 AND lr.LeaveEndDate >= StartDate
            AND jm.Department_Id = DepartmentId AND IF(RoleName = "", TRUE, r.Name = RoleName) AND jm.Status = 1
    );

    RETURN StaffCount;
END;

CREATE FUNCTION GetTotalStaffCount(EmpId INT, RoleName VARCHAR(255)) RETURNS INT
BEGIN
    DECLARE DepartmentId INT DEFAULT 0;
    DECLARE StaffCount INT DEFAULT 0;

    SET DepartmentId = (SELECT jm.Department_Id FROM JobMaster jm WHERE Employee_Id = EmpId AND jm.Status = 1);

    SET StaffCount = (SELECT COUNT(*) FROM JobMaster jm, Role r WHERE jm.Role_Id = r.RoleId
                                                                  AND jm.Department_Id = DepartmentId AND IF(RoleName = "", TRUE, r.Name = RoleName)
    );

    RETURN StaffCount;
END;

CREATE PROCEDURE SaveLeaveRequest(leaveDays INT, startDate DATETIME, endDate DATETIME,
    leaveStatus INT, timePeriodId INT, leaveMasterId INT, validations TEXT)
BEGIN
    DECLARE LeaveRequestId INT DEFAULT NULL;
    DECLARE Validation1 VARCHAR(255) DEFAULT '';
    DECLARE Validation2 VARCHAR(255) DEFAULT '';
    DECLARE Validation3 VARCHAR(255) DEFAULT '';
    DECLARE Validation4 VARCHAR(255) DEFAULT '';
    DECLARE Validation5 VARCHAR(255) DEFAULT '';
    DECLARE Validation6 VARCHAR(255) DEFAULT '';

    IF validations != '' THEN
        SELECT substring_index(validations, ',', 1) INTO Validation1;
        SELECT substring_index(substring_index(validations, ',', 2), ',', -1) INTO Validation2;
        SELECT substring_index(substring_index(validations, ',', 3), ',', -1) INTO Validation3;
        SELECT substring_index(substring_index(validations, ',', 4), ',', -1) INTO Validation4;
        SELECT substring_index(substring_index(validations, ',', 5), ',', -1) INTO Validation5;
        SELECT substring_index(substring_index(validations, ',', 6), ',', -1) INTO Validation6;
    END IF;

    INSERT INTO LeaveRequest (NoOfLeaveDays, LeaveStartDate, LeaveEndDate, Status, TimePeriod_Id, LeaveMaster_Id)
        VALUES (leaveDays, startDate, endDate, leaveStatus, timePeriodId, leaveMasterId);

    SELECT LAST_INSERT_ID() INTO LeaveRequestId;

    IF Validation1 != '' THEN
        INSERT INTO LeaveRequestConstrains(LeaveRequest_Id, Constrain) VALUES (LeaveRequestId, Validation1);
    END IF;
    IF Validation2 != '' THEN
        INSERT INTO LeaveRequestConstrains(LeaveRequest_Id, Constrain) VALUES (LeaveRequestId, Validation2);
    END IF;
    IF Validation3 != '' THEN
        INSERT INTO LeaveRequestConstrains(LeaveRequest_Id, Constrain) VALUES (LeaveRequestId, Validation3);
    END IF;
    IF Validation4 != '' THEN
        INSERT INTO LeaveRequestConstrains(LeaveRequest_Id, Constrain) VALUES (LeaveRequestId, Validation4);
    END IF;
    IF Validation5 != '' THEN
        INSERT INTO LeaveRequestConstrains(LeaveRequest_Id, Constrain) VALUES (LeaveRequestId, Validation5);
    END IF;
    IF Validation6 != '' THEN
        INSERT INTO LeaveRequestConstrains(LeaveRequest_Id, Constrain) VALUES (LeaveRequestId, Validation6);
    END IF;
END;

DROP PROCEDURE SaveLeaveRequest;
select GetLeaveStaffCount(2, '2020-01-10', 'Head') StaffCount;
select GetRoleName(2) roleName;

SELECT GetTotalStaffCount(1,'Deputy Head') staffCount;


SET GLOBAL log_bin_trust_function_creators = 1;

SELECT *
FROM LeaveRequestConstrains;

-- TODO: update ERD : LeaveRequestConstrains
-- TODO: update ERD : NULL values
-- TODO: update ERD : request reason
