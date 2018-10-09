create database quizzDB character set 'utf8';

-- student status :
-- _ (not registered), can have the QCM test
-- _ ASKER:	 registered for mail exchanges only
-- _ REGISTERED: have passed the QCM, can have an interview to enroll
-- _ INTERVIEWED, decision pending
-- _ STUDENT1, 1st part, can pass full tests to get higher grade
-- _ STUDENT2, has passed all mid-cursus full tests from all its cursus
-- _ FLUNK, has not passed the first interview or the full tests
create table studentStatus(
	statusId 	int unsigned not null,
    name	 	nchar(32) not null,
    description nvarchar(255),
    
    constraint pk_statusId primary key(statusId),
    constraint uq_name unique(name)
);



-- used for students, wannabe students, and peoples giving emails for being answered
create table if not exists students(
	studentId	int unsigned not null,
    firstName 	nchar(64) not null,
    lastName	nchar(64) not null,
    
    birthDate	date comment 'becomes mandatory on inscription;',
    
	email		nvarchar(128) not null,
	pseudo		nvarchar(64) comment 'used to discriminate between users with same firstName/lastName/birthDate, optional only for the contact page',
    
    statusId	int unsigned not null,
	
    constraint pk_studentId primary key(studentId),
    constraint uq_email unique(email),
    constraint uq_pseudo unique(pseudo),
    constraint uq_names_birth_pseudo unique(firstName, lastName, birthDate, pseudo),

    constraint fk_statusId foreign key(statusId) references studentStatus(statusId)
);



-- teachers – creators and correctors of quizzes
create table if not exists teachers(
	teacherId	int unsigned not null,
    firstName 	nchar(64) not null,
    lastName	nchar(64) not null,
    birthDate	date not null,
    
	email		nvarchar(128) not null,
	
    constraint pk_teacherId primary key(teacherId),
    constraint uq_email unique(email),
    constraint uq_names_birth_pseudo unique(firstName, lastName, birthDate, email)
);



-- quizz themes or subjects
create table if not exists themes(
	themeId		int unsigned not null,
    name		nchar(64) not null,
    description nvarchar(255),
    
    constraint pk_themeId  primary key(themeId),
    constraint uq_name	unique(name)
);



-- a question can belong to several quizz
create table if not exists questions(
	questionId		int unsigned not null,
    
    
    constraint pk_questionId  primary key(questionId)
);



create table if not exists quizz(
	Id		int unsigned not null,
    constraint pk_  primary key(),
);

create table if not exists student(
	Id		int unsigned not null,
    constraint pk_  primary key(),
);

create table if not exists student(
	Id		int unsigned not null,
    constraint pk_  primary key(),
);