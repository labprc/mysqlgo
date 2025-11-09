DROP TABLE IF EXISTS lib_book;
DROP TABLE IF EXISTS lib_audit;

CREATE TABLE lib_book(
    bid INT PRIMARY KEY,
    bname VARCHAR(30),
    qty INT
);

CREATE TABLE lib_audit(
    bid INT,
    bname VARCHAR(30),
    qty INT
);

INSERT INTO lib_book VALUES
(1,'DBMS',10),
(2,'CNS',5),
(3,'DSA',8);

SELECT * FROM lib_book;

DROP TRIGGER IF EXISTS trg_audit_delete;
DELIMITER //

CREATE TRIGGER trg_audit_delete
AFTER DELETE ON lib_book
FOR EACH ROW
BEGIN
    INSERT INTO lib_audit (bid, bname, qty)
    VALUES (OLD.bid, OLD.bname, OLD.qty);
END;
//
DELIMITER ;

DROP TRIGGER IF EXISTS trg_audit_update;
DELIMITER //

CREATE TRIGGER trg_audit_update
AFTER UPDATE ON lib_book
FOR EACH ROW
BEGIN
    INSERT INTO lib_audit (bid, bname, qty)
    VALUES (OLD.bid, OLD.bname, OLD.qty);
END;
//
DELIMITER ;

UPDATE lib_book SET qty = 3 WHERE bid = 2;
DELETE FROM lib_book WHERE bid = 3;

SELECT * FROM lib_book;
SELECT * FROM lib_audit;
