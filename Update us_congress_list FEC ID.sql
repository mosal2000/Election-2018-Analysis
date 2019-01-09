SELECT * FROM election_2018_db.us_congress_list
where congress_num = 116;

select cl.id, cl.name, cl.state, cl.st_abbrev, cl.district, hc.fec_candidate_id
FROM election_2018_db.us_congress_list cl
left join house_candidate hc on (hc.clean_name = cl.name and hc.office_state = cl.st_abbrev and hc.district = cl.district)
where cl.congress_num = 116 and hc.fec_candidate_id is null
order by cl.st_abbrev, cl.district;

select cl.id, cl.name, cl.state, cl.st_abbrev, cl.district, hc.fec_candidate_id
FROM election_2018_db.us_congress_list cl
left join house_candidate hc on (
	(SUBSTRING_INDEX(hc.clean_name, ' ', -1) = SUBSTRING_INDEX(cl.name, ' ', -1)
      or SUBSTRING_INDEX(hc.clean_name, ' ', 1) = SUBSTRING_INDEX(cl.name, ' ', 1)
      or SUBSTRING_INDEX(hc.clean_name, ' ', 2) = SUBSTRING_INDEX(cl.name, ' ', 2)
    )
    and hc.office_state = cl.st_abbrev 
    and hc.district = cl.district
    )
where cl.congress_num = 116 and hc.fec_candidate_id is null
order by cl.st_abbrev, cl.district;

select cl.id, cl.name, cl.state, cl.st_abbrev, cl.district, hc.fec_candidate_id
FROM election_2018_db.us_congress_list cl
left join house_candidate hc on (
	(SUBSTRING_INDEX(hc.clean_name, ' ', -1) = SUBSTRING_INDEX(cl.name, ' ', -1)
      or SUBSTRING_INDEX(hc.clean_name, ' ', 1) = SUBSTRING_INDEX(cl.name, ' ', 1)
      or SUBSTRING_INDEX(hc.clean_name, ' ', 2) = SUBSTRING_INDEX(cl.name, ' ', 2)
    )
    and hc.office_state = cl.st_abbrev 
    and hc.district = cl.district
    )
where cl.congress_num = 116 
order by cl.st_abbrev, cl.district;

CALL populate_fec_id ();

# Tony Cárdenas
select id from us_congress_list where congress_num = 116 and name = 'Tony Cárdenas' and st_abbrev = 'CA' and district = 29;

update us_congress_list
set fec_candidate_id = 'H2CA28113'
where id = 485;

# Joseph P. Kennedy III
select id from us_congress_list where congress_num = 116 and name = 'Joseph P. Kennedy III' and st_abbrev = 'MA' and district = 4;

update us_congress_list
set fec_candidate_id = 'H2MA04073'
where id = 628;

# Lacy Clay
select id from us_congress_list where congress_num = 116 and name = 'Lacy Clay' and st_abbrev = 'MO' and district = 1;

update us_congress_list
set fec_candidate_id = 'H0MO01066'
where id = 660;

# Tim Ryan
select id from us_congress_list where congress_num = 116 and name = 'Tim Ryan' and st_abbrev = 'OH' and district = 13;

update us_congress_list
set fec_candidate_id = 'H2OH17109'
where id = 746;

# Susan Wild
select id from us_congress_list where congress_num = 116 and name = 'Susan Wild' and st_abbrev = 'PA' and district = 7;

update us_congress_list
set fec_candidate_id = 'H8PA15229'
where id = 766;

select * from us_congress_list where congress_num = 116 and fec_candidate_id is null;
