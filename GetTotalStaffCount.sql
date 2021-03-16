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
