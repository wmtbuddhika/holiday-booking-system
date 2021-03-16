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
