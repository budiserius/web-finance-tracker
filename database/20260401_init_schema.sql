CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(100) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL
);

CREATE TABLE accounts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL, 
    type VARCHAR(100),
    purpose VARCHAR(100) NOT NULL,
    is_accessible BOOLEAN DEFAULT TRUE,
    is_usable BOOLEAN DEFAULT TRUE,
    current_balance NUMERIC(15,2) DEFAULT 0,
    
    CONSTRAINT fk_accounts_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    account_id UUID NOT NULL,
    transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    type VARCHAR(50) CHECK (type IN ('income', 'expense', 'transfer')),
    category VARCHAR(50),
    amount NUMERIC(15,2) NOT NULL,
    balance_after NUMERIC(15,2) NOT NULL,
    
    CONSTRAINT fk_transactions_account FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE
);

CREATE TABLE loans (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    stakeholder VARCHAR(100) ,
    loan_lend NUMERIC(15,2) DEFAULT 0,
    loan_collected NUMERIC(15,2) DEFAULT 0,
    loan_borrow NUMERIC(15,2) DEFAULT 0,
    loan_repaid NUMERIC(15,2) DEFAULT 0,
    
    CONSTRAINT fk_loans_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT uq_loans_user_stakeholder UNIQUE (user_id, stakeholder)
);

CREATE TABLE budgets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    title VARCHAR(100),
    date_start TIMESTAMP NOT NULL,
    date_end TIMESTAMP NOT NULL,

    CONSTRAINT fk_budgets_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT chk_date CHECK (date_start < date_end)
);

CREATE TABLE budget_details (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    budget_id UUID NOT NULL,
    type VARCHAR(50) CHECK (type IN ('income', 'expense', 'transfer')),
    category VARCHAR(50) NOT NULL,
    amount_plan NUMERIC(15,2) DEFAULT 0,
    amount_real NUMERIC(15,2) DEFAULT 0
);

CREATE INDEX idx_accounts_user_id ON accounts(user_id);
CREATE INDEX idx_transactions_account_id ON transactions(account_id);
CREATE INDEX idx_loans_user_id ON loans(user_id);
CREATE INDEX idx_budgets_user_id ON budgets(user_id);