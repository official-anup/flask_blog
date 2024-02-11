-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 11, 2024 at 06:02 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flask_blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `srno` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` mediumtext NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`srno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'Anup Anil Alone', 'anupalone8956196120@gmail.com', '+917666299481', 'sadfghjkljhgfdsa', '2024-02-09 11:50:54'),
(2, 'Anup Anil Alone', 'anupalone8956196120@gmail.com', '+917666299481', 'asdfdgfhgjhmkj,lkkjmhgfdsa', '2024-02-09 11:55:25'),
(3, 'Anup Anil Alone', 'anupalone8956196120@gmail.com', '+917666299481', 'wefrgfhjklkjhgfdsa', '2024-02-09 11:57:31'),
(4, 'Anup Anil Alone', 'anupalone8956196120@gmail.com', '+917666299481', 'asdsfgfbhj', '2024-02-09 11:58:43'),
(5, 'Anup Anil Alone', 'anupalone8956196120@gmail.com', '+917666299481', 'abcdefgh', '2024-02-09 11:59:30'),
(6, 'Anup Anil Alone', 'anupalone8956196120@gmail.com', '+917666299481', 'kuch nh', '2024-02-09 14:06:17'),
(7, 'Anup Anil Alone', 'anupalone8956196120@gmail.com', '+917666299481', 'sdfghjhkjkjjhmgffdsdas', '2024-02-09 14:07:37'),
(8, 'Anup Anil Alone', 'anupalone8956196120@gmail.com', '+917666299481', 'sdfgdbfhngjmhk', '2024-02-09 14:20:13'),
(9, 'Anup Anil Alone', 'anupalone8956196120@gmail.com', '+917666299481', 'ho gya kya', '2024-02-09 14:31:24'),
(10, 'montu alone', 'montu@gmail.com', '9822342497', 'phone khrab zala', '2024-02-09 15:29:43'),
(11, 'Anil', 'monti@gmail.com', '1212121212', 'qqqqqqqqqqqqqqqqqqqqq', '2024-02-09 15:30:56');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `srno` int(11) NOT NULL,
  `title` varchar(1000) NOT NULL,
  `sub_title` varchar(8000) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `content` mediumtext NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_file` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`srno`, `title`, `sub_title`, `slug`, `content`, `date`, `img_file`) VALUES
(1, 'What is a blog?', 'Definition, types, benefits and why you need the blogs in your life', 'first', 'Blogs are a type of regularly updated websites that provide insight into a certain topic. The word blog is a combined version of the words “web” and “log.” At their inception, blogs were simply an online diary where people could keep a log about their daily lives on the web. They have since morphed into an essential forum for individuals and businesses alike to share information and updates. In fact, many people even make money blogging as professional full-time bloggers. \r\n\r\n\r\nAs the publishing world has evolved, and more of it has moved online, blogs have come to occupy a central position in this digital content world. Blogs are a source of knowledge, opinion and concrete advice. While not yet posed to replace journalism as an art form, people increasingly look to trusted blogs to find answers to their questions, or to learn how to do something. \r\n\r\n\r\nBlogs are always evolving both in terms of how they\'re created and what they are used for. They can be a vehicle for creativity and for marketing. They\'re also increasingly created and read on mobile apps, as mobile blogging also comes into its own.', '2024-02-10 16:43:24', ''),
(2, 'Everything we know about the universe – and a few things we don\'t', 'How big is the universe? What shape is it? How fast is it expanding? And when will it end? We answer these questions and more in our essential guide to the current state of cosmological knowledge', 'second', 'A CENTURY ago, if you asked a cosmologist the universe’s age, the answer may well have been “infinite”. It was a neat way to sidestep the question of how it formed, and the idea had been enshrined in 1917 when Albert Einstein presented his model of a static universe through his general theory of relativity.\r\n\r\nGeneral relativity describes gravity, the force that sculpts the universe, as the result of mass warping its fabric, space-time. In the mid-1920s, astrophysicist George Lemaître showed that according to the theory, the universe wasn’t static but expanding– and would thus have been smaller in the past.\r\n\r\nLemaître’s idea that everything there is was once contained in a single “primordial atom” was transformed in the 1960s, when astronomers discovered the most ancient light in the universe, the cosmic microwave background. This indicated that everything had begun in a hot, dense state: the big bang.', '2024-02-09 17:12:38', ''),
(3, 'Ever wonder how YouTube works?', 'We’ve created How YouTube Works — a new website designed to answer the questions we most often receive about what we\'re doing to foster a responsible platform for our community, and explain our products and policies in detail.', 'thired', 'YouTube has always been a place where people come to be informed, inspired, and delighted. Over the past few months, as our daily lives have changed in response to the coronavirus (COVID-19) pandemic, we’ve seen people turning to YouTube more than ever. As part of our ongoing commitment to transparency, we’ve created How YouTube Works — a new website designed to answer the questions we most often receive about what we\'re doing to foster a responsible platform for our community, and explain our products and policies in detail. How YouTube Works will launch in the U.S. today with plans to launch in more countries over time, starting in mid-June.How YouTube Works addresses some of the important questions we face every day about our platform — involving topics such as child safety, harmful content, misinformation, and copyright, as well as tackling timely issues as they arise, like how we have responded to the COVID-19 crisis and how we support elections. Within the site, we explain how we apply our responsibility principles (the Four Rs) — which work alongside our commitment to users’ security — to tackle these important questions.', '2024-02-09 19:03:16', ''),
(4, 'Chicken facts: funny to thought-provoking', 'Despite many misconceptions, these chicken facts reveal these feathered creatures to be clever, emotional beings. Like all other animals, they deserve our respect.', 'fourth', 'One of the sweetest things you’ll ever hear is that hens chirp to their babies while they’re in the eggs, and the chicks chirp back! They also make around 30 different calls to communicate with each other, expressing everything from “thanks for the food” to “tWhen a chicken is happy, cosy, and safe, they will close their eyes and purr softly. You’ll just have to trust us on this one, or head to TikTok.here’s a predator in the coop” Chickens don’t just recognise other chickens. These faces included those of humans! Chickens even remember positive or negative experiences with the faces they recognise and pass that information on to members of their flocks. According to this study, they can distinguish between friends and strangers. ', '2024-02-09 19:07:20', ''),
(6, 'tttttttttttttt', 'ssssssssssss', 'sssssssssssss', 'cccccccccccccccccccc', '2024-02-10 17:49:08', 'img.jpg'),
(7, 'ssssssssssssssssss', 'ssssssssssss', 'sssssssssssss', 'cccccccccccccccccccc', '2024-02-10 17:49:33', 'img.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`srno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`srno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `srno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `srno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
