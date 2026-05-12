create database ss15;
use ss15;
create table students(
student_id varchar(5) primary key,
full_name varchar(50) not null,
total_debt decimal(10,2)
);
create table subjects(
subject_id varchar(5) primary key,
subject_name varchar(50) not null,
credits int check( credits > 0 )
);
create table grades(
student_id varchar(5),
subject_id varchar(5),
score decimal(4,2),
primary key(student_id,subject_id),
foreign key(student_id) references students(student_id),
foreign key(subject_id) references subjects(subject_id)
);
create table grade_log(
log_id int primary key auto_increment,
student_id varchar(5),
old_score decimal(4,2),
new_score decimal(4,2),
chage_date datetime default current_timestamp,
foreign key(student_id) references students(student_id)
);
-- câu 1:
delimiter //

create trigger tg_check_score
before insert on grades
for each row
begin

    if new.score < 0 THEN
        set new.score = 0;
    end if;

    if new.score > 10 THEN
        set new.score = 10;
    end if;

end //

delimiter  ;
-- câu 2:
delimiter $$
create procedure update_student(
in s_student_id varchar(5),
in s_full_name varchar(50),
in s_total_debt decimal(10,2)
)
begin
 start transaction;
 insert into students(s_student_id, s_full_name)
 values (s_student_id, s_full_name);

update students
set total_dent = s_total_debt
where student_id = s_student_id;
commit;

end $$
delimiter ;
call update_student('SV02','Ha Bich Ngoc',5000000);
-- câu 3:
delimiter $$

create trigger tg_log_grade_update
after update on grades
for each row
begin
if old_score <> new_score then
insert into grade_log(stutudent_id, old_score, new_score, change_date)
values ()
end $$
delimiter ;