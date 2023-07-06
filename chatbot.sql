-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2023 at 04:49 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chatbot`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_db`
--

DROP TABLE IF EXISTS `admin_db`;
CREATE TABLE `admin_db` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(100) NOT NULL,
  `admin_password` varchar(100) NOT NULL,
  `confirm_password` varchar(100) NOT NULL,
  `admin_mail` varchar(100) NOT NULL,
  `is_active` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_db`
--

INSERT INTO `admin_db` (`admin_id`, `admin_name`, `admin_password`, `confirm_password`, `admin_mail`, `is_active`) VALUES
(39, 'kuldeep', 's', 's', 'bk@gmail.com', 0),
(40, 'jhanjar', 'j', 'j', 'j@gmail.com', 1),
(41, 'kartik', 'kartik123', 'kartik123', 'kartik123@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `intents`
--

DROP TABLE IF EXISTS `intents`;
CREATE TABLE `intents` (
  `tags` varchar(1000) NOT NULL,
  `patterns` text NOT NULL,
  `responses` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `intents`
--

INSERT INTO `intents` (`tags`, `patterns`, `responses`) VALUES
('GREETINGS', 'HI,HII,HELLO,HEY,HOLA', 'HELLO!WELCOME TO THE GLS UNIVERSITY FCAIT DEPARTMENT. HOW CAN I HELP YOU?'),
('COURSE', 'COURSE,CLASS,PROGRAM,2', 'The Master Of Computer Application course was initiated in India during 1984-85 by the University Grants Commission(UGC) and Department of Electronics to meet the shortage of skilled manpower in the country. Looking at the continued demand for trained manpower in the field of Information Technology,the Gujarat Law Society decided to contribute to the area of education in IT by establishing the Institute of Computer Technology offering prestigious MCA course in July 1999. The All India Council of Technical Education has approved this institute as Post Graduate center for conducting 2 years full-time MCA course under self-financing scheme with the intake of 120. After the establishment of the GLS University in 2015, the MCA program is running under the Faculty of Computer Technology,formerly known as GLS(Shailesh R. Parikh) Institude Of Computer Technology by foolowing the same norms of the AICTE and ACPC.'),
('ELIGIBILITY', 'ELIGIBILITY,CRITERIA,ADMISSION,4', '• For admission to MCA, the candidate must have Passed BCA/ Bachelor Degree in \r\nComputerScience Engineering orEquivalent Degree.OR\r\n• Passed B.Sc./ B.Com./ B.A. with Mathema.• Obtained at least 50% marks (45% marks in case of candidates belonging to reserved category) in the qualifying Examinaton'),
('ADMISSION', 'ADMISSION,PROCEDURE', '• The admission to MCAis done in a centralized manner by the Admission Committee of Professional Course(ACPC). Out of the total seats, 50% of seats are filled under management Quota by the institute as per ACPC norms.'),
('INFRASTRUCTURE', 'INFRASTRUCTURE,FACILITIES,CLASSROOM,ROOM,CAMPUS,LABORATORY,HIGHLIGHTS,COMPUTERS,6', '• Well furnished, air-conditioned auditorium.|• Well-equipped computerlaboratories forhands-on practicals based on the curriculum.|• Separate experimental laboratory having Open Source Software, IOT devices available for unscheduled experiments.|• Two 100 Mbps internet lines.|• 150+ computers with Ubuntu 18.04 LTS and 60 computers with Apple Mac OS.|• Campus wide WiFi.|• More than 9,000+ books and 4000+ ebooks in ComputerScience and Information Technology.|• More than 50 journals including open access journals subscribed on ComputerScience and related subjects.|• An air-conditioned and spacious reading room on the premises of the library.|• The institute provides residence facilities with fully furnished AC/Non-AC rooms for boys and girls in tie up with Stanza living.'),
('FACULTY', 'FACULTY,PROFESSOR,TEACHER,3', '1.)Dr.Savita Gandhi,Ph.D & MSC.(Qualification),Dean(Designation).|\r\n2)Dr.Harshal Arolkar,Ph.D & MCA & B.Sc.(Qualification),HOD & Professor(Designation).|\r\n3)Dr.Devarshi Mehta,Ph.D. & MCA & B.Sc.(Qualification),Asso.Professor(Designation). |\r\n4)Dr.Krupa Mehta,Ph.D. & MCA & BCA(Qualification),Asst.Professor(Designation).|    \r\n5)Dr.Arpit Jain,Ph.D. & MCA & BCA(Qualification),Asst.Professor(Designation). |  \r\n6)Dr.Prerna Agrawal,Ph.D. & MCA & BCA(Qualification),Asst.Professor(Designation).|\r\n7) Ms. Vinita Nair, Ph.D. Pursuing & MCA & BCA(Qualification),Asst.Professor(Designation).|\r\n8) Ms. Snehal Shukla, Ph.D. & MCA & BCA(Qualification),Asst.Professor(Designation).|'),
('HOSTEL', 'HOSTEL,RESIDENCE,9', 'The institute provides residence facilities with fully furnished AC/Non-AC rooms for boys and girls in tie up with STANZA LIVING.'),
('ATTENDANCE', 'ATTENDANCE,PRESENCE,APPEARANCE,7', 'In Gls University 80% attendance is mandatory fo all students.'),
('PLACEMENTS', 'PLACEMENTS,COMPANY,placement,placed,8', 'FCT MCA program provides the placement right in the 3rd semester it self to most of theirstudents.|\r\nThe placement is normally hovering around 90%. |\r\nWe invite nearly 100 companies every year with various requirements. The industry liaison and cordial relation with the industry is the key component in driving these excellent results.|\r\nWe have a placement cell that some of our experienced faculties with good industry linkage manages. Here is the list of some of the companies that visit GLS for placements.|\r\n1)Anblicks|\r\n2)Aspire Software Solutions|\r\n3)Bacancy|\r\n4)iView|\r\n5)Zeus Learning|\r\nTo See furthur companies https://drive.google.com/file/d/1g6N_qJs-KaJAnIDmSVX89fdpDg1FI6Cx/view?usp=sharing'),
('CONTACT', 'CONTACT,HELP,CALL,PHONE,MAIL,WEBSITE,ADDRESS,11', 'Address:GLS Campus, Opp Law Garden. Ellisbridge. Ahmedabad-380006|\r\nPhone : +91(079) 26447636| \r\nFax : +91(079) 26445958 |\r\nMail At : mca@glsuniversity.ac.in |\r\nWebsite : https://www.glsuniversity.ac.in/'),
('@', '@', '1.Fee inquiry.|\r\n2.Course Details|\r\n3.Faculty of MCA|\r\n4.Eligibility for admission|\r\n5.Brochure|\r\n6.Infrastructure of college|\r\n7.Attendance|\r\n8.Placements scenario|\r\n9.Hostel support|\r\n10.Scholarship|\r\n11.Contact details\r\n\r\n'),
('brochure', 'brochure,flyer,more about college,more,5', 'Here is the Brochure of GLS MCA\r\nhttps://drive.google.com/file/d/1g6N_qJs-KaJAnIDmSVX89fdpDg1FI6Cx/view?usp=sharing'),
('Greetings2', 'Okay,ok,got it,thank you,thanx,thanks', 'WELCOME 😊,Let me know if you have any inquiries regarding MCA in GLS.|\r\nto get contact details you can Press 6'),
('SCHOLARSHIP', 'FREESHIP, SCHOLAR SHIP,SCHOLARSHIP, SCHOLLARSHIP,10', 'If you are applicable for any of the scholarship given by the government than you can fill the form as per government guidelines. College provides scholarship to those students who comes in 1st 3 place in marks'),
('DOCUMENTS', 'DOCUMENTS,PAPERS', 'To Take Admission you need copy of following documents to submit in college |\r\n1) 10th Marksheet |\r\n2) 12th Marksheet |\r\n3) Bachelor Degree All Marksheet |\r\n4) School Leaving Certificate |\r\n5) Aadhar card |\r\n6) PAN Card |\r\n7) Caste Certificate(if applicable) |\r\n8) Passportsize Photo |\r\n9) CMAT Score Card(if admission taking through CMAT Entrance Exam)\r\n\r\n'),
('SEMINARS', 'VISITS,SEMINARS,SEMMINARS,CONVENTION', 'In our college there were seminars/visits based on topics like|\r\n1)Advancement in blockchain|\r\n2)Beat the diabetes|\r\n3)CSR Activity|\r\n4)Interview tips and Resume building|\r\n5)Software testing|\r\n6)Hackathon|\r\n7)Industrial visit|\r\nIf you want to know in detail Than https://drive.google.com/file/d/1OqciXqlPRFwcnr3JVzLkL41G34Bn_rMv/view?usp=sharing'),
('ACHIEVEMENTS', 'ACHIEVEMENTS,WINNING, REACHING', 'MCA students Ms.Nancy patel , Mr.Monarch\r\njain, Ms . Shivani shah and Ms.Vrushika shah\r\nwon the 1s t prize in Culinary Activity at GLSU\r\nYouth Festival 2023.|\r\nMCA student Ms.Shreya Ramolia won the\r\nsilver medal in 400m race in the IM Nanavati\r\nSports 2023 organized by GLSU.\r\n\r\n\r\n'),
('fee', 'fees,charge for mca,fee,amount payable,mca fee,mca fees,1', 'The fee structure as for MCA is Rs.59,000 per sem . And MCA has 4 semesters.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_db`
--
ALTER TABLE `admin_db`
  ADD PRIMARY KEY (`admin_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_db`
--
ALTER TABLE `admin_db`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
