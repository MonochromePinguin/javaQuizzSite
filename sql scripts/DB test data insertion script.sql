

INSERT INTO quizzdb.studentStatus (statusId, name, description) VALUES (1, 'asker', 'registered for mail exchanges – not a student');
INSERT INTO quizzdb.studentStatus (statusId, name, description) VALUES (2, 'registered', 'had success with the two MCQ, now registered as STUDENT');
INSERT INTO quizzdb.studentStatus (statusId, name, description) VALUES (3, 'student1', 'student, 1st part cursus, can pass mid-cursus tests to get higher grade');
INSERT INTO quizzdb.studentStatus (statusId, name, description) VALUES (4, 'student2', 'student, 2nd part cursus, had her mid-cursus test');
INSERT INTO quizzdb.studentStatus (statusId, name, description) VALUES (5, 'flunk', 'flunk – had lamentably failed mid-cursus test');


INSERT INTO quizzdb.students (studentId, firstName, lastName, birthDate, email, pseudo, statusId) VALUES (4, 'student1', 'stud', '2000-10-10', 'student1@yopmail.net', '', 2);
INSERT INTO quizzdb.students (studentId, firstName, lastName, birthDate, email, pseudo, statusId) VALUES (5, 'student2', 'study', null, 'student2@yopmail.org', 'study2', 3);
INSERT INTO quizzdb.students (studentId, firstName, lastName, birthDate, email, pseudo, statusId) VALUES (6, 'student2', 'study', '2000-01-01', 'student3@yopmail.net', 'study3', 3);
INSERT INTO quizzdb.students (studentId, firstName, lastName, birthDate, email, pseudo, statusId) VALUES (7, 'asker', 'nobdy', null, 'asker@yopmail.org', null, 1);


INSERT INTO quizzdb.teachers (teacherId, firstName, lastName, birthDate, email) VALUES (2, 'Teac', 'Her2', '1900-02-02', 'teacher2@yopmail.org');
INSERT INTO quizzdb.teachers (teacherId, firstName, lastName, birthDate, email) VALUES (1, 'Teach', 'Er', '1900-01-01', 'teacher1@yopmail.org');
INSERT INTO quizzdb.teachers (teacherId, firstName, lastName, birthDate, email) VALUES (3, 'third', 'Teacher', '1900-03-03', 'teacher3@yopmail.net');


INSERT INTO quizzdb.themes (themeId, name, description) VALUES (1, 'BASH programming', 'POSIX shell and BASH extensions test.');
INSERT INTO quizzdb.themes (themeId, name, description) VALUES (2, 'linux commands', 'command-line interface and common commands');
INSERT INTO quizzdb.themes (themeId, name, description) VALUES (3, 'Cat Facts', 'Can you answer to these questions about cats?');
INSERT INTO quizzdb.themes (themeId, name, description) VALUES (4, 'test – theme #4', 'description for theme #4 – fugit nulla provident quisquam reprehenderit sed. Aperiam dicta fuga perspiciatis quos rem? Alias asperiores dolores ea maiores minus natus nostrum');
INSERT INTO quizzdb.themes (themeId, name, description) VALUES (5, 'test – theme #5', 'description for theme #5: Aspernatur beatae, esse eum id illum iure nobis odio praesentium quo reiciendis repellat sequi veniam.');


INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (1, 'MCQ Quizz #1, theme #3', 'quizz-1-theme-3', 3, 1, 1, 0, null);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (2, 'MCQ Quizz #2, theme #3 (10 random questions)', 'quizz-2-theme-3-random', 3, 2, 1, 1, 10);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (3, 'free-text Quizz #3, theme #3, not random', 'free-text-quizz-3-theme-3', 3, 2, 0, 0, null);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (4, 'TEST – quizz with no question', 'test-quizz-no-question-inside', 4, 1, 0, 0, null);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (5, 'free-text Quizz #5, theme #4, random', 'quizz-5', 4, 1, 0, 1, 5);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (6, 'BASH Quizz', 'BASH-Quizz', 1, 1, 0, 0, null);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (7, 'small BASH Quizz (5 random questions)', 'small-bash-quizz-5', 1, 1, 1, 1, 5);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (8, 'small BASH Quizz (10 random questions, free-text)', 'small-bash-quizz-10', 1, 2, 0, 1, 10);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (9, 'BASH advanced quizz (free-text)', 'bash-advanced-quizz', 1, 2, 0, 0, null);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (10, 'linux command-line tools', 'linux-tools', 2, 3, 1, 0, null);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (11, 'linux command-line tools (8 random questions)', 'linux-tools-random-8', 2, 3, 0, 1, 8);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (12, 'BASH quizz #2 (MCQ)', 'bash-quizz-2', 1, 3, 1, 0, null);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (13, 'POSIX utilities (MCQ)', 'posix-utilities', 2, 1, 1, 0, null);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (14, 'TEST – Quizz with bad slug, should send to a 404 err page', '<test?bad=quizz+slug+>', 3, 1, 1, 0, null);
INSERT INTO quizzdb.quizzes (quizzId, name, slug, themeId, teacherId, isMCQ, isRandom, nbQuestions) VALUES (15, 'TEST - quizz with a question without answer', 'test-quizz-with-a-question-without-answer', 1, 2, 1, 0, null);


INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (13, 'Selet correct way(s) to set the variable VAR to 10.', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (14, 'Select all valid command lines with POSIX ls', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (15, 'What command is used to add an user to the system?', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (16, 'What is the admin command to program the system to shutdown in one hour?', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (17, 'Select all existing POSIX fiters.', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (18, 'Which of these terms are not related to file access restriction on UNIX systems?', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (19, 'Which command show a command ''s output at regular interval?', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (20, 'What the command "tac" does?', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (21, 'What is a CRON service?', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (22, 'the command "ls -l" gave this output "drwxr-xr-x  2 user1 user2 4,0K 29/09/2018 23:06:20". In this context, what is "user2"?', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (23, 'Select correct assertions about the command "ln"', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (24, 'What does the acronym "BSD" stand for?', 2, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (25, 'What is an alias?', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (26, 'Are aliases POSIX compliants?', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (27, 'How do you get the data inside the array "myArray" at the index "30"?', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (28, 'Select all valid BASH 4.4 expressions.', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (29, 'What is the result of the expression "$(( $RANDOM / 8192 ))"?', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (30, 'Select all valid string variable declarations', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (31, 'What happens if you type this command in a BASH 4.5 interactive shell: echo "Hello world!"?', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (32, 'How can an alias be removed?', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (33, 'How to list defined aliases?', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (34, 'What is the result of this command-line: "pushd ." ?', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (35, 'Select correct implementation of this logic:\\n if the variable $a contains a value, output this value, else if $a is unset, output the text "ERROR"', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (36, 'What can you do with the "exec" internal command?', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (37, 'What is the meaning of this command:\\nexec 2>&1 > /dev/null', 1, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (38, 'Explain the differences between these two expressions:\\n[ -n "$v1" -a -z "$v2"]\\nand\\n[ -n "$v1" ] && [ -z "$v2" ]', 1, 0);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (39, 'What is $PWD?', 1, 0);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (40, 'What is the use of the "-c" command-line option?', 1, 0);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (41, 'What is an interactive shell?', 1, 0);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (42, 'TEST – question with 3 good answers', 4, 1);
INSERT INTO quizzdb.questions (questionId, label, themeId, isMCQ) VALUES (43, 'TEST – question without related answer', 4, 1);

INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (19, '$VAR=''10''', 0, 13);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (20, '$VAR = 10', 0, 13);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (21, 'VAR=10', 1, 13);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (22, '$VAR=10', 0, 13);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (23, 'VAR=$(( 10 ))', 1, 13);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (24, 'VAR=$((10))', 1, 13);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (25, 'VAR = "10"', 0, 13);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (26, 'A shortcut to an arbitrary string in the shell', 0, 25);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (27, 'A shortcut to a command when used in place of a command', 1, 25);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (28, 'A shortcut to an executable file', 0, 25);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (29, 'yes', 1, 26);
INSERT INTO quizzdb.answers (answerId, label, isCorrect, questionId) VALUES (30, 'no', 0, 26);


INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (14, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (16, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (17, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (18, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (19, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (20, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (21, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (22, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (23, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (24, 10);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (13, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (15, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (25, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (26, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (27, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (28, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (29, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (30, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (31, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (32, 12);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (30, 15);
INSERT INTO quizzdb.inter_questions_quizzes (questionId, quizzId) VALUES (31, 15);

