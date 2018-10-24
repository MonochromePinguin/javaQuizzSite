create database if not exists quizzdb character set 'utf8';
use quizzdb;

/* student status :
_ (not registered), can have the MCQ test
_ ASKER:     registered for mail exchanges only
_ REGISTERED: have passed the MCQ, enrolled as student
_ STUDENT1, 1st part, can pass full tests to get higher grade
_ STUDENT2, has passed all mid-cursus full tests from all its cursus
_ FLUNK, had lamentably failed at some point
*/
create table if not exists studentStatus(
    statusId     int unsigned  auto_increment not null,
    name         nchar(32) not null,
    description nvarchar(255),
    
    constraint pk_statusId primary key(statusId),
    constraint uq_name unique(name)
);



# used for students, wannabe students, and peoples giving emails for being answered
create table if not exists students(
    studentId    int unsigned  auto_increment not null,
    firstName    nchar(64) not null,
    lastName     nchar(64) not null,
    
    birthDate    date
        comment 'becomes mandatory on inscription;',
    
    email        nvarchar(128) not null,
    pseudo       nvarchar(64)
        comment 'used to discriminate between users with same firstName/lastName/birthDate, optional only for the contact page',
    
    statusId     int unsigned not null,

    constraint pk_studentId primary key(studentId),
    constraint uq_email unique(email),
    constraint uq_pseudo unique(pseudo),
    constraint uq_names_birth_pseudo unique(firstName, lastName, birthDate, pseudo),

    constraint fk_statusId foreign key(statusId) references studentStatus(statusId)
        on delete restrict
);



# teachers – creators and correctors of quizzes
create table if not exists teachers(
    teacherId   int unsigned  auto_increment not null,
    firstName   nchar(64) not null,
    lastName    nchar(64) not null,
    birthDate   date not null,
    
    email       nvarchar(128) not null,

    constraint pk_teacherId primary key(teacherId),
    constraint uq_email unique(email),
    constraint uq_names_birth_pseudo unique(firstName, lastName, birthDate, email)
);



# quizz themes or subjects
create table if not exists themes(
    themeId     int unsigned  auto_increment not null,
    name        nchar(64) not null,
    description nvarchar(255),
    
    constraint pk_themeId  primary key(themeId),
    constraint uq_name unique(name)
);



# a question can belong to several quizz
create table if not exists questions(
    questionId   int unsigned  auto_increment not null,
    label        nvarchar(255) not null,
    themeId      int unsigned
        comment 'if set, the question can be used into a randomly-created quizzes (a quizz built from 𝑛 questions coming from a question pool)',
    isMCQ        boolean not null  default true
        comment 'if is a MCQ, the answers are automatically correctables, and several rows from the "answers" table are related to this question',
    
    constraint pk_questionId  primary key(questionId),
    constraint fk_themeId foreign key(themeId) references themes(themeId)
        on delete restrict
);



# this table hold MCQ answers – non-MCQ questions have just no given answer
create table if not exists answers(
    answerId    int unsigned  auto_increment not null,
    label       nvarchar(64) not null,
    isCorrect   boolean not null  default false,
    questionId  int unsigned not null,
    
    constraint pk_answerId  primary key(answerId),
    constraint fk_questionId foreign key(questionId) references questions(questionId)
        on delete cascade
);



create table if not exists quizzes(
    quizzId       int unsigned  auto_increment  auto_increment  auto_increment not null,
    name          nvarchar(128) not null,
    slug          nvarchar(128) not null
        comment "the slug to use in the URL",
    themeId       int unsigned not null,
    
    teacherId     int unsigned not null
        comment 'for now, this is the quizz''s creator, and the creator is also the only corrector – in the future, we can add an intermedary table if we want more correctors',
 
    isMCQ         boolean not null default true
        comment 'if true, the quizz contains only MCQ, and can be automatically corrected; if false, it contains (or can contains in case of randomly-generated quizz) free-text answers, and cannot be automatically corrected',
    isRandom      boolean not null
        comment 'if true, the quizz is made from random questions pulled from a pool, and the following column is valid',
    nbQuestions   int unsigned,
    
    constraint pk_quizzId  primary key(quizzId),
    constraint uq_name    unique(name),
    constraint uq_slug    unique(slug),
    constraint fk_themeId_of_quizzes foreign key(themeId) references themes(themeId)
        on delete restrict,
    constraint fk_teacherId foreign key(teacherId) references teachers(teacherId)
        on delete restrict
);



/* each time a student has a quizz that contains at least one free-text answer, its answers are recorded in DB for ulterior correction;
this table records each submission waiting for a correction 
*/
create table if not exists resultSubmissions(
    resultSubmissionId    int unsigned  auto_increment not null
        comment 'the DB do not forbid a student to have several time the same quizz, so we do not use a compound primary key (studentId, quizzId)',
    studentId             int unsigned not null,
    quizzId               int unsigned not null,
    submissionDateTime    datetime not null default current_timestamp
        comment 'date and time the student submit his answers',

    constraint pk_resultSubmissionId  primary key(resultSubmissionId),
    constraint fk_studentId foreign key(studentId) references students(studentId)
        on delete cascade,
    constraint fk_quizzId foreign key(quizzId) references quizzes(quizzId)
        on delete restrict
);



# each row int this table records the answer given to ONE question by a student in a specific result submission
create table if not exists resultProposal(
    resultSubmissionId    int unsigned not null,
    questionId            int unsigned not null,    
    answer                nvarchar(255) not null
        comment 'in the case of an MCQ question: the textual representation of an array listing all chosen answers; in the case of a free-text question: the answered text.',
                            
    constraint fk_questionId_of_resultProposal foreign key(questionId) references questions(questionId)
        on delete restrict ,
    constraint fk_resultSubmissionId foreign key(resultSubmissionId) references resultSubmissions(resultSubmissionId)
        on delete restrict,

    constraint pk_resultSubmissionId_questionId primary key(resultSubmissionId, questionId)
);