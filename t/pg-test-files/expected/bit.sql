--
-- BIT types
--
--
-- Build tables for testing
--

CREATE TABLE BIT_TABLE (
    b bit(11)
);

INSERT INTO BIT_TABLE
    VALUES (B '10');

-- too short
INSERT INTO BIT_TABLE
    VALUES (B '00000000000');

INSERT INTO BIT_TABLE
    VALUES (B '11011000000');

INSERT INTO BIT_TABLE
    VALUES (B '01010101010');

INSERT INTO BIT_TABLE
    VALUES (B '101011111010');

-- too long
--INSERT INTO BIT_TABLE VALUES ('X554');
--INSERT INTO BIT_TABLE VALUES ('X555');

SELECT
    *
FROM
    BIT_TABLE;

CREATE TABLE VARBIT_TABLE (
    v bit varying(11)
);

INSERT INTO VARBIT_TABLE
    VALUES (B '');

INSERT INTO VARBIT_TABLE
    VALUES (B '0');

INSERT INTO VARBIT_TABLE
    VALUES (B '010101');

INSERT INTO VARBIT_TABLE
    VALUES (B '01010101010');

INSERT INTO VARBIT_TABLE
    VALUES (B '101011111010');

-- too long
--INSERT INTO VARBIT_TABLE VALUES ('X554');
--INSERT INTO VARBIT_TABLE VALUES ('X555');

SELECT
    *
FROM
    VARBIT_TABLE;

-- Concatenation
SELECT
    v,
    b,
    (v || b) AS ||
FROM
    BIT_TABLE,
    VARBIT_TABLE
ORDER BY
    3;

-- Length
SELECT
    b,
    length(b) AS lb
FROM
    BIT_TABLE;

SELECT
    v,
    length(v) AS lv
FROM
    VARBIT_TABLE;

-- Substring
SELECT
    b,
    SUBSTRING(b FROM 2 FOR 4) AS sub_2_4,
    SUBSTRING(b FROM 7 FOR 13) AS sub_7_13,
    SUBSTRING(b FROM 6) AS sub_6
FROM
    BIT_TABLE;

SELECT
    v,
    SUBSTRING(v FROM 2 FOR 4) AS sub_2_4,
    SUBSTRING(v FROM 7 FOR 13) AS sub_7_13,
    SUBSTRING(v FROM 6) AS sub_6
FROM
    VARBIT_TABLE;

--- Bit operations
DROP TABLE varbit_table;

CREATE TABLE varbit_table (
    a bit varying(16),
    b bit varying(16)
);

SELECT
    a,
    b,
    ~ a AS "~ a",
    a & b AS "a & b",
    a | b AS "a | b",
    a # b AS "a # b"
FROM
    varbit_table;

SELECT
    a,
    b,
    a < b AS "a<b",
    a <= b AS "a<=b",
    a = b AS "a=b",
    a >= b AS "a>=b",
    a > b AS "a>b",
    a <> b AS "a<>b"
FROM
    varbit_table;

SELECT
    a,
    a << 4 AS "a<<4",
    b,
    b >> 2 AS "b>>2"
FROM
    varbit_table;

DROP TABLE varbit_table;

--- Bit operations
DROP TABLE bit_table;

CREATE TABLE bit_table (
    a bit(16),
    b bit(16)
);

SELECT
    a,
    b,
    ~ a AS "~ a",
    a & b AS "a & b",
    a | b AS "a | b",
    a # b AS "a # b"
FROM
    bit_table;

SELECT
    a,
    b,
    a < b AS "a<b",
    a <= b AS "a<=b",
    a = b AS "a=b",
    a >= b AS "a>=b",
    a > b AS "a>b",
    a <> b AS "a<>b"
FROM
    bit_table;

SELECT
    a,
    a << 4 AS "a<<4",
    b,
    b >> 2 AS "b>>2"
FROM
    bit_table;

DROP TABLE bit_table;

-- The following should fail
SELECT
    B '001' & B '10';

SELECT
    B '0111' | B '011';

SELECT
    B '0010' # B '011101';

-- More position tests, checking all the boundary cases
SELECT
    POSITION(B '1010' IN B '0000101');

-- 0
SELECT
    POSITION(B '1010' IN B '00001010');

-- 5
SELECT
    POSITION(B '1010' IN B '00000101');

-- 0
SELECT
    POSITION(B '1010' IN B '000001010');

-- 6
SELECT
    POSITION(B '' IN B '00001010');

-- 1
SELECT
    POSITION(B '0' IN B '');

-- 0
SELECT
    POSITION(B '' IN B '');

-- 0
SELECT
    POSITION(B '101101' IN B '001011011011011000');

-- 3
SELECT
    POSITION(B '10110110' IN B '001011011011010');

-- 3
SELECT
    POSITION(B '1011011011011' IN B '001011011011011');

-- 3
SELECT
    POSITION(B '1011011011011' IN B '00001011011011011');

-- 5
SELECT
    POSITION(B '11101011' IN B '11101011');

-- 1
SELECT
    POSITION(B '11101011' IN B '011101011');

-- 2
SELECT
    POSITION(B '11101011' IN B '00011101011');

-- 4
SELECT
    POSITION(B '11101011' IN B '0000011101011');

