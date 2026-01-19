/* =========================================================
    (business rules not expressible by constraints)
   ========================================================= */

/* Max 3 classes per Program Manager */
CREATE OR REPLACE FUNCTION enforce_max_three_classes()
RETURNS TRIGGER AS $$
BEGIN
  IF (
    SELECT COUNT(*)
    FROM program_manager_management
    WHERE staff_contract_id = NEW.staff_contract_id
  ) >= 3 THEN
    RAISE EXCEPTION
      'A Program Manager may manage at most 3 classes';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/* Only PROGRAM_MANAGER contracts may manage classes */
CREATE OR REPLACE FUNCTION enforce_pm_role()
RETURNS TRIGGER AS $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM staff_contract
    WHERE staff_contract_id = NEW.staff_contract_id
      AND role = 'PROGRAM_MANAGER'
  ) THEN
    RAISE EXCEPTION
      'Staff contract is not a PROGRAM_MANAGER role';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/* ensure a Program Manager assignment only happens within the contract period*/
CREATE OR REPLACE FUNCTION enforce_pm_within_contract_period()
RETURNS TRIGGER AS $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM staff_contract
    WHERE staff_contract_id = NEW.staff_contract_id
      AND start_date <= CURRENT_DATE
      AND end_date >= CURRENT_DATE
  ) THEN
    RAISE EXCEPTION
      'Program Manager assignment must fall within contract period';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
