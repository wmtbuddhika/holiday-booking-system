CREATE FUNCTION GetRemainingLeavesCount(EmpId INT) RETURNS INT
BEGIN
    DECLARE RemainingLeaveCount INT DEFAULT 0;
    SET RemainingLeaveCount = (SELECT lm.RemainingLeaveCount FROM LeaveMaster lm, JobMaster jm
        WHERE lm.JobMaster_Id = jm.JobMasterId AND jm.Employee_Id = EmpId AND jm.Status = 1);
    RETURN RemainingLeaveCount;
END;
