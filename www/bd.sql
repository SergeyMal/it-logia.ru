SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE USER 'it-logia'@'%' IDENTIFIED WITH mysql_native_password BY 'uAnR2KqGr9024AED';GRANT USAGE ON *.* TO 'it-logia'@'%';ALTER USER 'it-logia'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;CREATE DATABASE IF NOT EXISTS `it-logia`;GRANT ALL PRIVILEGES ON `it-logia`.* TO 'it-logia'@'%'; 

use `it-logia`;
--
-- База данных: `it-logia`
--

-- --------------------------------------------------------

--
-- Структура таблицы `lesson`
--

DROP TABLE IF EXISTS `lesson`;
CREATE TABLE `lesson` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `youtube_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `complete` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `lesson`
--

INSERT INTO `lesson` (`id`, `user_id`, `name`, `comment`, `youtube_url`, `complete`) VALUES
(1, 0, 'Почему стоит пойти в программирование?', 'Почему стоит пойти в программирование?', '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/6Qb33YKGric\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>', 1),
(2, 0, 'Основы веб-разработки и используемые технологии', 'Основы веб-разработки и используемые технологии', '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/m8_xFg5JaZg\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>', 1),
(13, 0, 'Основные средства веб-разработчика', 'Основные средства веб-разработчика', '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/yGcYIKnGeBc\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>', 1),
(14, 0, 'Как лучше изучать программирование?', 'Как лучше изучать программирование?', '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/rCY1hKHsJPk\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>', 1),
(15, 10, 'Почему стоит пойти в программирование?', 'Почему стоит пойти в программирование?', '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/6Qb33YKGric\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>', 1),
(16, 10, 'Основы веб-разработки и используемые технологии', 'Основы веб-разработки и используемые технологии', '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/m8_xFg5JaZg\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>', 1),
(17, 10, 'Основные средства веб-разработчика', 'Основные средства веб-разработчика', '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/yGcYIKnGeBc\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>', 1),
(18, 10, 'Как лучше изучать программирование?', 'Как лучше изучать программирование?', '<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/rCY1hKHsJPk\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL,
  `login` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `auth_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sess_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `login`, `password`, `name`, `auth_key`, `sess_start`) VALUES
(10, 'test', '$2y$13$Alu3M3AZO1AJw4lB/Xgd6OWuDttAWKayy/ufCM5CckjVheG.D4d8C', 'Тест', 'J43xIFTHz98tUZIMf1b7M-T_sbGdiIfr', '2023-04-26 10:15:05');

--
-- Триггеры `user`
--
DROP TRIGGER IF EXISTS `Inser_lesson_new_user`;
DELIMITER $$
CREATE TRIGGER `Inser_lesson_new_user` AFTER INSERT ON `user` FOR EACH ROW BEGIN
INSERT INTO `lesson`(`user_id`, `name`, `comment`, `youtube_url`, `complete`)
  SELECT NEW.id, `name`, `comment`, `youtube_url`, 0
  FROM `lesson` WHERE `lesson`.user_id = 0;
END
$$
DELIMITER ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `lesson`
--
ALTER TABLE `lesson`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `lesson`
--
ALTER TABLE `lesson`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT для таблицы `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;