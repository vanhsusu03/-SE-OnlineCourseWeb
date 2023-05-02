DROP SCHEMA IF EXISTS onlinecourse;
CREATE SCHEMA onlinecourse;
USE onlinecourse;

CREATE TABLE student (
  student_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  email VARCHAR(60) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  birthday DATE NOT NULL,
  image VARCHAR(300) DEFAULT NULL,
  username VARCHAR(50) NOT NULL,
  password TEXT NOT NULL,
  registration_date DATE NOT NULL,
  coin INT UNSIGNED DEFAULT 0,
  is_instructor BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (student_id),
  UNIQUE(username),
  UNIQUE(email),
  UNIQUE(phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE instructor (
  instructor_id MEDIUMINT UNSIGNED NOT NULL,
  qualification VARCHAR(300) NOT NULL,
  introduction_brief VARCHAR(3000) NOT NULL,
  transfer_info VARCHAR(200) NOT NULL, -- BankName_AccountNumber_NameOfBankAccount
  PRIMARY KEY (instructor_id),
  CONSTRAINT fk_instructor_student FOREIGN KEY (instructor_id) REFERENCES student (student_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE course (
  course_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  instructor_id MEDIUMINT UNSIGNED NOT NULL,
  title VARCHAR(128) NOT NULL,
  description TEXT DEFAULT NULL,
  release_date DATE NOT NULL,
  course_fee MEDIUMINT UNSIGNED NOT NULL,
  is_closed BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (course_id),
  CONSTRAINT fk_course_instructor FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cart (
  student_id MEDIUMINT UNSIGNED NOT NULL,
  course_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (student_id, course_id),
  CONSTRAINT fk_cart_student FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_cart_course FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE deposit (
  deposit_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id MEDIUMINT UNSIGNED NOT NULL,
  amount INT UNSIGNED NOT NULL,
  deposit_time DATETIME NOT NULL,
  PRIMARY KEY (deposit_id),
  CONSTRAINT fk_deposit_order FOREIGN KEY (customer_id) REFERENCES student (student_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `order` (
  order_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (order_id),
  CONSTRAINT fk_order_student FOREIGN KEY (customer_id) REFERENCES student (student_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE order_detail (
  order_detail_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  order_id INT UNSIGNED NOT NULL,
  course_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (order_detail_id),
  CONSTRAINT fk_order_detail_order FOREIGN KEY (order_id) REFERENCES `order` (order_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_order_detail_course FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE payment (
  payment_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  order_detail_id INT UNSIGNED NOT NULL,
  amount MEDIUMINT UNSIGNED NOT NULL,
  payment_time DATETIME NOT NULL,
  PRIMARY KEY (payment_id),
  UNIQUE(order_detail_id),
  CONSTRAINT fk_payment_order_detail FOREIGN KEY (order_detail_id) REFERENCES order_detail (order_detail_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE category (
  category_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(128) NOT NULL,
  PRIMARY KEY (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE course_category (
  course_id SMALLINT UNSIGNED NOT NULL,
  category_id TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (course_id, category_id),
  CONSTRAINT fk_course_category_category FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_course_category_course FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE chapter (
  chapter_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  course_id SMALLINT UNSIGNED NOT NULL,
  title VARCHAR(200) NOT NULL,
  PRIMARY KEY (chapter_id),
  CONSTRAINT fk_chapter_course FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE content_type (
  type_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  content_type VARCHAR(50) NOT NULL,
  PRIMARY KEY (type_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE content (
  content_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  chapter_id MEDIUMINT UNSIGNED NOT NULL,
  content_type_id TINYINT UNSIGNED NOT NULL,
  time_required_in_sec SMALLINT UNSIGNED NOT NULL,
  is_open_for_free BOOLEAN NOT NULL DEFAULT FALSE,
  link VARCHAR(300) NOT NULL,
  PRIMARY KEY (content_id),
  CONSTRAINT fk_content_chapter FOREIGN KEY (chapter_id) REFERENCES chapter (chapter_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_content_content_type FOREIGN KEY (content_type_id) REFERENCES content_type (type_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE enrollment (
  enrollment_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  student_id MEDIUMINT UNSIGNED NOT NULL,
  course_id SMALLINT UNSIGNED NOT NULL,
  enrollment_date DATE NOT NULL,
  PRIMARY KEY (enrollment_id),
  UNIQUE(student_id, course_id),
  CONSTRAINT fk_enrollment_course FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE feedback (
  feedback_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  enrollment_id INT UNSIGNED NOT NULL,
  rating FLOAT UNSIGNED NOT NULL,
  detail VARCHAR(3000) DEFAULT NULL,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (feedback_id),
  UNIQUE(enrollment_id),
  CONSTRAINT fk_feedback_enrollment FOREIGN KEY (enrollment_id) REFERENCES enrollment (enrollment_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE progress (
  progress_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  enrollment_id INT UNSIGNED NOT NULL,
  last_time_access DATETIME DEFAULT NULL,
  is_completed BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (progress_id),
  UNIQUE(enrollment_id),
  CONSTRAINT fk_progress_enrollment FOREIGN KEY (enrollment_id) REFERENCES enrollment (enrollment_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;