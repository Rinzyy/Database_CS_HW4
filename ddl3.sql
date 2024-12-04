
-- Phone Plan Table
CREATE TABLE phone_plan (
    phone_plan_id INT PRIMARY KEY,
    plan_type VARCHAR(50) NOT NULL,
    monthly_charge DECIMAL(10, 2) NOT NULL,
    data_limit INT NOT NULL,
    talk_limit INT NOT NULL
);

--Bank Account Table
CREATE TABLE bank_account (
    bank_account_id INT PRIMARY KEY,
    account_holder_name VARCHAR(255) NOT NULL,
    bank_name VARCHAR(255) NOT NULL,
    account_number VARCHAR(50) NOT NULL,
    routing_number VARCHAR(50) NOT NULL,
    balance DECIMAL(10,2) NOT NULL
);

-- Customer Table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(12) NOT NULL,
    email VARCHAR(255),
    phone_plan_id INT NOT NULL,
    bank_account_id INT NOT NULL,
    FOREIGN KEY (phone_plan_id) REFERENCES phone_plan(phone_plan_id),
    FOREIGN KEY (bank_account_id) REFERENCES bank_account(bank_account_id) ON DELETE CASCADE
);

--Call Record Table
CREATE TABLE call_record (
    call_start_time DATE NOT NULL,
    call_end_time DATE NOT NULL,
    call_duration INT NOT NULL,
    data_usage INT NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (customer_id, call_start_time),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

--Phone Bill Table
CREATE TABLE bill (
    bill_id INT PRIMARY KEY,    
    bill_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    due_date DATE NOT NULL,
    bill_status VARCHAR(20) NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

--Payment Table
CREATE TABLE payment (
    payment_method VARCHAR(50) NOT NULL,
    payment_type VARCHAR(50) NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(10,2) NOT NULL,
    bill_id INT NOT NULL,
    bank_account_id INT NOT NULL,
    PRIMARY KEY (payment_date, bill_id, bank_account_id),
    FOREIGN KEY (bill_id) REFERENCES bill(bill_id) ON DELETE CASCADE,
    FOREIGN KEY (bank_account_id) REFERENCES bank_account(bank_account_id) ON DELETE CASCADE
);

-- Address Table
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

-- Customer Service Table
CREATE TABLE customer_service (
    service_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    service_date DATE NOT NULL,
    issue_description TEXT NOT NULL,
    resolution_description TEXT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

-- Phone Warranty Table
CREATE TABLE phone_warranty (
    warranty_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    warranty_start_date DATE NOT NULL,
    warranty_end_date DATE NOT NULL,
    warranty_status VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

-- Service Range Table
CREATE TABLE service_range (
    range_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    region_name VARCHAR(255) NOT NULL,
    coverage_area VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);
