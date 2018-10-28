-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: quizzdb
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES (19,'$VAR=\'10\'',0,13),(20,'$VAR = 10',0,13),(21,'VAR=10',1,13),(22,'$VAR=10',0,13),(23,'VAR=$(( 10 ))',1,13),(24,'VAR=$((10))',1,13),(25,'VAR = \"10\"',0,13),(26,'A shortcut to an arbitrary string in the shell',0,25),(27,'A shortcut to a command when used in place of a command',1,25),(28,'A shortcut to an executable file',0,25),(29,'yes',1,26),(30,'no',0,26),(31,'test answer #1 - good',1,42),(32,'test answer #2 - good',1,42),(33,'test answer #3 - good',1,42),(34,'test - bad',0,44),(35,'test - bad',0,44),(36,'test - bad',0,44),(37,'test - bad',0,44),(38,'A - bad',0,45),(39,'B - good',1,45),(40,'C - bad',0,45),(41,'D - good',1,45),(42,'A - good',1,46),(43,'B - bad',0,46),(44,'A - good',1,47),(45,'B - good',1,47),(46,'C - good',1,47),(47,'D - bad',0,47),(48,'E - bad',0,47),(49,'F - bad',0,47);
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `inter_questions_quizzes`
--

LOCK TABLES `inter_questions_quizzes` WRITE;
/*!40000 ALTER TABLE `inter_questions_quizzes` DISABLE KEYS */;
INSERT INTO `inter_questions_quizzes` VALUES (14,10),(16,10),(17,10),(18,10),(19,10),(20,10),(21,10),(22,10),(23,10),(24,10),(13,12),(15,12),(25,12),(26,12),(27,12),(28,12),(29,12),(30,12),(31,12),(32,12),(30,15),(31,15),(44,16),(45,16),(46,16),(47,16);
/*!40000 ALTER TABLE `inter_questions_quizzes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (13,'Selet correct way(s) to set the variable VAR to 10.',1,1),(14,'Select all valid command lines with POSIX ls',2,1),(15,'What command is used to add an user to the system?',2,1),(16,'What is the admin command to program the system to shutdown in one hour?',2,1),(17,'Select all existing POSIX fiters.',2,1),(18,'Which of these terms are not related to file access restriction on UNIX systems?',2,1),(19,'Which command show a command \'s output at regular interval?',2,1),(20,'What the command \"tac\" does?',2,1),(21,'What is a CRON service?',2,1),(22,'the command \"ls -l\" gave this output \"drwxr-xr-x  2 user1 user2 4,0K 29/09/2018 23:06:20\". In this context, what is \"user2\"?',2,1),(23,'Select correct assertions about the command \"ln\"',2,1),(24,'What does the acronym \"BSD\" stand for?',2,1),(25,'What is an alias?',1,1),(26,'Are aliases POSIX compliants?',1,1),(27,'How do you get the data inside the array \"myArray\" at the index \"30\"?',1,1),(28,'Select all valid BASH 4.4 expressions.',1,1),(29,'What is the result of the expression \"$(( $RANDOM / 8192 ))\"?',1,1),(30,'Select all valid string variable declarations',1,1),(31,'What happens if you type this command in a BASH 4.5 interactive shell: echo \"Hello world!\"?',1,1),(32,'How can an alias be removed?',1,1),(33,'How to list defined aliases?',1,1),(34,'What is the result of this command-line: \"pushd .\" ?',1,1),(35,'Select correct implementation of this logic:\\n if the variable $a contains a value, output this value, else if $a is unset, output the text \"ERROR\"',1,1),(36,'What can you do with the \"exec\" internal command?',1,1),(37,'What is the meaning of this command:\\nexec 2>&1 > /dev/null',1,1),(38,'Explain the differences between these two expressions:\\n[ -n \"$v1\" -a -z \"$v2\"]\\nand\\n[ -n \"$v1\" ] && [ -z \"$v2\" ]',1,0),(39,'What is $PWD?',1,0),(40,'What is the use of the \"-c\" command-line option?',1,0),(41,'What is an interactive shell?',1,0),(42,'TEST – question with 4 good answers',4,1),(43,'TEST – question without related answer',4,1),(44,'TEST – question with 3 bad answers – right when NOTHING CHECKED',4,1),(45,'TEST – good answers: B,D',4,1),(46,'TEST – good answer: A',4,1),(47,'TEST – good answer: A,B,C',4,1);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `quizzes`
--

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;
INSERT INTO `quizzes` VALUES (1,'MCQ Quizz #1, theme #3','quizz-1-theme-3',3,1,1,0,NULL),(4,'TEST – quizz with no question','test-quizz-no-question-inside',4,1,0,0,NULL),(5,'free-text Quizz #5, theme #4, random','quizz-5',4,1,0,1,5),(7,'small BASH Quizz (5 random questions)','small-bash-quizz-5',1,1,1,1,5),(8,'small BASH Quizz (10 random questions, free-text)','small-bash-quizz-10',1,2,0,1,10),(10,'linux command-line tools','linux-tools',2,3,1,0,NULL),(11,'linux command-line tools (8 random questions)','linux-tools-random-8',2,3,0,1,8),(12,'BASH quizz #2 (MCQ)','bash-quizz-2',1,3,1,0,NULL),(14,'TEST – Quizz with bad slug, should send to a 404 err page','<test?bad=quizz+slug+>',3,1,1,0,NULL),(15,'TEST - quizz with a question without answer','test-quizz-with-a-question-without-answer',1,2,1,0,NULL),(16,'TEST - quizz with 4 MCQ questions, theme 1','test-4-questions-mcq',1,1,1,0,NULL),(17,'TEST - quizz with 4 random MCQ questions, theme 1','test-4-random-questions-mcq',1,1,1,1,4);
/*!40000 ALTER TABLE `quizzes` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `resultProposal`
--

LOCK TABLES `resultProposal` WRITE;
/*!40000 ALTER TABLE `resultProposal` DISABLE KEYS */;
/*!40000 ALTER TABLE `resultProposal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `resultSubmissions`
--

LOCK TABLES `resultSubmissions` WRITE;
/*!40000 ALTER TABLE `resultSubmissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `resultSubmissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `studentStatus`
--

LOCK TABLES `studentStatus` WRITE;
/*!40000 ALTER TABLE `studentStatus` DISABLE KEYS */;
INSERT INTO `studentStatus` VALUES (1,'asker','registered for mail exchanges – not a student'),(2,'registered','had success with the two MCQ, now registered as STUDENT'),(3,'student1','student, 1st part cursus, can pass mid-cursus tests to get higher grade'),(4,'student2','student, 2nd part cursus, had her mid-cursus test'),(5,'flunk','flunk – had lamentably failed mid-cursus test');
/*!40000 ALTER TABLE `studentStatus` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (4,'student1','stud','2000-10-10','student1@yopmail.net','',2),(5,'student2','study',NULL,'student2@yopmail.org','study2',3),(6,'student2','study','2000-01-01','student3@yopmail.net','study3',3),(7,'asker','nobdy',NULL,'asker@yopmail.org',NULL,1);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (2,'Teac','Her2','1900-02-02','teacher2@yopmail.org'),(1,'Teach','Er','1900-01-01','teacher1@yopmail.org'),(3,'third','Teacher','1900-03-03','teacher3@yopmail.net');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `themes`
--

LOCK TABLES `themes` WRITE;
/*!40000 ALTER TABLE `themes` DISABLE KEYS */;
INSERT INTO `themes` VALUES (1,'BASH programming','POSIX shell and BASH extensions test.'),(2,'linux commands','command-line interface and common commands'),(3,'Cat Facts','Can you answer to these questions about cats?'),(4,'test – theme #4','description for theme #4 – fugit nulla provident quisquam reprehenderit sed. Aperiam dicta fuga perspiciatis quos rem? Alias asperiores dolores ea maiores minus natus nostrum'),(5,'test – theme #5','description for theme #5: Aspernatur beatae, esse eum id illum iure nobis odio praesentium quo reiciendis repellat sequi veniam.');
/*!40000 ALTER TABLE `themes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
