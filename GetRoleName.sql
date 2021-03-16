CREATE FUNCTION GetRoleName(EmpId INT) RETURNS VARCHAR(255)
BEGIN
    DECLARE RoleName VARCHAR(255) DEFAULT 0;
    SET RoleName = (SELECT r.Name FROM Role r, JobMaster jm
        WHERE r.RoleId = jm.Role_Id AND jm.Employee_Id = EmpId AND jm.Status = 1);
    RETURN RoleName;
END;
