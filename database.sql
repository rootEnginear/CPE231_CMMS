-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.5.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for cpe231-cmms
CREATE DATABASE IF NOT EXISTS `cpe231-cmms` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `cpe231-cmms`;

-- Dumping structure for table cpe231-cmms.departments
CREATE TABLE IF NOT EXISTS `departments` (
  `dep_id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.departments: ~1 rows (approximately)
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` (`dep_id`, `dep_name`) VALUES
	(1, 'Engineering'),
	(2, 'IT');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.employees
CREATE TABLE IF NOT EXISTS `employees` (
  `emp_id` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `emp_firstname` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emp_lastname` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emp_tel` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emp_email` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emp_department` int(11) DEFAULT NULL,
  `emp_password` char(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emp_rank` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'member',
  PRIMARY KEY (`emp_id`),
  KEY `emp_department` (`emp_department`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`emp_department`) REFERENCES `position_departments` (`pdep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.employees: ~14 rows (approximately)
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` (`emp_id`, `emp_firstname`, `emp_lastname`, `emp_tel`, `emp_email`, `emp_department`, `emp_password`, `emp_rank`) VALUES
	('admin', 'Admin', 'Admin', '0875364129', 'admin@cmms.com', 2, '5a38afb1a18d408e6cd367f9db91e2ab9bce834cdad3da24183cc174956c20ce35dd39c2bd36aae907111ae3d6ada353f7697a5f1a8fc567aae9e4ca41a9d19d', 'admin'),
	('emp00', 'John', 'Doe', '0812345679', 'reb@deztuzbu.vi', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp01', 'Etta', 'Griffith', '0882088488', 'ikeik@tik.cg', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp02', 'Mathilda', 'Cross', '0852079928', 'vicetlu@hozgede.mz', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp03', 'Jim', 'Armstrong', '0884753292', 'gakcunam@pedruk.sv', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp04', 'Luke', 'Maxwell', '0823301374', 'san@jutur.ac', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp05', 'Jorge', 'Riley', '0886039029', 'gatvoc@hiati.gm', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp06', 'Mitchell', 'Hubbard', '0814574567', 'wu@nuwit.ls', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp07', 'Maria', 'Mitchell', '0824870296', 'mehte@seluhesa.es', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp08', 'Billy', 'Waters', '0826074265', 'codsi@zop.za', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp09', 'Steve', 'Herrera', '0832261066', 'jil@mucvucu.sx', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp10', 'Chester', 'Reeves', '0864062862', 'tah@bugadfe.ac', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp11', 'Josephine', 'Evans', '0841582774', 'allorzu@gib.io', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member'),
	('emp12', 'Max', 'Gardner', '0822934102', 'jifgi@upe.yt', 1, '48c8947f69c054a5caa934674ce8881d02bb18fb59d5a63eeaddff735b0e9801e87294783281ae49fc8287a0fd86779b27d7972d3e84f0fa0d826d7cb67dfefc', 'member');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.location
CREATE TABLE IF NOT EXISTS `location` (
  `loc_id` int(11) NOT NULL AUTO_INCREMENT,
  `loc_room` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loc_floor` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loc_building` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`loc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.location: ~4 rows (approximately)
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` (`loc_id`, `loc_room`, `loc_floor`, `loc_building`) VALUES
	(1, '1', '1', 'อาคาร 1'),
	(2, '1', '1', 'อาคาร 2'),
	(3, '1', '1', 'อาคาร 3'),
	(4, '1', '1', 'อาคาร 4'),
	(5, '1', '1', 'อาคาร 5');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.machines
CREATE TABLE IF NOT EXISTS `machines` (
  `mac_id` int(11) NOT NULL,
  `mac_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac_category` int(11) DEFAULT NULL,
  `mac_location` int(11) DEFAULT NULL,
  `mac_date_required` bigint(20) DEFAULT NULL,
  `mac_date_recieved` bigint(20) DEFAULT NULL,
  `mac_details` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac_price` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`mac_id`),
  KEY `mac_category` (`mac_category`),
  KEY `mac_location` (`mac_location`),
  CONSTRAINT `machines_ibfk_1` FOREIGN KEY (`mac_category`) REFERENCES `machine_categories` (`mcat_id`),
  CONSTRAINT `machines_ibfk_2` FOREIGN KEY (`mac_location`) REFERENCES `location` (`loc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.machines: ~9 rows (approximately)
/*!40000 ALTER TABLE `machines` DISABLE KEYS */;
INSERT INTO `machines` (`mac_id`, `mac_name`, `mac_category`, `mac_location`, `mac_date_required`, `mac_date_recieved`, `mac_details`, `mac_price`) VALUES
	(1, 'WaterCleanser 74KU', 1, 1, 1531242000000, 1563296400000, 'ล้างท่อน้ำที่อุดตัน', 10000000),
	(2, 'Acholic F78', 2, 2, 1531587600000, 1563555600000, 'ตั้งรูปชิ้นงานตามค่าที่ตั้ง', 10000000),
	(3, 'Themomanone 785E', 3, 1, 1531846800000, 1563901200000, 'ปรับอุณหภูมิของชิ้นงานตามค่าที่ตั้ง', 10000000),
	(4, 'Separatical S-253', 4, 2, 1535562000000, 1568480400000, 'แยกวัตถุดิบที่เราต้องการ', 10000000),
	(5, 'Separatical Special-2', 4, 5, 1537376400000, 1569258000000, 'บดยางและผสมยางเพื่อนำไปใช้ต่อ', 10000000),
	(6, 'Dyjester E-521', 5, 3, 1537808400000, 1569776400000, 'ย่อยวัตถุดิบต่าง ๆ', 10000000),
	(7, 'Dyjester M-223', 5, 3, 1540832400000, 1570467600000, 'ผสมวัตถุตามค่าที่ตั้งไว้', 10000000),
	(8, 'Coolizer EJ985', 6, 5, 1543597200000, 1573664400000, 'เครื่องทำความเย็นกับชิ้นงาน', 10000000),
	(9, 'Hotlizer EH145', 7, 4, 1544806800000, 1577206800000, 'อบชิ้นงานให้แห้ง', 10000000);
/*!40000 ALTER TABLE `machines` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.machine_categories
CREATE TABLE IF NOT EXISTS `machine_categories` (
  `mcat_id` int(11) NOT NULL AUTO_INCREMENT,
  `mcat_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mcat_details` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`mcat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.machine_categories: ~7 rows (approximately)
/*!40000 ALTER TABLE `machine_categories` DISABLE KEYS */;
INSERT INTO `machine_categories` (`mcat_id`, `mcat_name`, `mcat_details`) VALUES
	(1, 'เครื่องล้างท่อน้ำเสีย', NULL),
	(2, 'เครื่องตั้งรูป', NULL),
	(3, 'เครื่องปรับอุณหภูมิ', NULL),
	(4, 'เครื่องแยกวัตถุดิบ', NULL),
	(5, 'เครื่องย่อยวัตถุดิบ', NULL),
	(6, 'เครื่องหล่อเย็น', NULL),
	(7, 'เครื่องอบแห้ง', NULL);
/*!40000 ALTER TABLE `machine_categories` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.machine_parts
CREATE TABLE IF NOT EXISTS `machine_parts` (
  `mac_id` int(11) NOT NULL,
  `part_id` int(11) NOT NULL,
  PRIMARY KEY (`mac_id`,`part_id`),
  KEY `part_id` (`part_id`),
  CONSTRAINT `machine_parts_ibfk_1` FOREIGN KEY (`mac_id`) REFERENCES `machines` (`mac_id`),
  CONSTRAINT `machine_parts_ibfk_2` FOREIGN KEY (`part_id`) REFERENCES `parts` (`part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.machine_parts: ~5 rows (approximately)
/*!40000 ALTER TABLE `machine_parts` DISABLE KEYS */;
INSERT INTO `machine_parts` (`mac_id`, `part_id`) VALUES
	(1, 200),
	(1, 201),
	(4, 100),
	(4, 101),
	(4, 120);
/*!40000 ALTER TABLE `machine_parts` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.parts
CREATE TABLE IF NOT EXISTS `parts` (
  `part_id` int(11) NOT NULL,
  `part_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `part_category` int(11) DEFAULT NULL,
  `part_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`part_id`),
  KEY `part_category` (`part_category`),
  CONSTRAINT `parts_ibfk_1` FOREIGN KEY (`part_category`) REFERENCES `part_categories` (`pcat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.parts: ~10 rows (approximately)
/*!40000 ALTER TABLE `parts` DISABLE KEYS */;
INSERT INTO `parts` (`part_id`, `part_name`, `part_category`, `part_quantity`) VALUES
	(100, 'เทปพันสายไฟ', 1, 50),
	(101, 'เทปพัันเกลียว', 2, 50),
	(120, 'น็อตหกเหลี่ยม', 3, 10),
	(122, 'น็อตเชื่อม', 3, 10),
	(131, 'กาวร้อนแท่ง', 4, 50),
	(200, 'ไส้กรองน้ำมันเครื่อง', 3, 10),
	(201, 'ไส้กรองน้ำมัน', 3, 20),
	(213, 'เชือกไนล่อน', 4, 10),
	(234, 'กาวสำหรับเอกสาร', 4, 20),
	(244, 'ใยฝ้ายสั่งเคราะห์', 4, 50);
/*!40000 ALTER TABLE `parts` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.part_categories
CREATE TABLE IF NOT EXISTS `part_categories` (
  `pcat_id` int(11) NOT NULL AUTO_INCREMENT,
  `pcat_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pcat_details` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pcat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.part_categories: ~4 rows (approximately)
/*!40000 ALTER TABLE `part_categories` DISABLE KEYS */;
INSERT INTO `part_categories` (`pcat_id`, `pcat_name`, `pcat_details`) VALUES
	(1, 'ไฟฟ้า', NULL),
	(2, 'ประปา', NULL),
	(3, 'เครื่องจักร', NULL),
	(4, 'เบ็ดเตล็ด', NULL);
/*!40000 ALTER TABLE `part_categories` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.part_invoices
CREATE TABLE IF NOT EXISTS `part_invoices` (
  `pinv_id` int(11) NOT NULL,
  `pinv_datetime` bigint(20) DEFAULT NULL,
  `pinv_details` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pinv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.part_invoices: ~0 rows (approximately)
/*!40000 ALTER TABLE `part_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_invoices` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.part_invoice_list
CREATE TABLE IF NOT EXISTS `part_invoice_list` (
  `part_id` int(11) NOT NULL,
  `pinv_id` int(11) NOT NULL,
  `pils_quantity` int(11) DEFAULT NULL,
  `pils_price` decimal(10,0) DEFAULT NULL,
  `pils_status` enum('รออนุมัติ','รออะไหล่','ได้รับแล้ว','ไม่อนุมัติ') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`part_id`,`pinv_id`),
  KEY `pinv_id` (`pinv_id`),
  CONSTRAINT `part_invoice_list_ibfk_1` FOREIGN KEY (`pinv_id`) REFERENCES `part_invoices` (`pinv_id`),
  CONSTRAINT `part_invoice_list_ibfk_2` FOREIGN KEY (`part_id`) REFERENCES `parts` (`part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.part_invoice_list: ~0 rows (approximately)
/*!40000 ALTER TABLE `part_invoice_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_invoice_list` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.part_requirements
CREATE TABLE IF NOT EXISTS `part_requirements` (
  `task_id` int(11) DEFAULT NULL,
  `preq_id` int(11) NOT NULL,
  `preq_notes` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preq_datetime` bigint(20) DEFAULT NULL,
  `preq_status` enum('รออนุมัติ','อนุมัติแล้ว','ได้รับแล้ว','ไม่อนุมัติ') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`preq_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `FK_part_requirements_tasks` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.part_requirements: ~0 rows (approximately)
/*!40000 ALTER TABLE `part_requirements` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_requirements` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.part_requirement_list
CREATE TABLE IF NOT EXISTS `part_requirement_list` (
  `preq_id` int(11) NOT NULL,
  `part_id` int(11) NOT NULL,
  `preq_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`preq_id`,`part_id`),
  KEY `part_id` (`part_id`),
  CONSTRAINT `part_requirement_list_ibfk_1` FOREIGN KEY (`part_id`) REFERENCES `parts` (`part_id`),
  CONSTRAINT `part_requirement_list_ibfk_2` FOREIGN KEY (`preq_id`) REFERENCES `part_requirements` (`preq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.part_requirement_list: ~0 rows (approximately)
/*!40000 ALTER TABLE `part_requirement_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_requirement_list` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.positions
CREATE TABLE IF NOT EXISTS `positions` (
  `pos_id` int(11) NOT NULL,
  `pos_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.positions: ~0 rows (approximately)
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` (`pos_id`, `pos_name`) VALUES
	(1, 'ช่าง'),
	(2, 'ผู้ดูแลระบบ');
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.position_departments
CREATE TABLE IF NOT EXISTS `position_departments` (
  `pdep_id` int(11) NOT NULL,
  `pos_id` int(11) DEFAULT NULL,
  `dep_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`pdep_id`),
  KEY `dep_id` (`dep_id`),
  KEY `pos_id` (`pos_id`),
  CONSTRAINT `position_departments_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `departments` (`dep_id`),
  CONSTRAINT `position_departments_ibfk_2` FOREIGN KEY (`pos_id`) REFERENCES `positions` (`pos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.position_departments: ~0 rows (approximately)
/*!40000 ALTER TABLE `position_departments` DISABLE KEYS */;
INSERT INTO `position_departments` (`pdep_id`, `pos_id`, `dep_id`) VALUES
	(1, 1, 1),
	(2, 1, 2);
/*!40000 ALTER TABLE `position_departments` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.tasks
CREATE TABLE IF NOT EXISTS `tasks` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_id_reporter` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac_id` int(11) DEFAULT NULL,
  `task_details` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_finished` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`task_id`),
  KEY `mac_id` (`mac_id`),
  KEY `emp_id_reporter` (`emp_id_reporter`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`mac_id`) REFERENCES `machines` (`mac_id`) ON UPDATE CASCADE,
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`emp_id_reporter`) REFERENCES `employees` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.tasks: ~24 rows (approximately)
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`task_id`, `emp_id_reporter`, `mac_id`, `task_details`, `task_finished`) VALUES
	(1, 'emp11', 7, 'court tip garage wide shells real thought soil solve my wild shoe pony act closer farm service ocean spring reason success port completely hundred', 1),
	(2, 'emp07', 1, 'stared industrial union finest buy wall among please vote drive upon discover future structure shut movement bet recognize longer skill choose badly two case', 1),
	(3, 'emp06', 5, 'explain scale result atomic same wheat rising spring won cup gravity write smaller familiar closer palace seems function instrument dog consist grain acres idea', 1),
	(4, 'emp03', 1, 'park day cabin sick shorter stand scared rhythm clean peace hearing laugh sink atom consider go numeral theory nails furniture habit look mark getting', 1),
	(5, 'emp01', 8, 'bell band farm further course balloon point flower far box store chance feathers hunter region sudden stems newspaper properly under window shelf pay building', 1),
	(6, 'emp05', 9, 'grabbed map dish nest actually horn citizen within shoulder gently guess want elephant those rate instant battle burn sport wife station stand tea eventually', 1),
	(7, 'emp06', 5, 'suit mathematics baby wall talk these halfway roll began excellent paint sand contrast fought tone swept them garden entire method form palace whistle round', 1),
	(8, 'emp07', 9, 'layers cake chose sudden because minute member collect natural final mathematics best lungs case kids hill rest watch giant nobody sight wise high action', 1),
	(9, 'emp01', 1, 'lying congress children corner show within well elephant watch nuts middle equal drink tape mad slabs blew bare involved across motion major dirty obtain', 0),
	(10, 'emp04', 7, 'law tell expression sea fish cap hollow help supply nuts company copy into pattern individual everywhere bottom topic naturally lesson roar bat asleep attached', 1),
	(11, 'emp00', 8, 'entire arrangement bent twelve show push weather track feed had does carry trick fresh nuts definition order ahead donkey fill felt environment exercise herself', 1),
	(12, 'emp12', 4, 'list early flew listen throw idea disappear as very tea contrast cheese appearance available mill even anyway silver buried unhappy parallel library than board', 1),
	(13, 'emp02', 7, 'establish primitive modern score through jar book nice warn arrive as jungle mean bring bear border exact me judge elephant force till poetry combination', 1),
	(14, 'emp00', 3, 'solve board knew lucky had powerful warm held beautiful progress concerned typical tone handle move model satisfied former widely diameter to wise excellent exactly', 1),
	(15, 'emp01', 3, 'welcome actual base eleven local finally religious fresh riding luck yourself anyway fuel lot along discovery laid whose captured process written organization tool rich', 1),
	(16, 'emp05', 2, 'without white entirely pay soldier since slightly slept mean said asleep minerals jungle breakfast enter sat pound manner aboard setting fallen lovely rocky rice', 1),
	(17, 'emp02', 5, 'division gun tiny include jet struggle closer trunk bat yellow throat airplane base structure garage income visit common serve favorite voice indicate anything eye', 1),
	(18, 'emp07', 3, 'dish toy health unit experience planet depend handle guide meat harbor struggle machinery grown fox molecular why shall small yet regular whispered avoid movement', 1),
	(19, 'emp12', 8, 'slope familiar plain fresh butter combination biggest pride broken nearest advice upper language pound newspaper shelter wonder development sky branch taste mysterious bill many', 0),
	(20, 'emp08', 1, 'popular attached whistle produce thirty north continued visitor bank camp grade interior direction vast waste material scared mail stand sold indeed modern pig transportation', 0),
	(21, 'emp02', 8, 'asleep win put goose individual once hold easily adventure softly cowboy agree shelter saved tiny mixture yellow dish light hit average wild bus needed', 1),
	(22, 'emp07', 4, 'drawn effect star strange took truth acres instrument damage catch above world religious joy aboard coal rapidly steam arrange few alive although porch front', 1),
	(23, 'emp07', 4, 'original funny pattern average three pot sharp increase return complete held chosen kids during distance magic might strong shells operation bet breeze story mathematics', 0),
	(24, 'emp02', 1, 'themselves tide magnet upon review book choose pretty live lady involved military saddle north sea carry shorter limited settlers wool effect leave nails method', 0);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.tasks_mechanics
CREATE TABLE IF NOT EXISTS `tasks_mechanics` (
  `emp_id` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `task_id` int(11) NOT NULL,
  KEY `task_id` (`task_id`),
  KEY `FK_tasks_mechanics_employees` (`emp_id`),
  CONSTRAINT `FK_tasks_mechanics_employees` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tasks_mechanics_tasks` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.tasks_mechanics: ~10 rows (approximately)
/*!40000 ALTER TABLE `tasks_mechanics` DISABLE KEYS */;
INSERT INTO `tasks_mechanics` (`emp_id`, `task_id`) VALUES
	('emp00', 23),
	('emp04', 9),
	('emp02', 9),
	('emp02', 19),
	('emp03', 19),
	('emp00', 20),
	('emp06', 20),
	('emp02', 23),
	('emp03', 23),
	('emp09', 23);
/*!40000 ALTER TABLE `tasks_mechanics` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.task_status
CREATE TABLE IF NOT EXISTS `task_status` (
  `tstat_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `tstat_datetime` bigint(20) NOT NULL,
  `tstat_details` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tstype_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`tstat_id`),
  KEY `task_id` (`task_id`),
  KEY `tstype_id` (`tstype_id`),
  CONSTRAINT `task_status_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `task_status_ibfk_2` FOREIGN KEY (`tstype_id`) REFERENCES `task_status_type` (`tstype_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.task_status: ~29 rows (approximately)
/*!40000 ALTER TABLE `task_status` DISABLE KEYS */;
INSERT INTO `task_status` (`tstat_id`, `task_id`, `tstat_datetime`, `tstat_details`, `tstype_id`) VALUES
	(1, 1, 1578157200000, NULL, 1),
	(2, 2, 1578416400000, NULL, 1),
	(3, 3, 1578675600000, NULL, 1),
	(4, 4, 1578848400000, NULL, 1),
	(5, 5, 1579366800000, NULL, 1),
	(6, 6, 1579539600000, NULL, 1),
	(7, 7, 1581699600000, NULL, 1),
	(8, 8, 1582218000000, NULL, 1),
	(9, 9, 1582218000000, NULL, 1),
	(10, 10, 1582304400000, NULL, 1),
	(11, 11, 1582822800000, NULL, 1),
	(12, 12, 1582995600000, NULL, 1),
	(13, 13, 1584464400000, NULL, 1),
	(14, 14, 1584810000000, NULL, 1),
	(15, 15, 1584982800000, NULL, 1),
	(16, 16, 1585674000000, NULL, 1),
	(17, 17, 1587229200000, NULL, 1),
	(18, 18, 1587488400000, NULL, 1),
	(19, 19, 1587920400000, NULL, 1),
	(20, 20, 1588179600000, NULL, 1),
	(21, 21, 1588525200000, NULL, 1),
	(22, 22, 1589130000000, NULL, 1),
	(23, 23, 1589389200000, NULL, 1),
	(24, 24, 1589821200000, NULL, 1),
	(25, 23, 1589821200000, NULL, 2),
	(26, 9, 1582304400000, NULL, 3),
	(27, 19, 1588179600000, NULL, 3),
	(28, 20, 1588525200000, NULL, 3);
/*!40000 ALTER TABLE `task_status` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.task_status_mechanics
CREATE TABLE IF NOT EXISTS `task_status_mechanics` (
  `tstat_id` int(11) NOT NULL,
  `emp_id` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`tstat_id`,`emp_id`),
  KEY `emp_id` (`emp_id`),
  CONSTRAINT `FK_task_status_mechanics_tasks_mechanics` FOREIGN KEY (`emp_id`) REFERENCES `tasks_mechanics` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `task_status_mechanics_ibfk_1` FOREIGN KEY (`tstat_id`) REFERENCES `task_status` (`tstat_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.task_status_mechanics: ~6 rows (approximately)
/*!40000 ALTER TABLE `task_status_mechanics` DISABLE KEYS */;
INSERT INTO `task_status_mechanics` (`tstat_id`, `emp_id`) VALUES
	(25, 'emp00'),
	(25, 'emp09'),
	(26, 'emp04'),
	(27, 'emp02'),
	(27, 'emp03'),
	(28, 'emp00');
/*!40000 ALTER TABLE `task_status_mechanics` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.task_status_part
CREATE TABLE IF NOT EXISTS `task_status_part` (
  `tstat_id` int(11) NOT NULL,
  `part_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`tstat_id`,`part_id`),
  KEY `part_id` (`part_id`),
  CONSTRAINT `task_status_part_ibfk_1` FOREIGN KEY (`tstat_id`) REFERENCES `task_status` (`tstat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `task_status_part_ibfk_2` FOREIGN KEY (`part_id`) REFERENCES `machine_parts` (`part_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.task_status_part: ~0 rows (approximately)
/*!40000 ALTER TABLE `task_status_part` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_status_part` ENABLE KEYS */;

-- Dumping structure for table cpe231-cmms.task_status_type
CREATE TABLE IF NOT EXISTS `task_status_type` (
  `tstype_id` int(11) NOT NULL AUTO_INCREMENT,
  `tstype_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`tstype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table cpe231-cmms.task_status_type: ~2 rows (approximately)
/*!40000 ALTER TABLE `task_status_type` DISABLE KEYS */;
INSERT INTO `task_status_type` (`tstype_id`, `tstype_name`) VALUES
	(1, 'รอรับแจ้ง'),
	(2, 'กำลังตรวจสอบ'),
	(3, 'กำลังรออะไหล่'),
	(4, 'ซ่อมแซมแล้ว');
/*!40000 ALTER TABLE `task_status_type` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
