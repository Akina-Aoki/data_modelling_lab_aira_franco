-- Only contains CREATE TRIGGER statements

CREATE TRIGGER trg_max_three_classes
BEFORE INSERT ON program_manager_management
FOR EACH ROW
EXECUTE FUNCTION enforce_max_three_classes();

CREATE TRIGGER trg_enforce_pm_role
BEFORE INSERT ON program_manager_management
FOR EACH ROW
EXECUTE FUNCTION enforce_pm_role();

