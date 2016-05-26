
-- Customer details table
-- id: this is auto generated number
-- status: customer status, refer tStatus table
-- created_on: datetime when the row was created
-- updated_on: datetime when the customer details are updated
CREATE TABLE tCustomer (
    id          SERIAL     PRIMARY KEY NOT NULL,
    cust_name   TEXT       NOT NULL,
    age         INT        NOT NULL,
    email       TEXT       NOT NULL,
    address     CHAR(50),
    status      CHAR(1)    CHECK ( status in ( 'A', 'S', 'D', 'P' ) ),
    created_on  TIMESTAMP  NOT NULL,
    updated_on  TIMESTAMP  NOT NULL
);

-- Customer password table
-- password is hashed
CREATE TABLE tPassword (
    id       SERIAL  PRIMARY KEY NOT NULL,
    cust_id  INT     references tCustomer(id),
    password text    NOT NULL
);

-- Customer status table
CREATE TABLE tStatus (
    code CHAR(1) NOT NULL,
    info CHAR(10)
);

-- table stores reason information if a customer status is suspended or pending etc.
CREATE TABLE tCustStatusReason (
    id        INT,
    cust_id   INT     references tCustomer(id),
    status    CHAR(1),
    reason    TEXT
);

-- Audit table for tCustomer
-- a row will be inserted in this every time when there is a change in tCuatomer table
CREATE TABLE tCustomer_aud (
    cust_id    INT       references tCustomer(id),
    cust_name  TEXT,
    age        INT,
    email      TEXT,
    address    CHAR(50),
    status     CHAR(1),
    created_on TIMESTAMP NOT NULL
);

-- insert values in the tStatus table
INSERT INTO tStatus (code, info) VALUES ('A', 'ACTIVE');
INSERT INTO tStatus (code, info) VALUES	('S', 'SUSPENDED');
INSERT INTO tStatus (code, info) VALUES	('D', 'DELETED');
INSERT INTO tStatus (code, info) VALUES	('P', 'PENDING');
