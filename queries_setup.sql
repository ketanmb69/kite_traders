

CREATE TABLE IF NOT EXISTS 'users' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
                                    ,'username' TEXT NOT NULL
                                    ,'hash' TEXT NOT NULL
                                    ,'cash' NUMERIC NOT NULL DEFAULT 10000.00
                                    );

CREATE TABLE sqlite_sequence(name,seq);

CREATE UNIQUE INDEX 'username' ON "users" ("username");

CREATE TABLE names(first_name TEXT NOT NULL,
                    last_name VARCHAR(255) NOT NULL,
                    email_address TEXT NOT NULL,
                    name_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                    FOREIGN KEY(name_id) REFERENCES users(id)
                    );

CREATE TABLE IF NOT EXISTS 'companies' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
                                        ,'name' TEXT  NOT NULL
                                        ,'symbol' VARCHAR(4) UNIQUE NOT NULL
                                        ,'exchange' TEXT NOT NULL
                                        );

CREATE TABLE cash (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                    datetime DATETIME NOT NULL,
                    debit REAL NOT NULL,
                    credit REAL NOT NULL,
                    user_id INTEGER NOT NULL
                    ,trans_id VARCHAR(20),
                    FOREIGN KEY(user_id) REFERENCES users (id)
                    );

CREATE TABLE IF NOT EXISTS 'transactions' (trans_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                                            datetime DATETIME NOT NULL,
                                            price REAL NOT NULL,
                                            quantity INTEGER NOT NULL,
                                            total REAL NOT NULL,
                                            ordertype TEXT NOT NULL,
                                            c_id INTEGER NOT NULL,
                                            user_id INTEGER NOT NULL,
                                            CHECK (ordertype IN ('BUY', 'SELL')),
                                            FOREIGN KEY(c_id) REFERENCES companies (id),
                                            FOREIGN KEY(user_id) REFERENCES users (id)
                                            );

-- DROP TABLE IF EXISTS 'transactions';
-- DROP TABLE IF EXISTS 'users';
-- DROP TABLE IF EXISTS 'cash';
-- DROP TABLE IF EXISTS 'companies';

WITH indexSetup AS (
    SELECT u.username, c.symbol, c.name, t.c_id, t.ordertype, SUM(u.cash) AS cash, SUM(t.quantity) as quantity, SUM(t.quantity * t.price) AS total FROM transactions t
JOIN companies c ON t.c_id = c.id JOIN users u ON t.user_id = u.id WHERE user_id =1 GROUP BY  1, 2, 3, 4, 5)
,sell AS(SELECT username, symbol,  name, c_id, SUM(cash) AS cash, SUM(quantity) AS quantity , SUM(total) AS costBasis FROM indexSetup WHERE ordertype = 'SELL' GROUP BY 1, 2, 3, 4)

, buy AS(SELECT username, symbol,  name, c_id, SUM(cash) AS cash, SUM(quantity) AS quantity , SUM(total) AS costBasis FROM indexSetup WHERE ordertype = 'BUY' GROUP BY 1, 2, 3, 4)

,results AS(
	SELECT username, symbol,  name, c_id, cash,
		COALESCE(SUM(b.quantity - s.quantity), b.quantity) AS quantity,
		COALESCE(SUM(b.costBasis - s.costBasis), b.costBasis)  AS total 
		FROM buy b
		LEFT JOIN sell s USING(username, symbol, name, c_id, cash)
		GROUP BY 1, 2, 3, 4, 5
		ORDER BY name
		)
SELECT * FROM results WHERE quantity >0;