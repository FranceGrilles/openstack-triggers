USE neutron;

CREATE TABLE `floatingip_actions` (
  `id` INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `ip_address` VARCHAR(64),
  `device_id` VARCHAR(255),
  `action` VARCHAR(255),
  `start_date` DATETIME ) ENGINE = InnoDB;

DELIMITER $$
CREATE TRIGGER floatingip_create
  AFTER INSERT ON floatingips
  FOR EACH ROW BEGIN
  INSERT INTO floatingip_actions
  SET ip_address=NEW.floating_ip_address,
  device_id=(SELECT device_id FROM ports WHERE ports.id=NEW.fixed_port_id),
  action='create',
  start_date=NOW();
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER floatingip_delete
  AFTER DELETE ON floatingips
  FOR EACH ROW BEGIN
  INSERT INTO floatingip_actions
  SET ip_address=OLD.floating_ip_address,
  device_id=(SELECT device_id FROM ports WHERE ports.id=OLD.fixed_port_id),
  action='delete',
  start_date=NOW();
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER floatingip_association AFTER UPDATE ON floatingips
FOR EACH ROW
BEGIN
  IF (OLD.fixed_port_id IS NOT NULL AND NEW.fixed_port_id IS NULL) THEN
      INSERT INTO floatingip_actions
      SET ip_address=NEW.floating_ip_address,
      device_id=(SELECT device_id FROM ports WHERE ports.id=OLD.fixed_port_id),
      action='disassociate',
      start_date=NOW();
  ELSEIF (OLD.fixed_port_id IS NULL AND NEW.fixed_port_id IS NOT NULL) THEN
      INSERT INTO floatingip_actions
      SET ip_address=NEW.floating_ip_address,
      device_id=(SELECT device_id FROM ports WHERE ports.id=NEW.fixed_port_id),
      action='associate',
      start_date=NOW();
  END IF;
END$$
DELIMITER ;