-- 6
SELECT
    POSITION(B '111010110' IN B '111010110');

-- 1
SELECT
    POSITION(B '111010110' IN B '0111010110');

-- 2
SELECT
    POSITION(B '111010110' IN B '000111010110');

-- 4
SELECT
    POSITION(B '111010110' IN B '00000111010110');

-- 6
SELECT
    POSITION(B '111010110' IN B '11101011');

-- 0
SELECT
    POSITION(B '111010110' IN B '011101011');

-- 0
SELECT
    POSITION(B '111010110' IN B '00011101011');

-- 0
SELECT
    POSITION(B '111010110' IN B '0000011101011');

-- 0
SELECT
    POSITION(B '111010110' IN B '111010110');

-- 1
SELECT
    POSITION(B '111010110' IN B '0111010110');

-- 2
SELECT
    POSITION(B '111010110' IN B '000111010110');

-- 4
SELECT
    POSITION(B '111010110' IN B '00000111010110');

-- 6
SELECT
    POSITION(B '111010110' IN B '000001110101111101011');

-- 0
SELECT
    POSITION(B '111010110' IN B '0000001110101111101011');

-- 0
SELECT
    POSITION(B '111010110' IN B '000000001110101111101011');

-- 0
SELECT
    POSITION(B '111010110' IN B '00000000001110101111101011');

-- 0
SELECT
    POSITION(B '111010110' IN B '0000011101011111010110');

-- 14
SELECT
    POSITION(B '111010110' IN B '00000011101011111010110');

-- 15
SELECT
    POSITION(B '111010110' IN B '0000000011101011111010110');

-- 17
SELECT
    POSITION(B '111010110' IN B '000000000011101011111010110');

-- 19
SELECT
    POSITION(B '000000000011101011111010110' IN B '000000000011101011111010110');

-- 1
SELECT
    POSITION(B '00000000011101011111010110' IN B '000000000011101011111010110');

-- 2
SELECT
    POSITION(B '0000000000011101011111010110' IN B '000000000011101011111010110');

-- 0
-- Shifting

CREATE TABLE BIT_SHIFT_TABLE (
    b bit(16)
);

INSERT INTO BIT_SHIFT_TABLE
    VALUES (B '1101100000000000');

INSERT INTO BIT_SHIFT_TABLE
SELECT
    b >> 1
FROM
    BIT_SHIFT_TABLE;

INSERT INTO BIT_SHIFT_TABLE
SELECT
    b >> 2
FROM
    BIT_SHIFT_TABLE;

INSERT INTO BIT_SHIFT_TABLE
SELECT
    b >> 4
FROM
    BIT_SHIFT_TABLE;

INSERT INTO BIT_SHIFT_TABLE
SELECT
    b >> 8
FROM
    BIT_SHIFT_TABLE;

SELECT
    POSITION(B '1101' IN b),
    POSITION(B '11011' IN b),
    b
FROM
    BIT_SHIFT_TABLE;

CREATE TABLE VARBIT_SHIFT_TABLE (
    v bit varying(20)
);

INSERT INTO VARBIT_SHIFT_TABLE
    VALUES (B '11011');

INSERT INTO VARBIT_SHIFT_TABLE
SELECT
    CAST(v || B '0' AS bit varying(6)) >> 1
FROM
    VARBIT_SHIFT_TABLE;

INSERT INTO VARBIT_SHIFT_TABLE
SELECT
    CAST(v || B '00' AS bit varying(8)) >> 2
FROM
    VARBIT_SHIFT_TABLE;

INSERT INTO VARBIT_SHIFT_TABLE
SELECT
    CAST(v || B '0000' AS bit varying(12)) >> 4
FROM
    VARBIT_SHIFT_TABLE;

INSERT INTO VARBIT_SHIFT_TABLE
SELECT
    CAST(v || B '00000000' AS bit varying(20)) >> 8
FROM
    VARBIT_SHIFT_TABLE;

SELECT
    POSITION(B '1101' IN v),
    POSITION(B '11011' IN v),
    v
FROM
    VARBIT_SHIFT_TABLE;

DROP TABLE BIT_SHIFT_TABLE;

DROP TABLE VARBIT_SHIFT_TABLE;

-- Get/Set bit
SELECT
    get_bit(B '0101011000100', 10);

SELECT
    set_bit(B '0101011000100100', 15, 1);

SELECT
    set_bit(B '0101011000100100', 16, 1);

-- fail
-- Overlay

SELECT
    overlay(B '0101011100' PLACING '001' FROM 2 FOR 3);

SELECT
    overlay(B '0101011100' PLACING '101' FROM 6);

SELECT
    overlay(B '0101011100' PLACING '001' FROM 11);

SELECT
    overlay(B '0101011100' PLACING '001' FROM 20);

-- This table is intentionally left around to exercise pg_dump/pg_upgrade
CREATE TABLE bit_defaults (
    b1 bit(4) DEFAULT '1001',
    b2 bit(4) DEFAULT B '0101',
    b3 bit varying(5) DEFAULT '1001',
    b4 bit varying(5) DEFAULT B '0101'
);

\d bit_defaults
INSERT INTO bit_defaults DEFAULT VALUES; TABLE bit_defaults;

