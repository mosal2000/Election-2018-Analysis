
DROP DATABASE IF EXISTS election_2018_db;
CREATE DATABASE election_2018_db;
USE election_2018_db;

CREATE TABLE house_candidate (
	fec_candidate_id VARCHAR(20) primary key, 
	name varchar(100),
	party varchar(30), 
	status char(1),
	address_one varchar(100),
	address_two varchar(100),
    city varchar(50),
	state char(2),
	zip char(5),
	fec_committee_id varchar(10),
	cycle int,
	cand_status char(1),
	office_state char(2),
	district int,
	clean_name varchar(100), 
	url varchar(100),
	crp_id varchar(20),
	google_entity_id varchar(20)
);

CREATE TABLE senate_candidate (
	fec_candidate_id VARCHAR(20) primary key, 
	name varchar(100),
	party varchar(30), 
	status char(1),
	address_one varchar(100),
	address_two varchar(100),
    city varchar(50),
	state char(2),
	zip char(5),
	fec_committee_id varchar(10),
	cycle int,
	cand_status char(1),
	office_state char(2),
	district int,
	clean_name varchar(100), 
	url varchar(100),
	crp_id varchar(20),
	google_entity_id varchar(20)
);

CREATE TABLE candidate_finance (
	fec_candidate_id VARCHAR(20) primary key,
	cand_office char(1),
	total_receipt float,
	total_disbursement float,
	cash_on_hand_cop float,
	debt_owed_by_committee float,
	individual_itemized_contribution float,
	individual_unitemized_contribution float,
	individual_contribution float,
	other_committee_contribution float,
	party_committee_contribution float,
	cand_contribution float,
	total_contribution float,
	transfer_from_other_auth_committee float,
	cand_loan float,
	other_loan float,
	total_loan float,
	offsets_to_operating_expenditure float,
	offsets_to_fundraising float,
	offsets_to_leagal_accounting float,
	other_receipts float,
	operating_expenditure float,
	exempt_legal_accounting_disbursement float,
	fundraising_disbursement float,
	transfer_to_other_auth_committee float,
	cand_loan_repayment float,
	other_loan_repayment float,
	total_loan_repayment float,
	individual_refund float,
	party_committee_refund float,
	other_committee_refund float,
	total_contribution_refund float,
	other_disbursements float,
	net_contribution float,
	net_operating_expenditure float,
	cash_on_hand_bop float,
	debt_owe_to_committee float
);


CREATE TABLE congressional_district_mcd (
	id INT primary key NOT NULL AUTO_INCREMENT,
	state_dist VARCHAR(20), 
	district_population INT,
	employed INT,
	unemployed INT, 
	unemployment_rate FLOAT
);


# DROP TABLE congressional_district_cbp;

CREATE TABLE congressional_district_cbp (
	id INT primary key NOT NULL AUTO_INCREMENT,
	state_dist VARCHAR(10), 
    state char(2),
    district char(2),
	employment INT, 
	annual_payroll_in_1000 INT,
	num_of_establishment INT 
);

#DROP TABLE us_congress_list;

CREATE TABLE us_congress_list (
	id INT primary key NOT NULL AUTO_INCREMENT,
	congress_num INT,
	election_year INT,
    state varchar(50),
    st_abbrev char(2),
    district char(2),
	name varchar(100), 
	party varchar(30),
	fec_candidate_id VARCHAR(20)
);

DROP TABLE fips;

CREATE TABLE fips (
	id INT primary key NOT NULL AUTO_INCREMENT,
    state varchar(50),
    fips INT,
    STATEFP char(2),
    postal_code char(2)
);
