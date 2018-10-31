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
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `answerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(64) NOT NULL,
  `isCorrect` tinyint(1) NOT NULL DEFAULT '0',
  `questionId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`answerId`),
  KEY `fk_questionId` (`questionId`),
  CONSTRAINT `fk_questionId` FOREIGN KEY (`questionId`) REFERENCES `questions` (`questionId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES (19,'$VAR=\'10\'',0,13),(20,'$VAR = 10',0,13),(21,'VAR=10',1,13),(22,'$VAR=10',0,13),(23,'VAR=$(( 10 ))',1,13),(24,'VAR=$((10))',1,13),(25,'VAR = \"10\"',0,13),(26,'A shortcut to an arbitrary string in the shell',0,25),(27,'A shortcut to a command when used in place of a command',1,25),(28,'A shortcut to an executable file',0,25),(29,'yes',1,26),(30,'no',0,26),(31,'test answer #1 - good',1,42),(32,'test answer #2 - good',1,42),(33,'test answer #3 - good',1,42),(34,'test - bad',0,44),(35,'test - bad',0,44),(36,'test - bad',0,44),(37,'test - bad',0,44),(38,'A - bad',0,45),(39,'B - good',1,45),(40,'C - bad',0,45),(41,'D - good',1,45),(42,'A - good',1,46),(43,'B - bad',0,46),(44,'A - good',1,47),(45,'B - good',1,47),(46,'C - good',1,47),(47,'D - bad',0,47),(48,'E - bad',0,47),(49,'F - bad',0,47),(50,'ls --l --a',0,14),(51,'ls -a -l',1,14),(52,'ls --la',0,14),(53,'ls -al',1,14),(54,'useradd',1,15),(55,'addUser',0,15),(56,'createuser',0,15),(57,'adduser',1,15),(58,'shutdown -h 1h',0,16),(59,'shutdown -h +60m',0,16),(60,'shutdown -h +60',1,16),(61,'cat',1,17),(62,'tac',1,17),(63,'tr',1,17),(64,'grep',1,17);
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inter_questions_quizzes`
--

DROP TABLE IF EXISTS `inter_questions_quizzes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inter_questions_quizzes` (
  `questionId` int(10) unsigned NOT NULL,
  `quizzId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`questionId`,`quizzId`),
  KEY `fk_quizzId_interTbl` (`quizzId`),
  CONSTRAINT `fk_questionId_interTbl` FOREIGN KEY (`questionId`) REFERENCES `questions` (`questionId`),
  CONSTRAINT `fk_quizzId_interTbl` FOREIGN KEY (`quizzId`) REFERENCES `quizzes` (`quizzId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inter_questions_quizzes`
--

LOCK TABLES `inter_questions_quizzes` WRITE;
/*!40000 ALTER TABLE `inter_questions_quizzes` DISABLE KEYS */;
INSERT INTO `inter_questions_quizzes` VALUES (14,10),(16,10),(17,10),(18,10),(19,10),(20,10),(21,10),(22,10),(23,10),(24,10),(13,12),(15,12),(25,12),(26,12),(27,12),(28,12),(29,12),(30,12),(31,12),(32,12),(30,15),(31,15),(44,16),(45,16),(46,16),(47,16);
/*!40000 ALTER TABLE `inter_questions_quizzes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `questionId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `themeId` int(10) unsigned DEFAULT NULL COMMENT 'if set, the question can be used into a randomly-created quizzes (a quizz built from 𝑛 questions coming from a question pool)',
  `isMCQ` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'if is a MCQ, the answers are automatically correctables, and several rows from the "answers" table are related to this question',
  PRIMARY KEY (`questionId`),
  KEY `fk_themeId` (`themeId`),
  CONSTRAINT `fk_themeId` FOREIGN KEY (`themeId`) REFERENCES `themes` (`themeId`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (13,'Selet correct way(s) to set the variable VAR to 10.',1,1),(14,'Select all valid command lines with POSIX ls',2,1),(15,'What command(s), run as root, can be used to add an user to the system?',2,1),(16,'What is the command-line (run as admin) to make the system shutdown in one hour?',2,1),(17,'Select all existing POSIX fiters.',2,1),(18,'Which of these terms are not related to file access restriction on UNIX systems?',2,1),(19,'Which command show a command \'s output at regular interval?',2,1),(20,'What the command \"tac\" does?',2,1),(21,'What is a CRON service?',2,1),(22,'the command \"ls -l\" gave this output \"drwxr-xr-x  2 user1 user2 4,0K 29/09/2018 23:06:20\". In this context, what is \"user2\"?',2,1),(23,'Select correct assertions about the command \"ln\"',2,1),(24,'What does the acronym \"BSD\" stand for?',2,1),(25,'What is an alias?',1,1),(26,'Are aliases POSIX compliants?',1,1),(27,'How do you get the data inside the array \"myArray\" at the index \"30\"?',1,1),(28,'Select all valid BASH 4.4 expressions.',1,1),(29,'What is the result of the expression \"$(( $RANDOM / 8192 ))\"?',1,1),(30,'Select all valid string variable declarations',1,1),(31,'What happens if you type this command in a BASH 4.5 interactive shell: echo \"Hello world!\"?',1,1),(32,'How can an alias be removed?',1,1),(33,'How to list defined aliases?',1,1),(34,'What is the result of this command-line: \"pushd .\" ?',1,1),(35,'Select correct implementation of this logic:\\n if the variable $a contains a value, output this value, else if $a is unset, output the text \"ERROR\"',1,1),(36,'What can you do with the \"exec\" internal command?',1,1),(37,'What is the meaning of this command:\\nexec 2>&1 > /dev/null',1,1),(38,'Explain the differences between these two expressions:\\n[ -n \"$v1\" -a -z \"$v2\"]\\nand\\n[ -n \"$v1\" ] && [ -z \"$v2\" ]',1,0),(39,'What is $PWD?',1,0),(40,'What is the use of the \"-c\" command-line option?',1,0),(41,'What is an interactive shell?',1,0),(42,'TEST – question with 3 good answers',4,1),(43,'TEST – question without related answer',4,1),(44,'TEST – question with 3 bad answers – right when NOTHING CHECKED',4,1),(45,'TEST – good answers: B,D',4,1),(46,'TEST – good answer: A',4,1),(47,'TEST – good answer: A,B,C',4,1);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizzes`
--

DROP TABLE IF EXISTS `quizzes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizzes` (
  `quizzId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `slug` varchar(128) NOT NULL COMMENT 'the slug to use in the URL',
  `themeId` int(10) unsigned NOT NULL,
  `teacherId` int(10) unsigned NOT NULL COMMENT 'for now, this is the quizz''s creator, and the creator is also the only corrector – in the future, we can add an intermedary table if we want more correctors',
  `isMCQ` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'if true, the quizz contains only MCQ, and can be automatically corrected; if false, it contains (or can contains in case of randomly-generated quizz) free-text answers, and cannot be automatically corrected',
  `isRandom` tinyint(1) NOT NULL COMMENT 'if true, the quizz is made from random questions pulled from a pool, and the following column is valid',
  `nbQuestions` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`quizzId`),
  UNIQUE KEY `uq_name` (`name`),
  UNIQUE KEY `uq_slug` (`slug`),
  KEY `fk_themeId_of_quizzes` (`themeId`),
  KEY `fk_teacherId` (`teacherId`),
  CONSTRAINT `fk_teacherId` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`teacherId`),
  CONSTRAINT `fk_themeId_of_quizzes` FOREIGN KEY (`themeId`) REFERENCES `themes` (`themeId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizzes`
--

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;
INSERT INTO `quizzes` VALUES (4,'TEST – quizz with no question','test-quizz-no-question-inside',4,1,0,0,NULL),(5,'free-text Quizz #5, theme #4, random','quizz-5',4,1,0,1,5),(7,'small BASH Quizz (5 random questions)','small-bash-quizz-5',1,1,1,1,5),(8,'small BASH Quizz (10 random questions, free-text)','small-bash-quizz-10',1,2,0,1,10),(10,'linux command-line tools','linux-tools',2,3,1,0,NULL),(11,'linux command-line tools (8 random questions)','linux-tools-random-8',2,3,0,1,8),(12,'BASH quizz #2 (MCQ)','bash-quizz-2',1,3,1,0,NULL),(14,'TEST – Quizz with bad slug, should send to a 404 err page','<test?bad=quizz+slug+>',3,1,1,0,NULL),(15,'TEST - quizz with a question without answer','test-quizz-with-a-question-without-answer',1,2,1,0,NULL),(16,'TEST - quizz with 4 MCQ questions, theme 1','test-4-questions-mcq',1,1,1,0,NULL),(17,'TEST - quizz with 4 random MCQ questions, theme 1','test-4-random-questions-mcq',1,1,1,1,4);
/*!40000 ALTER TABLE `quizzes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultProposal`
--

DROP TABLE IF EXISTS `resultProposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultProposal` (
  `resultSubmissionId` int(10) unsigned NOT NULL,
  `questionId` int(10) unsigned NOT NULL,
  `answer` varchar(255) NOT NULL COMMENT 'in the case of an MCQ question: the textual representation of an array listing all chosen answers; in the case of a free-text question: the answered text.',
  PRIMARY KEY (`resultSubmissionId`,`questionId`),
  KEY `fk_questionId_of_resultProposal` (`questionId`),
  CONSTRAINT `fk_questionId_of_resultProposal` FOREIGN KEY (`questionId`) REFERENCES `questions` (`questionId`),
  CONSTRAINT `fk_resultSubmissionId` FOREIGN KEY (`resultSubmissionId`) REFERENCES `resultSubmissions` (`resultSubmissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultProposal`
--

LOCK TABLES `resultProposal` WRITE;
/*!40000 ALTER TABLE `resultProposal` DISABLE KEYS */;
/*!40000 ALTER TABLE `resultProposal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultSubmissions`
--

DROP TABLE IF EXISTS `resultSubmissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultSubmissions` (
  `resultSubmissionId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'the DB do not forbid a student to have several time the same quizz, so we do not use a compound primary key (studentId, quizzId)',
  `studentId` int(10) unsigned NOT NULL,
  `quizzId` int(10) unsigned NOT NULL,
  `submissionDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date and time the student submit his answers',
  PRIMARY KEY (`resultSubmissionId`),
  KEY `fk_studentId` (`studentId`),
  KEY `fk_quizzId` (`quizzId`),
  CONSTRAINT `fk_quizzId` FOREIGN KEY (`quizzId`) REFERENCES `quizzes` (`quizzId`),
  CONSTRAINT `fk_studentId` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultSubmissions`
--

LOCK TABLES `resultSubmissions` WRITE;
/*!40000 ALTER TABLE `resultSubmissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `resultSubmissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentStatus`
--

DROP TABLE IF EXISTS `studentStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studentStatus` (
  `statusId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(32) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`statusId`),
  UNIQUE KEY `uq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentStatus`
--

LOCK TABLES `studentStatus` WRITE;
/*!40000 ALTER TABLE `studentStatus` DISABLE KEYS */;
INSERT INTO `studentStatus` VALUES (1,'asker','registered for mail exchanges – not a student'),(2,'registered','had success with the two MCQ, now registered as STUDENT'),(3,'student1','student, 1st part cursus, can pass mid-cursus tests to get higher grade'),(4,'student2','student, 2nd part cursus, had her mid-cursus test'),(5,'flunk','flunk – had lamentably failed mid-cursus test');
/*!40000 ALTER TABLE `studentStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `studentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` char(64) NOT NULL,
  `lastName` char(64) NOT NULL,
  `birthDate` date DEFAULT NULL COMMENT 'becomes mandatory on inscription;',
  `email` varchar(128) NOT NULL,
  `pseudo` varchar(64) DEFAULT NULL COMMENT 'used to discriminate between users with same firstName/lastName/birthDate, optional only for the contact page',
  `statusId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `uq_email` (`email`),
  UNIQUE KEY `uq_pseudo` (`pseudo`),
  UNIQUE KEY `uq_names_birth_pseudo` (`firstName`,`lastName`,`birthDate`,`pseudo`),
  KEY `fk_statusId` (`statusId`),
  CONSTRAINT `fk_statusId` FOREIGN KEY (`statusId`) REFERENCES `studentStatus` (`statusId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (4,'student1','stud','2000-10-10','student1@yopmail.net','',2),(5,'student2','study',NULL,'student2@yopmail.org','study2',3),(6,'student2','study','2000-01-01','student3@yopmail.net','study3',3),(7,'asker','nobdy',NULL,'asker@yopmail.org',NULL,1);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers` (
  `teacherId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` char(64) NOT NULL,
  `lastName` char(64) NOT NULL,
  `birthDate` date NOT NULL,
  `email` varchar(128) NOT NULL,
  PRIMARY KEY (`teacherId`),
  UNIQUE KEY `uq_email` (`email`),
  UNIQUE KEY `uq_names_birth_pseudo` (`firstName`,`lastName`,`birthDate`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (2,'Teac','Her2','1900-02-02','teacher2@yopmail.org'),(1,'Teach','Er','1900-01-01','teacher1@yopmail.org'),(3,'third','Teacher','1900-03-03','teacher3@yopmail.net');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `themes`
--

DROP TABLE IF EXISTS `themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `themes` (
  `themeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`themeId`),
  UNIQUE KEY `uq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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

-- Dump completed on 2018-10-31 23:26:43
