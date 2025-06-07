CREATE DATABASE try;
USE try;
CREATE TABLE employees (
employee_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR (100),
position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE
);
CREATE TABLE employee_audit (
audit_id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT,
name VARCHAR (100),
position VARCHAR (100), 
salary DECIMAL (10, 2), 
hire_date DATE,
action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO employees (name, position, salary, hire_date) VALUES ('John Doe',
'Software Engineer', 80000.00, '2022-01-15'),
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

select * from employees;

DELIMITER //

CREATE PROCEDURE update_employee(
    IN emp_id INT,
    IN new_name VARCHAR(100),
    IN new_position VARCHAR(100),
    IN new_salary DECIMAL (10, 2) ,
    IN new_hire_date DATE
)
BEGIN
UPDATE employees
SET name = new_name,
	position = new_position,
	salary = new_salary,
	hire_date =new_hire_date
	WHERE employee_id = emp_id;
        
	INSERT INTO employee_audit (employee_id, audit_id,name,position,salary,hire_date,action_date)
    VALUES (emp_id,
        'UPDATE',
        NOW(),
        CONCAT('Employee updated: ', new_name, ', Position: ', new_position));
END 
//
DELIMITER ;


CALL update_employee(4,'hell','Manager',50000,'2025-05-25');

DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (
        employee_id,
        action,
        action_timestamp,
+        description
    ) VALUES (
        NEW.employee_id,
        'INSERT',
        NOW(),
        CONCAT('New employee added: ', NEW.name, ', Position: ', NEW.position)
    );
END //

DELIMITER ;]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]\


